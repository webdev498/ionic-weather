`import Ember from 'ember'`

SmartlinkControllerInspectionController = Ember.Controller.extend
  needs: ['smartlinkController'],
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

`export default SmartlinkControllerInspectionController`