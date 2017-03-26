`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerRunZoneRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @store.find 'zone', params.runZoneId

  setupController: (controller, model) ->
    controller.setProperties(runTimeHours: 0, runTimeMinutes: 5)
    this._super(arguments...)


`export default SmartlinkControllerRunZoneRoute`
