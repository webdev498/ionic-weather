import Ember from 'ember';

const { Component } = Ember;

const ModalDialogComponent = Component.extend({

  tagName: 'div',

  classNames: ['modal'],

  classNameBindings: ['isActive:active'],

});

export default ModalDialogComponent;
