`import Ember from 'ember'`

SmartlinkSaveMixin = Ember.Mixin.create(

	config: Ember.computed ->
    @container.lookupFactory('config:environment')

  baseUrl: Ember.computed 'config.apiUrl', ->
    @get('config.apiUrl')

	defaultTimeoutThresholdMillis: 20000

	openLoadingModal: ->
		if !@get('loadingModal')
			Ember.Logger.debug('Cannot open loading modal, loadingModal does not exist!')
			return
		@get('loadingModal').send('open')

	save: (options={}) ->
		self = this
		@openLoadingModal()

		timeoutWatcher = null
		timeoutThresholdMillis = options.timeoutThresholdMillis || @defaultTimeoutThresholdMillis

		defaultErrorMessage = 'There was a problem communicating with our servers. Please try again later'

		allParams = Ember.merge(options.params, {
			timestamp: new Date().getTime()
		})

		httpMethod = options.httpMethod || 'PATCH'

		savePromise = new Ember.RSVP.Promise (resolve, reject) ->
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
						self.transitionToRoute(options.successRoute, options.successModel)
					else
						reject new Error(defaultErrorMessage, response)
				error: ->
					reject new Error(defaultErrorMessage)
			}

			Ember.Logger.debug("Save - #{httpMethod}: #{options.url}, ajax options:", 
				ajaxOptions)

			Ember.$.ajax(options.url, ajaxOptions)

		savePromise.finally -> 
			Ember.run.cancel(timeoutWatcher) if timeoutWatcher
)

`export default SmartlinkSaveMixin`
