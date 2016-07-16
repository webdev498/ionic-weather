`import Ember from 'ember';`
`import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin'`

ApplicationRoute = Ember.Route.extend ApplicationRouteMixin,
  sites: Ember.inject.service('sites')

  actions:
    openLink: (url) ->
      window.open url, '_system'

    logOut: ->
      @get('session').invalidate()
      @get('sites').clearCache()

    sessionInvalidationSucceeded: ->
      Ember.Logger.debug 'ApplicationRoute sessionInvalidationSucceeded, redirecting to login route'
      @transitionTo('login')

    error: (error, transition) ->
      Ember.Logger.debug "ApplicationRoute error: #{error}, transition.targetName: #{transition.targetName}"
      if transition.targetName is 'index' or transition.targetName is 'sites'
        Ember.Logger.error 'Unhandled routing error'
        throw new Error('Unhandled routing error', error, transition)
      else
        Ember.Logger.error('Unhandled routing error, redirecting to index', error, transition)
        @transitionTo('index')


`export default ApplicationRoute`
