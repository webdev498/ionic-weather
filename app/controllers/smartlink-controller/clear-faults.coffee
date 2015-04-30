`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`

SmartlinkControllerClearFaultsController = Ember.Controller.extend ManualRunMixin,
  needs: ['smartlinkController']

  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

  actions:
    clearFaults: ->
      controller = this

      params = {
        clear_all_faults: true
      }

      @submitManualRun(params).then ->
        controller.get('smartlinkController').reload()
        controller.transitionToRoute('smartlink-controller.command-success')

`export default SmartlinkControllerClearFaultsController`
