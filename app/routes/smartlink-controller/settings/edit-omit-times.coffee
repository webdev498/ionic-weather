`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsEditOmitTimesRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    Ember.Logger.debug('SmartlinkControllerSettingsEditOmitTimesRoute route:model')
    m = @modelFor('smartlink-controller')
    Ember.Logger.debug('SmartlinkControllerSettingsEditOmitTimesRoute loaded model')
    return m
})

`export default SmartlinkControllerSettingsEditOmitTimesRoute`
