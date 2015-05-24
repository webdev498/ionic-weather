`import Ember from 'ember'`

SmartlinkControllerCommLogController = Ember.Controller.extend
  needs: ['smartlinkController']

  smartlinkController: Ember.computed 'controllers.smartlinkContrller', ->
    @get('controllers.smartlinkController.model')

`export default SmartlinkControllerCommLogController`
