`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerWalkSiteIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  redirect: (model, transition) ->
    zone = model.get('zones.firstObject')
    if zone
      @transitionTo('smartlink-controller.walk-site.zone', zone)
    else
      Ember.Logger.error("No zones found for controller #{model.get('id')}, cannot walk site")
      @transitionTo('smartlink-controller.select-zone') # <-- Go here for the error message

`export default SmartlinkControllerWalkSiteIndexRoute`
