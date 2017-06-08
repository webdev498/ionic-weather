`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerGeneralInspectionRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params,transition) ->
    # This is how we get the id of the inspection
    inspectionId = transition.state.params['smartlink-controller.inspections.select-inspection'].inspectionId;
    controllerId = transition.state.params['smartlink-controller'].controllerId;
    return {
        inspection: this.get('store').find('inspection', Number(inspectionId))
        controller: this.get('store').find('smartlink-controller', Number(controllerId))
    }
})

`export default SmartlinkControllerGeneralInspectionRoute`
