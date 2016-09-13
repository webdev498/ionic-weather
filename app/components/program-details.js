import Ember from 'ember';

const { Component, computed } = Ember;

const ProgramDetailsComponent = Component.extend({

  tagName: 'li',

  classNames: ['table-view-cell', 'weathermatic-select-program'],

  classNameBindings: ['programClass'],

  programClass: computed('program.identifier', function() {
    const ident = this.get('program.identifier').toLowerCase();
    return `weathermatic-select-program-${ident}`;
  }),

});

export default ProgramDetailsComponent;
