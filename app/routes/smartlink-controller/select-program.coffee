`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSelectProgramRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('smartlinkController').get('programs')

`export default SmartlinkControllerSelectProgramRoute`
