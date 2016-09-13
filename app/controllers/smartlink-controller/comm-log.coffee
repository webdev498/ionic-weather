`import Ember from 'ember'`

# TODO: is this in use? can we delete?
SmartlinkControllerCommLogController = Ember.Controller.extend
  needs: ['smartlinkController']

  smartlinkController: Ember.computed 'controllers.smartlinkContrller', ->
    @get('controllers.smartlinkController.model')

`export default SmartlinkControllerCommLogController`
