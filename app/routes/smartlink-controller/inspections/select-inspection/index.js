import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import config from '../../../../config/environment';
import RSVP from 'rsvp';


export default Ember.Route.extend(AuthenticatedRouteMixin, {
    inspection_id: 0,
    controller_id: 0,
    model(params, transition) {
        // This is how we get the id of the inspection
        this.controller_id = transition.state.params['smartlink-controller'].controllerId
        this.inspection_id = transition.state.params['smartlink-controller.inspections.select-inspection'].inspectionId
        var inspectionItems = this.get('store').find('inspection', Number(this.inspection_id));
        var inspectionDetail = [
            {
                option: "Select Zone to Inspect",
                link: "smartlink-controller.inspections.select-inspection.select-zone",
                id: "option1"
            },
            {
                option: "General",
                description: "Brief Details",
                link: "smartlink-controller.inspections.select-inspection.general",
                id: "option2"
            },
            {
                option: "Programs",
                description: "Brief Details",
                link: "smartlink-controller.inspections.select-inspection.programs",
                id: "option3"
            },
            {
                option: "Seasonal",
                description: "Brief Details",
                link: "smartlink-controller.inspections.select-inspection.seasonal",
                id: "option4"
            },
            {
                option: "Omit",
                description: "Brief Details",
                link: "smartlink-controller.inspections.select-inspection.omit",
                id: "option4"
            }
        ];
        return RSVP.hash({
            menu: inspectionDetail,
            items: inspectionItems,
            inspection_id: this.inspection_id,
            controller_id: this.controller_id
        });
    }
});
