`import Ember from 'ember'`

SmartlinkControllerRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'smartlink-controller', params.controllerId

  serialize: (model) ->
    controllerId: model.id

`export default SmartlinkControllerRoute`
