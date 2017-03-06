`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerInspectionRoute = Ember.Route.extend(AuthenticatedRouteMixin,
  model: () ->
    this.get('store').findAll('inspection')
)

`export default SmartlinkControllerInspectionRoute`