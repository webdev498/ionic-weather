import ModalDialogComponent from './modal-dialog';
import InboundActions from 'ember-component-inbound-actions/inbound-actions';
import Instruction from '../models/instruction';

const { Logger: { debug }, computed, observer, run } = Ember;

const LoadingModalComponent = ModalDialogComponent.extend(InboundActions, {

  instructionStatusCssClass: computed('instruction.statusId', function() {
    if (this.get('instruction.isInProgress')) {
      return 'btn-positive';
    } else if (this.get('instruction.isStatusError')) {
      return 'btn-negative';
    } else {
      return 'btn-primary';
    }
  }),

  statusMessage: computed('instruction.statusId', function() {
    if (this.get('instruction.isInProgress')) {
      return 'Sending...';
    } else {
      return this.get('instruction.status');
    }
  }),

  instructionDidChange: observer('instruction.statusId', function() {
    if (!this.get('instruction')) {
      return;
    }
    if (this.get('instruction.isInProgress')) {
      this.startPolling();
    } else if (this.get('instruction.isStatusError')) {
      this.stopPolling();
    } else {
      this.stopPolling();
      this.sendAction('loadingFinished');
    }
  }),

  startPolling() {
    if (this.get('pollingIntervalId')) {
      debug(`Requested polling status for instruction: ${this.get('instruction.id')}, but polling already in progress`);
      return;
    }
    debug(`Start polling status for instruction: ${this.get('instruction.id')}`);
    const intervalId = setInterval( () => {
      debug(`Polling status for instruction: ${this.get('instruction.id')}`);
      return this.get('instruction').reload();
    }, 1000);
    return this.set('pollingIntervalId', intervalId);
  },

  stopPolling() {
    debug(`Stop polling status for instruction: ${this.get('instruction.id')}`);
    const intervalId = this.get('pollingIntervalId');
    if (!intervalId) {
      return;
    }
    clearInterval(intervalId);
    return this.set('pollingIntervalId', null);
  },

  actions: {
    loadInstruction(instruction) {
      this.set('instruction', instruction);
      return this.send('open');
    },

    open(message) {
      this.set('isActive', true);
      return this.set('saveMessage', message);
    },

    close() {
      if (this.isDestroyed) {
        debug('Tried to close destroyed modal, will do nothing');
        return;
      }
      this.set('isActive', false);
      this.set('instruction', null);
      this.set('isLoadingFinished', false);
      if (this.get('autoCloseLater') != null) {
        return run.cancel(this.get('autoCloseLater'));
      }
    },

    abandon() {
      this.stopPolling();
      return this.sendAction('loadingAbandoned');
    },

    finished(message) {
      var autoClose;
      this.stopPolling();
      this.set('isLoadingFinished', true);
      autoClose = run.later( () => {
        return this.send('close');
      }, 3000);
      return this.set('autoCloseLater', autoClose);
    }
  }
});

export default LoadingModalComponent;
