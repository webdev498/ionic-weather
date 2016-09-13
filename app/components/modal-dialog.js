import Ember from 'ember';

const { Component } = Ember;

const ModalDialogComponent = Component.extend({

  tagName: 'div',

  classNames: ['modal'],

  classNameBindings: ['isActive:active'],

  didInsertElement: function() {
    this.$('.full-width-textarea').each(function() {
      const width = $(this).parent().width();
      $(this).width(width + 20);
    });
  }
});

export default ModalDialogComponent;
