import Ember from 'ember';
import SmartlinkSaveMixin from '../../mixins/smartlink-save';

const { Controller, inject, computed } = Ember;

const SmartlinkControllerIndexController = Controller.extend(SmartlinkSaveMixin, {

  application: inject.controller('application'),

  queryParams: ['showCommLog'],

  isOptionsMenuOpen: false,

  showCommLog: false,

  setDefaults() {
    this.send('closeOptionsMenu');
  },

  runStatusCssClass: computed('model.runStatus', function() {
    if (this.get('model.isRunning')) { return 'btn-positive'; }
    if (this.get('model.isRunStatusOff')) { return 'btn-negative'; }
    return 'btn-primary';
  }),

  actions: {
    goBack() {
      if (this.get('model.site.controllersCount') === 1) {
        this.transitionToRoute('sites');
      } else {
       this.transitionToRoute('site', this.get('model.site'));
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
