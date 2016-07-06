`import Ember from 'ember'`

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
    @openLoadingModal()

    timeoutWatcher = null
    timeoutThresholdMillis = options.timeoutThresholdMillis || @defaultTimeoutThresholdMillis

    defaultErrorMessage = 'There was a problem communicating with our servers. Please try again later'

    allParams = Ember.merge(options.params, {
      timestamp: new Date().getTime()
    })

    httpMethod = options.httpMethod || 'PATCH'

    savePromise = new Ember.RSVP.Promise (resolve, reject) -> (
      timeoutWatcher = Ember.run.later(this, ->
        reject new Error(options.errorMessage || defaultErrorMessage)
      , timeoutThresholdMillis)

      buildErrors = (response) -> (
        Ember.get(response, 'meta.errors') || [{
          _default: defaultErrorMessage
        }]
      )

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
      self.transitionToRoute(options.successRoute, options.successModel)
    ).catch( (errors) ->
      self.closeLoadingModal()
      self.set 'errors', errors
    ).finally ->
      Ember.run.cancel(timeoutWatcher) if timeoutWatcher

    return savePromise
  )
)

`export default SmartlinkSaveMixin`
