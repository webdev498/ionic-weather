import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import RSVP from 'rsvp';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  model(params, transition) {
    var inspectionId = transition.state.params['smartlink-controller.inspections.select-inspection'].inspectionId;
    return RSVP.hash({
      inspection: this.get('store').find('inspection', Number(inspectionId)),
      zones: this.modelFor('smartlinkController').get('zones').then((zones) => {
        return zones.filterBy('active', true);
      })
    });
  }
});

