`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSelectInspectionZoneRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params,transition) ->
    # This is how we get the id of the inspection
    inspectionId = transition.state.params['smartlink-controller.inspections.select-inspection'].inspectionId
    this.get('store').find('inspection', Number(inspectionId))
})

`export default SmartlinkControllerSelectInspectionZoneRoute`
