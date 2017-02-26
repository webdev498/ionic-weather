`import Ember from 'ember'`

SmartlinkControllerProgramInspectionController = Ember.Controller.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

`export default SmartlinkControllerProgramInspectionController`
