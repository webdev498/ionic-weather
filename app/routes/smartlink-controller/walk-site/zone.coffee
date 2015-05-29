`import Ember from 'ember'`

SmartlinkControllerWalkSiteZoneRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('smartlink-controller').get('zones').findBy('id', params.zoneId)

  serialize: (model, params) ->
    { zoneId: model.get('id') }

`export default SmartlinkControllerWalkSiteZoneRoute`
