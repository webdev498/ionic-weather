`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSelectZoneRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('smartlinkController').get('zones')

`export default SmartlinkControllerSelectZoneRoute`
