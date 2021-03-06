`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsEditAutoAdjustRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    @store.find 'zone', params.zoneId
})

`export default SmartlinkControllerSettingsEditAutoAdjustRoute`
