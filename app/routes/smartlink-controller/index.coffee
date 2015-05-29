`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  setupController: (controller, _model) ->
    this._super(arguments...)
    controller.setDefaults()

  deactivate: ->
    @controller.get('commLog').send('stopPolling')

`export default SmartlinkControllerIndexRoute`
