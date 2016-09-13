`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsEditProgramRunTimeRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    @store.find 'zone', params.zoneId
})

`export default SmartlinkControllerSettingsEditProgramRunTimeRoute`
