`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  serialize: (model) ->
    { controllerId: Ember.get(model, 'id') }

  setupController: (controller, _model) ->
    this._super(arguments...)
    controller.setDefaults()

  deactivate: ->
    @controller.get('commLog').send('stopPolling')

`export default SmartlinkControllerIndexRoute`
