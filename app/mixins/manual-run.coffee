`import Ember from 'ember'`
`import Instruction from '../models/instruction'`

ManualRunMixin = Ember.Mixin.create
  needs: ['smartlinkController']

  store: Ember.inject.service('store:main')

  smartlinkController: Ember.computed.alias('controllers.smartlinkController.model')

  config: Ember.computed -> @container.lookupFactory('config:environment')

  timeoutThresholdMillis: 20000

  url: Ember.computed 'config.apiUrl', ->
    "#{@get('config.apiUrl')}/api/v2/controllers/#{@get('smartlinkController.id')}/manual_run"

  submitManualRun: (manualRunParams) ->
    self = this

    allParams = {
      run_action: 'start'
      timestamp: new Date().getTime()
    }

    Ember.merge(allParams, manualRunParams)

    url = @get('url')

    timeoutWatcher = null

    defaultErrorMessage = 'There was a problem communicating with your device. \
      Please try again later'

    manualRunPromise = new Ember.RSVP.Promise (resolve, reject) ->

      timeoutWatcher = Ember.run.later(this, ->
        reject new Error(defaultErrorMessage)
      self.timeoutThresholdMillis)

      ajaxOptions = {
        type: 'POST'
        data: allParams
        success: (response) ->
          if Ember.get(response, 'meta.success')
            self.get('store').pushPayload('instruction', response.result)
            instruction = self.get('store').find('instruction', response.result.instruction.id)
            resolve(instruction)
          else
            message = Ember.get(response, 'result.instruction.exception')
            reject new Error(message)
        error: ->
          reject new Error(defaultErrorMessage)
      }

      Ember.$.ajax(url, ajaxOptions)

    manualRunPromise
      .finally ->
        Ember.run.cancel(timeoutWatcher) if timeoutWatcher

    return manualRunPromise


`export default ManualRunMixin`
