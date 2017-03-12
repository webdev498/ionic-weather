`import Ember from 'ember'`

SmartlinkControllerGeneralInspectionController = Ember.Controller.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

`export default SmartlinkControllerGeneralInspectionController`
