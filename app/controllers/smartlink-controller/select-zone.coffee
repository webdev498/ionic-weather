`import Ember from 'ember'`

SmartlinkControllerSelectZoneController = Ember.ArrayController.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

`export default SmartlinkControllerSelectZoneController`
