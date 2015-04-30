`import Ember from 'ember'`

SmartlinkControllerLocateValvesRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'zone', params.zoneId

`export default SmartlinkControllerLocateValvesRoute`
