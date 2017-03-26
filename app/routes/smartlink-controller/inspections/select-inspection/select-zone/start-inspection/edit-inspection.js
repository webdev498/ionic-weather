import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import RSVP from 'rsvp';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  model(params, transition) {
    var controller_id = transition.state.params['smartlink-controller'].controllerId;
    var inspectionId = transition.state.params['smartlink-controller.inspections.select-inspection'].inspectionId;
    return RSVP.hash({
      controller_id: controller_id,
      inspection_id: inspectionId,
      inspection: this.get('store').find('inspection', Number(inspectionId)),
    });
  }
});

