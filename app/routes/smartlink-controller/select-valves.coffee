`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSelectValvesRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('smartlinkController').get('zones').then (zones) ->
      zones.filterBy('active', true)

`export default SmartlinkControllerSelectValvesRoute`
