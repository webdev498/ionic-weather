`import Ember from 'ember'`

SmartlinkControllerSelectZoneController = Ember.Controller.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

`export default SmartlinkControllerSelectZoneController`
