import Ember from 'ember';
import InboundActions from 'ember-component-inbound-actions/inbound-actions';

const CommLogComponent = Ember.Component.extend(InboundActions, {
  actions: {
    open() {
      this.set('isOpen', true);
    },

    close() {
      this.set('isOpen', false);
      this.sendAction('close');
    },

    startPolling() {
      Ember.Logger.debug('Starting comm log poll');
      const intervalId = setInterval( () => {
        Ember.Logger.debug('Polling comm log');
        this.get('smartlinkController.instructions').reload();
      }, 3000);
      this.set('pollingIntervalId', intervalId);
    },

    stopPolling() {
      Ember.Logger.debug('Stopping comm log poll');
      const intervalId = this.get('pollingIntervalId');
      if (!intervalId) { return; }
      clearInterval(intervalId);
      this.set('pollingIntervalId', null);
    },
  },

  isOpen: false,

  isOpenDidChange: Ember.observer('isOpen', function() {
    if (this.get('isOpen')) {
      this.send('startPolling');
    } else {
      this.send('stopPolling');
    }
  }),

  didInsertElement() {
    if (this.get('showNow')) {
      Ember.run.later(this, () => {
        this.send('open');
      });
    }
  },

});

export default CommLogComponent;
