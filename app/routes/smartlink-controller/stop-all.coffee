`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerStopAllRoute = Ember.Route.extend AuthenticatedRouteMixin,
  setupController: (controller, model) ->
    controller.set('isLoading', false)

`export default SmartlinkControllerStopAllRoute`
