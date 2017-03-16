`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSeasonalInspectionRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params, transition) ->
    # This is how we get the id of the inspection
    inspectionId = transition.state.params['smartlink-controller.inspections.select-inspection'].inspectionId
    @get('store').find('snapshot', inspectionId)
})

`export default SmartlinkControllerSeasonalInspectionRoute`
