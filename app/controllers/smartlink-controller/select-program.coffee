`import Ember from 'ember'`

SmartlinkControllerSelectProgramController = Ember.ArrayController.extend
  needs: ['smartlinkController']

  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

  itemController: 'smartlink-controller/select-program-item'

`export default SmartlinkControllerSelectProgramController`
