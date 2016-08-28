import Ember from 'ember';

const { Component, computed } = Ember;

const ProgramMaxRunComponent = Ember.Component.extend({

  tagName: 'div',

  classNames: ['card'],

  programClass: computed('program.identifier', function() {
    const ident = this.get('program.identifier').toLowerCase();
    return `weathermatic-select-program-${ident}`;
  }),

  availableMaxRun: computed(function() {
    var i;
    const opts = [{
      label: 'Off', value: 0
    }];

    for (i = 1; i <= 30; i++) {
      opts.push({ label: `${i} min`, value: i })
    }

    return opts;
  }),

  availableMinSoak: Ember.computed(function() {
    var i;
    const opts = [{
      label: 'Off', value: 0
    }];

    for (i = 1; i <= 120; i++) {
      opts.push({ label: `${i} min`, value: i })
    }

    return opts;
  }),

  isMaxRunDisabled: computed('program.maxRun', function() {
    return parseInt(this.get('program.maxRun')) === 0;
  }),

  minSoakCssClass: computed('isMaxRunDisabled', function() {
    if (this.get('isMaxRunDisabled')) {
      return 'invisible';
    } else {
      return '';
    }
  })

});

export default ProgramMaxRunComponent;
