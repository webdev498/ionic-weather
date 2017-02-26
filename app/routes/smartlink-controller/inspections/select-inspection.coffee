`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSelectInspectionRoute = Ember.Route.extend(AuthenticatedRouteMixin,
  model: () ->
    smartlinkController: @modelFor('smartlink-controller')
    inspectionDetail: [
        {
            option: "Select Zone to Inspect",
            link: "smartlink-controller.inspections.select-zone",
            id: "option1"
        },
        {
            option: "General"
            description: "Brief Details",
            link: "smartlink-controller.inspections.general-inspection",
            id: "option2"
        },
        {
            option: "Programs"
            description: "Brief Details",
            link: "smartlink-controller.inspections.program-inspection",
            id: "option3"
        },
        {
            option: "Seasonal"
            description: "Brief Details",
            link: "smartlink-controller.inspections.seasonal-inspection",
            id: "option4"
        },
        {
            option: "Omit"
            description: "Brief Details",
            link: "smartlink-controller.inspections.omit-inspection",
            id: "option4"
        }
    ]
)

`export default SmartlinkControllerSelectInspectionRoute`