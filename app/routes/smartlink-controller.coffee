`import Ember from 'ember'`

SmartlinkControllerRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'smartlink-controller', params.controllerId

`export default SmartlinkControllerRoute`
