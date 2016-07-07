`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsEditProgramRunTimeRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    @store.find 'zone', params.zoneId

  setupController: (controller, model) ->
    this._super(arguments...)
    controller.setDefaults()
})

`export default SmartlinkControllerSettingsEditProgramRunTimeRoute`
