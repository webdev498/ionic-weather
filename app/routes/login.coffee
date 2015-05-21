`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from 'simple-auth/mixins/unauthenticated-route-mixin'`

LoginRoute = Ember.Route.extend UnauthenticatedRouteMixin,
  setupController: (controller, _model) ->
    controller.setDefaults()

`export default LoginRoute`
