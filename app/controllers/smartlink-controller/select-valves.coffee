`import Ember from 'ember'`

SmartlinkControllerSelectValvesController = Ember.ArrayController.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

`export default SmartlinkControllerSelectValvesController`
