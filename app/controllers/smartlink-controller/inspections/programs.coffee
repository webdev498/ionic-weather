`import Ember from 'ember'`

SmartlinkControllerProgramsInspectionController = Ember.Controller.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

`export default SmartlinkControllerProgramsInspectionController`
