`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerWalkSiteIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    @modelFor('smartlink-controller').get('zones')

  redirect: (model, transition) ->
    zone = model.get('firstObject')
    if zone
      @transitionTo('smartlink-controller.walk-site.zone', zone)
    else
      Ember.Logger.error("No zones found for controller #{model.get('id')}, cannot walk site")
      @transitionTo('smartlink-controller.select-zone') # <-- Go here for the error message

`export default SmartlinkControllerWalkSiteIndexRoute`
