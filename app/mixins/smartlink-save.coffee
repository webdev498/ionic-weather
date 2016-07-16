`import Ember from 'ember'`

buildErrors = (response) -> (
  Ember.get(response, 'meta.errors') || [{
    _default: defaultErrorMessage
  }]
)

defaultErrorMessage = 'There was a problem communicating with our servers. Please try again later'

SmartlinkSaveMixin = Ember.Mixin.create(

  errors: {}

  defaultTimeoutThresholdMillis: 20000

  config: Ember.computed ->
    @container.lookupFactory('config:environment')

  baseUrl: Ember.computed 'config.apiUrl', ->
    @get('config.apiUrl')

  openLoadingModal: -> (
    if !@get('loadingModal')
      Ember.Logger.debug('Cannot open loading modal, loadingModal does not exist!')
      return
    @get('loadingModal').send('open')
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
    @openLoadingModal() unless options.showLoadingModal == false

    unless options.params?
      options.params = {}

    timeoutWatcher = null
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

    savePromise.then( ->
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
    ).finally ->
      Ember.run.cancel(timeoutWatcher) if timeoutWatcher

    return savePromise
  )

  saveAll: (options=[]) -> (
    self = this
    @openLoadingModal()

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

  transmitUrl: (smartlinkControllerId) ->
    "#{@get('config.apiUrl')}/api/v2/controllers/#{smartlinkControllerId}/transmit"

  actions: {
    loadingAbandoned: ->
      @closeLoadingModal()

    transmit: (smartlinkController) ->
      Ember.Logger.debug 'TransmitMixin transmit action called, with smartlink controller:', smartlinkController
      @save(
        url: @transmitUrl(smartlinkController.get('id'))
      ).catch( (errors) ->
        alert errors.join('. ')
      ).then( =>
        smartlinkController.set('hasUnsentChanges', false)
      )
  }
)

`export default SmartlinkSaveMixin`
