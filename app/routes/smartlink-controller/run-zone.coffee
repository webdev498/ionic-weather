`import Ember from 'ember'`

SmartlinkControllerRunZoneRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'zone', params.zoneId

  serialize: (model) ->
    zoneId: model.id

`export default SmartlinkControllerRunZoneRoute`
