`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSelectInspectionRoute = Ember.Route.extend(AuthenticatedRouteMixin,
  model: () ->
    smartlinkController: @modelFor('smartlink-controller')
    inspectionDetail: [
        {
            option: "Select Zone to Inspect"
            id: "option1"
        },
        {
            option: "General"
            description: "Brief Details",
            id: "option2"
        },
        {
            option: "Programs"
            description: "Brief Details",
            id: "option3"
        },
        {
            option: "Seasonal"
            description: "Brief Details",
            id: "option4"
        },
        {
            option: "Omit"
            description: "Brief Details",
            id: "option4"
        }
    ]
)

`export default SmartlinkControllerSelectInspectionRoute`