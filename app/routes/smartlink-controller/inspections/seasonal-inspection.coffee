`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSeasonalInspectionRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    @modelFor('smartlinkController').get('zones').then (zones) ->
      zones.filterBy('active', true)
})

`export default SmartlinkControllerSeasonalInspectionRoute`
