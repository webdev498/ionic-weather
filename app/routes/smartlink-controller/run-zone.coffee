`import Ember from 'ember'`

SmartlinkControllerRunZoneRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'zone', params.zoneId

  setupController: (controller, model) ->
    controller.setProperties(runTimeHours: 0, runTimeMinutes: 5)
    this._super(arguments...)


`export default SmartlinkControllerRunZoneRoute`
