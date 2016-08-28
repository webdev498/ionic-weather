import Ember from 'ember';
import SmartlinkSaveMixin from './../mixins/smartlink-save';

const { Logger: { debug }, Component, computed } = Ember;

const NeedSendMessageComponent = Component.extend(SmartlinkSaveMixin, {
  classNames: ['needs-send-message-container'],

  actions: {
    transmit: function() {
      debug('transmit action called from NeedSendMessageComponent');
      return this.sendAction('transmit', this.get('smartlinkController'), this.get('loadingModal'));
    }
  }
});

export default NeedSendMessageComponent;
