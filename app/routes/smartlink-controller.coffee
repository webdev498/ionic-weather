`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @store.find 'smartlink-controller', params.controllerId

`export default SmartlinkControllerRoute`
