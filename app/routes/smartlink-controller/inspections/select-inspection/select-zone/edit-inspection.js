import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import RSVP from 'rsvp';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  model(params, transition) {
    var controller_id = transition.state.params['smartlink-controller'].controllerId;
    var inspectionId = transition.state.params['smartlink-controller.inspections.select-inspection'].inspectionId;
    var zoneId = transition.state.params['smartlink-controller.inspections.select-inspection.select-zone.edit-inspection'].zoneId;
    return RSVP.hash({
      id: zoneId,
      controller_id: controller_id,
      inspection: this.get('store').find('inspection', Number(inspectionId)),
      zones: this.modelFor('smartlinkController').get('zones').then((zones) => {
        return zones.filterBy('active', true);
      })
    });
  }
});

