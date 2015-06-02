`import Ember from 'ember';`
`import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin'`

ApplicationRoute = Ember.Route.extend ApplicationRouteMixin,
  sites: Ember.inject.service('sites')

  actions:
    openLink: (url) ->
      window.open url, '_system'

    logOut: ->
      @get('session').invalidate()

    sessionInvalidationSucceeded: ->
      @transitionTo('login')

    error: (error, transition) ->
      if transition.targetName is 'index'
        throw new Error('Unhandled routing error', error, transition)
      else
        Ember.Logger.error('Unhandled routing error, redirecting to index', error, transition)
        @transitionTo('index')

`export default ApplicationRoute`
