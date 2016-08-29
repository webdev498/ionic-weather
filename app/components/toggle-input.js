import Ember from 'ember';
import RatchetToggleMixin from '../mixins/ratchet-toggle';

const { Component } = Ember;

export default Component.extend(RatchetToggleMixin, {
  classNames: ['toggle'],

  classNameBindings: ['value:active'],

  didInsertElement() {
    this.setupRatchetToggles();

    this.get('element').addEventListener('toggle', () => {
      this.set('value', event.detail.isActive);
    });
  }
});
