`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerInspectionRoute = Ember.Route.extend(AuthenticatedRouteMixin,
  model: () ->
    @store.findAll('inspection',{reload: true}).then((data) -> data.sortBy('date').reverse());
)

`export default SmartlinkControllerInspectionRoute`