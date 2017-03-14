`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerProgramInspectionRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    @modelFor('smartlinkController').get('programs')
})

`export default SmartlinkControllerProgramInspectionRoute`
