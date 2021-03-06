`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsFlowRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    smartlinkController = @modelFor('smartlink-controller')
    smartlinkController.get('zones').then (zones) ->
      {
        smartlinkController
        zones: zones.filterBy('active', true)
      }
})

`export default SmartlinkControllerSettingsFlowRoute`
