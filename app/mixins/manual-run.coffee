`import Ember from 'ember'`

ManualRunMixin = Ember.Mixin.create
  needs: ['smartlinkController']

  smartlinkController: Ember.computed.alias('controllers.smartlinkController.model')

  config: Ember.computed -> @container.lookupFactory('config:environment')

  isLoading: false

  timeoutThresholdMillis: 20000

  url: Ember.computed 'config.apiUrl', ->
    "#{@get('config.apiUrl')}/api/v2/controllers/#{@get('smartlinkController.id')}/manual_run"

  submitManualRun: (manualRunParams) ->
    self = this
    @set 'isLoading', true

    syncFailed = (message) ->
      message = message or \
        'There was an error while syncing with your device.  Please try again later.'
      alert message

    timeoutWatcher = Ember.run.later(this, syncFailed, @timeoutThresholdMillis)

    allParams = {
      run_action: 'start'
      timestamp: new Date().getTime()
    }

    Ember.merge(allParams, manualRunParams)

    url = @get('url')

    manualRunPromise = new Ember.RSVP.Promise (resolve, reject) ->
      ajaxOptions = {
        type: 'POST'
        data: allParams
        success: (response) ->
          if Ember.get(response, 'meta.success')
            resolve(response)
          else
            message = Ember.get(response, 'result.instruction.exception')
            reject(message)
        error: ->
          reject()
      }

      Ember.$.ajax(url, ajaxOptions)

    manualRunPromise
      .catch (reason)->
        syncFailed(reason)
      .finally ->
        Ember.run.cancel(timeoutWatcher)

    manualRunPromise


`export default ManualRunMixin`
