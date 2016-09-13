import Ember from 'ember';

const { Component, computed } = Ember;

const SelectProgramItemComponent = Component.extend({

  cssClass: computed('program.identifier', function() {
    return `weathermatic-select-program-${this.get('program.identifier').toLowerCase()}`;
  }),

});

export default SelectProgramItemComponent;
