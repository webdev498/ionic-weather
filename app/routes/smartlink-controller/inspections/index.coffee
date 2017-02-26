`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerInspectionRoute = Ember.Route.extend(AuthenticatedRouteMixin,
  model: () ->
    smartlinkController: @modelFor('smartlink-controller')
    inspections: [
        {
            zone: 15
            description: "Custom Inspection Name"
            id: "inspection1"
            number: 1
        },
        {
            zone: 12
            id: "inspection1"
            number: 2
        },
        {
            zone: 1
            description: "Custom Inspection Name"
            id: "inspection1"
            number: 3
        },
        {
            zone: 4
            id: "inspection1"
            number: 4
        },
        {
            zone: 5
            id: "inspection1"
            number: 5
        },
        {
            zone: 8
            id: "inspection1"
            number: 6
        },
        {
            zone: 12
            description: "Custom Inspection Name"
            id: "inspection1"
            number: 7
        },
        {
            zone: 11
            id: "inspection1"
            number: 8
        },
        {
            zone: 7
            id: "inspection1"
            number: 9
        }
    ]
)

`export default SmartlinkControllerInspectionRoute`