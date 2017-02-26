`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerProgramInspectionRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    @modelFor('smartlinkController').get('zones').then (zones) ->
      zones.filterBy('active', true)
})

`export default SmartlinkControllerProgramInspectionRoute`
