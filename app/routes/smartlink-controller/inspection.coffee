`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerInspectionRoute = Ember.Route.extend(AuthenticatedRouteMixin,
  model: (params) ->
    smartlinkController = @modelFor('smartlink-controller')
    smartlinkController.get('zones').then (zones) ->
        smartlinkController: smartlinkController
        zones: zones.filterBy('active', true))


`export default SmartlinkControllerInspectionRoute`