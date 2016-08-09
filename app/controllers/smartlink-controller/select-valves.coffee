`import Ember from 'ember'`

SmartlinkControllerSelectValvesController = Ember.Controller.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

`export default SmartlinkControllerSelectValvesController`
