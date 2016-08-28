import Ember from 'ember';
import Instruction from '../models/instruction';

const { Component, computed } = Ember;

const InstructionItemComponent = Component.extend({

  tagName: 'li',

  classNameBindings: ['instructionCssClass', ':table-view-cell'],

  instructionCssClass: Ember.computed('instruction.isCommand', function() {}),

  statusCssClass: computed('instruction.statusId', function() {
    switch (this.get('instruction.statusId')) {
      case Instruction.STATUS_QUEUED:
        return 'badge-primary';
      case Instruction.STATUS_FINISHED:
        return 'badge-positive';
      case Instruction.STATUS_ERROR:
        return 'badge-negative';
      case Instruction.STATUS_PENDING:
        return 'weathermatic-badge-warning';
    }
  }),

  iconName: computed('instruction.typeCommonName', function() {
    var icon;
    const type = this.getWithDefault('instruction.typeCommonName', '').toLowerCase();
    switch (type) {
      case 'send':
        icon = 'exchange';
        break;
      case 'receive':
        icon = 'exchange';
        break;
      case 'command':
        icon = 'gears';
        break;
      default:
        icon = 'asterisk';
    }
    return `${icon} fa-lg`;
  })

});

export default InstructionItemComponent;
