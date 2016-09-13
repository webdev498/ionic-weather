`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin'`

LoginRoute = Ember.Route.extend UnauthenticatedRouteMixin,
  setupController: (controller, _model) ->
    Ember.Logger.debug 'In LoginRoute setupController, setting controller defaults'
    controller.setDefaults()
    this._super(arguments...)

`export default LoginRoute`
