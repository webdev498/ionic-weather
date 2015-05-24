`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerLocateValvesRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @store.find 'zone', params.zoneId

`export default SmartlinkControllerLocateValvesRoute`
