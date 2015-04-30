`import ModalDialogComponent from './modal-dialog'`

LoadingModalComponent = ModalDialogComponent.extend
  isActive: Ember.computed.alias 'isLoading'

`export default LoadingModalComponent`
