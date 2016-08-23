`import Ember from 'ember';`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsEditFlowRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    @store.find 'zone', params.zoneId

  setupController: (controller, model) ->
    this._super(controller, model)
    controller.setupDefaults(model)
})

`export default SmartlinkControllerSettingsEditFlowRoute`
