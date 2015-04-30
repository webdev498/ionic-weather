`import Ember from 'ember'`

ModalDialogComponent = Ember.Component.extend
  tagName: 'div'
  classNames: ['modal']
  classNameBindings: ['isActive:active']

`export default ModalDialogComponent`
