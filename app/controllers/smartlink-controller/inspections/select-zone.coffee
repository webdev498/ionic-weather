`import Ember from 'ember'`

SmartlinkControllerSelectInspectionZoneController = Ember.Controller.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

`export default SmartlinkControllerSelectInspectionZoneController`
