`import Ember from 'ember'`
`import Instruction from '../models/instruction'`
`import config from '../config/environment'`

buildErrors = (response) -> (
  Ember.get(response, 'meta.errors') || [{
    _default: defaultErrorMessage
  }]
)

defaultErrorMessage = 'There was a problem communicating with our servers. Please try again later'

SmartlinkSaveMixin = Ember.Mixin.create(

  errors: {}

  defaultTimeoutThresholdMillis: 20000

  defaultInstructionPollingInterval: 1000

  defaultSaveMessage: 'Your changes have been saved to SmartLink Network, but will still need to be transmitted to your controller to take effect.'

  baseUrl: Ember.computed -> config.apiUrl

  openLoadingModal: (message) -> (
    if !@get('loadingModal')
      Ember.Logger.debug('Cannot open loading modal, loadingModal does not exist!')
      return
    @get('loadingModal').send('open', message)
  )

  closeLoadingModal: -> (
    if !@get('loadingModal')
      Ember.Logger.debug('Cannot close loading modal, loadingModal does not exist!')
      return
    @get('loadingModal').send('close')
  )

  errorMessages: Ember.computed 'errors', -> (
    messages = []
    Ember.$.each(@get('errors'), (field, errors) ->
      name = Ember.String.capitalize(field.split('_').join(' '))
      errors.forEach (msg) ->
        messages.push "#{name} #{msg}"
    )
    return messages
  )

  save: (options={}) -> (
    self = this

    if options.saveMessage == false
      saveMessage = ''
    else
      saveMessage = options.saveMessage ||  @defaultSaveMessage

    @openLoadingModal(saveMessage) unless options.showLoadingModal == false

    unless options.params?
      options.params = {}

    timeoutWatcher = null
    instructionStatusPoller = null

    timeoutThresholdMillis = options.timeoutThresholdMillis || @defaultTimeoutThresholdMillis

    allParams = Ember.merge(options.params, {
      timestamp: new Date().getTime()
    })

    httpMethod = options.httpMethod || 'PATCH'

    savePromise = new Ember.RSVP.Promise (resolve, reject) -> (
      timeoutWatcher = Ember.run.later(this, ->
        reject new Error(options.errorMessage || defaultErrorMessage)
      , timeoutThresholdMillis)
      ajaxOptions = {
        type: httpMethod
        data: JSON.stringify(allParams)
        dataType: 'json'
        contentType: 'application/json'
        success: (response) ->
          Ember.Logger.debug("Save, server responsed with success: ", response)
          if Ember.get(response, 'meta.success')
            resolve(response)
          else
            reject buildErrors(response)
        error: (xhr) ->
          reject buildErrors(xhr.responseJSON)
      }

      Ember.Logger.debug("Save - #{httpMethod}: #{options.url}, ajax options:",
        ajaxOptions)

      Ember.$.ajax(options.url, ajaxOptions)
    )

    savePromise.then( (response) ->
      self.set('errors', {})

      loadingModal = self.get('loadingModal')

      if options.pollInstructionStatus
        pollingIntervalMillis = options.pollingIntervalMillis || self.defaultInstructionPollingInterval

        self.get('store').pushPayload('instruction', response.result)
        return self.get('store').find('instruction', response.result.instruction.id).then (instruction) ->
          self.pollInstructionStatus(pollingIntervalMillis, instruction)


      if options.successRoute?
        self.transitionToRoute(options.successRoute, options.successModel)
        return

      if loadingModal?
        loadingModal.send('finished')
      else
        Ember.Logger.debug('Cannot send finished action to loading modal, loadingModal does not exist!')

    ).catch( (errors) ->
      self.closeLoadingModal()
      self.set 'errors', errors unless options.pollInstructionStatus
    ).finally ->
      Ember.run.cancel(timeoutWatcher) if timeoutWatcher
      Ember.run.cancel(instructionStatusPoller) if instructionStatusPoller

    return savePromise
  )

  saveAll: (options=[]) -> (
    self = this

    if options.saveMessage == false
      saveMessage = ''
    else
      saveMessage = options.saveMessage || @defaultSaveMessage

    @openLoadingModal(saveMessage)

    unless options.params?
      options.params = {}

    timeoutThresholdMillis = options.timeoutThresholdMillis || @defaultTimeoutThresholdMillis
    httpMethod = options.httpMethod || 'PATCH'

    allPromises = Ember.RSVP.all(options.map (opts) ->
      timeoutWatcher = null

      savePromise = new Ember.RSVP.Promise (resolve, reject) -> (
        timeoutWatcher = Ember.run.later(this, ->
          reject new Error(opts.errorMessage || options.errorMessage || defaultErrorMessage)
        , timeoutThresholdMillis)

        allParams = Ember.merge(opts.params, {
          timestamp: new Date().getTime()
        })

        ajaxOptions = {
          type: httpMethod
          data: JSON.stringify(allParams)
          dataType: 'json'
          contentType: 'application/json'
          success: (response) ->
            Ember.Logger.debug("Save, server responsed with success: ", response)
            if Ember.get(response, 'meta.success')
              resolve(response)
            else
              reject buildErrors(response)
          error: (xhr) ->
            reject buildErrors(xhr.responseJSON)
        }

        Ember.Logger.debug("Save - #{httpMethod}: #{options.url}, ajax options:",
          ajaxOptions)

        Ember.$.ajax(opts.url, ajaxOptions)
      )

      savePromise.finally ->
        Ember.run.cancel(timeoutWatcher) if timeoutWatcher

      return savePromise
    )

    allPromises.then( (results) ->
      self.set('errors', {})
      if options.successRoute?
        self.transitionToRoute(options.successRoute, options.successModel)
      else
        if self.get('loadingModal')?
          self.get('loadingModal').send('finished')
        else
          Ember.Logger.debug('Cannot send finished action to loading modal, loadingModal does not exist!')
    ).catch( (errors) ->
      self.closeLoadingModal()
      self.set 'errors', errors
    )

    return allPromises
  )

  pollInstructionStatus: (delayMillis, instruction) ->
    delayMillis = delayMillis || @defaultInstructionPollingInterval
    statusId = Ember.get(instruction, 'statusId')
    loadingModal = @get('loadingModal')
    self = this

    Ember.Logger.debug 'Polling instruction status: ', statusId

    switch statusId
      when Instruction.STATUS_ERROR
        Ember.Logger.error "Instruction failed", instruction
        alert "There was a problem communicating with your device. Please try again later."
        @closeLoadingModal()
      when Instruction.STATUS_FINISHED
        Ember.Logger.debug 'Instruction finished successfully', instruction
        instruction.set('controller.hasUnsentChanges', false)
        loadingModal.send('finished') if loadingModal?
        return
      else
        instruction.reload().then (instruction) ->
          Ember.run.later(self, self.pollInstructionStatus, delayMillis, instruction, delayMillis)

  transmitUrl: (smartlinkControllerId) ->
    "#{@get('config.apiUrl')}/api/v2/controllers/#{smartlinkControllerId}/transmit"

  receiveUrl: (smartlinkControllerId) ->
    "#{@get('config.apiUrl')}/api/v2/controllers/#{smartlinkControllerId}/receive"

  actions: {
    loadingAbandoned: ->
      @closeLoadingModal()

    loadingFinished: ->
      @closeLoadingModal()

    transmit: (smartlinkController) ->
      Ember.Logger.debug 'SmartlinkSaveMixin transmit action called, with smartlink controller:', smartlinkController
      @save(
        url: @transmitUrl(smartlinkController.get('id'))
        pollInstructionStatus: true
        saveMessage: 'Successfully saved your settings to the Smartlink controller'
      ).catch( (errors) ->
        alert errors.join('. ')
      )

    receive: (smartlinkController) ->
      Ember.Logger.debug 'SmartlinkSaveMixin receive action called, with smartlink controller', smartlinkController
      @save(
        url: @receiveUrl(smartlinkController.get('id'))
        pollInstructionStatus: true
        saveMessage: 'Successfully received settings from your Smartlink controller'
      ).then( =>
        smartlinkController.set('hasUnsentChanges', false)
      ).catch( (errors) ->
        alert errors.join('. ')
      )
  }
)

`export default SmartlinkSaveMixin`
