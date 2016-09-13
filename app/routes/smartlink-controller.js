import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

const SmartlinkControllerRoute = Ember.Route.extend(AuthenticatedRouteMixin, {

  model(params) {
    const id = params.controllerId;
    return this.store.findRecord('smartlink-controller', id).then( (ctrl) => {
      return ctrl;
    });
  },

  serialize(model) {
    if (model.get) {
      return {
        controllerId: model.get('id')
      };
    } else {
      return model;
    }
  },

});

export default SmartlinkControllerRoute;
