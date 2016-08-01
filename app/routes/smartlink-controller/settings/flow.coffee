`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsFlowRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    smartlinkController = @modelFor('smartlink-controller')
    smartlinkController.get('zones').then (zones) ->
      {
        smartlinkController
        zones
      }
})

`export default SmartlinkControllerSettingsFlowRoute`
