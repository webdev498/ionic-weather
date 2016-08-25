import Ember from 'ember';
import SmartlinkSaveMixin from '../../mixins/smartlink-save';

const SmartlinkControllerIndexController = Ember.Controller.extend(
  SmartlinkSaveMixin, {

  application: Ember.inject.controller('application'),

  queryParams: ['showCommLog'],

  isOptionsMenuOpen: false,

  showCommLog: false,

  setDefaults() {
    this.send('closeOptionsMenu');
  },

  runStatusCssClass: Ember.computed('model.runStatus', function() {
    if (this.get('model.isRunning')) { return 'btn-positive'; }
    if (this.get('model.isRunStatusOff')) { return 'btn-negative'; }
    return 'btn-primary';
  }),

  actions: {
    goBack() {
      if (this.get('model.site.smartlinkControllers.length') === 1) {
        this.transitionToRoute('sites');
      } else {
       this.transitionToRouter('site', this.get('model.site'));
      }
    },

    openOptionsMenu() {
      this.set('isOptionsMenuOpen', true);
    },

    closeOptionsMenu() {
      this.set('isOptionsMenuOpen', false);
    },

    openCommLog() {
      this.get('commLog').send('open');
    },

    commLogClosed() {
      this.send('closeOptionsMenu');
    },

    refreshData() {
      window.location.reload();
    },
  },

});

export default SmartlinkControllerIndexController;
