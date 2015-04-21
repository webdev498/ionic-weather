`import Ember from 'ember'`

SmartlinkControllerRunZoneController = Ember.Controller.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

`export default SmartlinkControllerRunZoneController`
