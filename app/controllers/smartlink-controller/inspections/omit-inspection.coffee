`import Ember from 'ember'`

SmartlinkControllerOmitInspectionController = Ember.Controller.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

`export default SmartlinkControllerOmitInspectionController`
