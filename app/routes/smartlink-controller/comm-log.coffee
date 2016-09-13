`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerCommLogRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    @modelFor('smartlink-controller').get('instructions')

`export default SmartlinkControllerCommLogRoute`
