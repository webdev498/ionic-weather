`import Ember from 'ember'`

SmartlinkControllerSeasonalInspectionController = Ember.Controller.extend
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

`export default SmartlinkControllerSeasonalInspectionController`
