`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerWalkSiteZoneRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    ctrl = @modelFor('smartlink-controller')
    Ember.Logger.debug("=============")
    Ember.Logger.debug(ctrl)
    ctrl.get('zones').then (zones) ->
      zones.toArray().find( (zone) ->
        zone.get('id') == params.zoneId
    )


  serialize: (model, params) ->
    { zoneId: model.get('id') }

`export default SmartlinkControllerWalkSiteZoneRoute`
