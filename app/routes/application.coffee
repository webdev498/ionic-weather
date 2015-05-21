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

`export default ApplicationRoute`
