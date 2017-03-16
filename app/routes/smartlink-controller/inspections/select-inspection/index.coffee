`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSelectInspectionRoute = Ember.Route.extend(AuthenticatedRouteMixin,
  model: (params,transition) ->
    # This is how we get the id of the inspection
    inspectionId = transition.state.params['smartlink-controller.inspections.select-inspection'].inspectionId
    this.get('store').find('inspection', Number(inspectionId))
    inspectionDetail: [
        {
            option: "Select Zone to Inspect",
            link: "smartlink-controller.inspections.select-inspection.select-zone",
            id: "option1"
        },
        {
            option: "General"
            description: "Brief Details",
            link: "smartlink-controller.inspections.select-inspection.general",
            id: "option2"
        },
        {
            option: "Programs"
            description: "Brief Details",
            link: "smartlink-controller.inspections.select-inspection.programs",
            id: "option3"
        },
        {
            option: "Seasonal"
            description: "Brief Details",
            link: "smartlink-controller.inspections.select-inspection.seasonal",
            id: "option4"
        },
        {
            option: "Omit"
            description: "Brief Details",
            link: "smartlink-controller.inspections.select-inspection.omit",
            id: "option4"
        }
    ]

)

`export default SmartlinkControllerSelectInspectionRoute`