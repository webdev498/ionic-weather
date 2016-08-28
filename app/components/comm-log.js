import Ember from 'ember';
import InboundActions from 'ember-component-inbound-actions/inbound-actions';

const { Component, Logger: { debug }, observer, run } = Ember;

const CommLogComponent = Component.extend(InboundActions, {
  actions: {
    open() {
      this.set('isOpen', true);
    },

    close() {
      this.set('isOpen', false);
      this.sendAction('close');
    },

    startPolling() {
      debug('Starting comm log poll');
      const intervalId = setInterval( () => {
        debug('Polling comm log');
        this.get('smartlinkController.instructions').reload();
      }, 3000);
      this.set('pollingIntervalId', intervalId);
    },

    stopPolling() {
      debug('Stopping comm log poll');
      const intervalId = this.get('pollingIntervalId');
      if (!intervalId) { return; }
      clearInterval(intervalId);
      this.set('pollingIntervalId', null);
    },
  },

  isOpen: false,

  isOpenDidChange: observer('isOpen', function() {
    if (this.get('isOpen')) {
      this.send('startPolling');
    } else {
      this.send('stopPolling');
    }
  }),

  didInsertElement() {
    if (this.get('showNow')) {
      run.later(this, () => {
        this.send('open');
      });
    }
  },

});

export default CommLogComponent;
