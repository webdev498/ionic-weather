`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsSeasonalAdjustRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    @modelFor('smartlink-controller')
})

`export default SmartlinkControllerSettingsSeasonalAdjustRoute`
