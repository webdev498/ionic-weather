import Ember from 'ember';

const { Component, computed, observer } = Ember;

const InputWithErrorsComponent = Ember.Component.extend({

  init() {
    this.setDefaultType();
    return this._super();
  },

  setDefaultType() {
    if (this.get('type') == null) {
      this.set('type', 'text');
    }
  },

  value: computed('model', 'field', function() {
    return this.get("model." + (this.get('field')));
  }),

  valueDidChange: observer('value', function() {
    this.set("model." + (this.get('field')), this.get('value'));
  }),

  hasError: computed('model', 'field', 'errors.@each', function() {
    return Object.keys(this.get('errors')).length > 0;
  })

});

export default InputWithErrorsComponent;
