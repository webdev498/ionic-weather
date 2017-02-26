`import Ember from 'ember'`

SmartlinkControllerEditInspectionController = Ember.Controller.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model',

`export default SmartlinkControllerEditInspectionController`