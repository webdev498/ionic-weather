import Ember from 'ember';
import SmartlinkSaveMixin from '../../../mixins/smartlink-save';

const { inject: { service }} = Ember;

const SmartlinkControllerSettingsAutoAdjustController = Ember.Controller.extend(SmartlinkSaveMixin, {

  locations: service(),

  init() {
    return this.initAvailableLatitudes();
  },

  initAvailableLatitudes() {
    const opts = [];
    var i;

    for (i = 60; i > 0; i--) {
      opts.push({ label: `${i} º N`, value: i });
    }
    opts.push({ label: 'Equator', value: 0 });
    for (i = -1; i >= -60; i--) {
      opts.push({ label: `${i} º S`, value: i });
    }

    return this.set('availableLatitudes', opts);
  },

  saveUrl: Ember.computed('model.id', 'baseUrl', function() {
    return `${this.get('baseUrl')}/api/v2/controllers/${this.get('model.id')}`;
  }),

  postalElementChanged: Ember.observer('model.postalCode', function() {
    const postal = this.get('model.postalCode');
    const lat = this.get('locations').latitudeForPostalCode(postal)
    if (lat !== null) {
      this.set('model.latitude', lat);
    }
  }),

  actions: {
    save() {
      return this.save({
        url: this.get('saveUrl'),
        params: {
          control: {
            postal_code: this.get('model.postalCode'),
            latitude:    this.get('model.latitude')
          }
        }
      }).then( () => {
        this.set('model.hasUnsentChanges', true);
      });
    }
  },

});

export default SmartlinkControllerSettingsAutoAdjustController;
