`import Ember from 'ember'`

SmartlinkControllerCreateInspectionController = Ember.Controller.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

`export default SmartlinkControllerCreateInspectionController`
