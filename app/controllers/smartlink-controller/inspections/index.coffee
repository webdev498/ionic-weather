`import Ember from 'ember'`

SmartlinkControllerInspectionController = Ember.Controller.extend
  needs: ['smartlinkController'],
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model',
  inspection: Ember.computed.alias 'controllers.smartlinkController.inspections.model'

`export default SmartlinkControllerInspectionController`