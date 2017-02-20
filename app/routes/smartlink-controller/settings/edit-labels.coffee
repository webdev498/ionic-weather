`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerEditZoneRoute = Ember.Route.extend(AuthenticatedRouteMixin,
  model: (params) ->
    smartlinkController = @modelFor('smartlink-controller')
    smartlinkController.get('zones').then (zones) ->
        smartlinkController: smartlinkController
        zones: zones.filterBy('active', true)

  serialize: (model, params) ->
    zoneId: model.get('id')
)

`export default SmartlinkControllerEditZoneRoute`
