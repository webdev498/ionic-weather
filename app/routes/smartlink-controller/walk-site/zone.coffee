`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerWalkSiteZoneRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('smartlink-controller').get('zones').findBy('id', params.zoneId)

  serialize: (model, params) ->
    { zoneId: model.get('id') }

`export default SmartlinkControllerWalkSiteZoneRoute`
