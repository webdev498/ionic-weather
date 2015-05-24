`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`

SmartlinkControllerStopAllController = Ember.Controller.extend ManualRunMixin,
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

  actions:
    stopAll: ->
      controller = this
      params = {
        run_action: 'manual_stop_program'
      }
      @submitManualRun(params).then ->
        controller.get('smartlinkController.instructions').reload().then ->
          controller.transitionToRoute('smartlink-controller.comm-log')


`export default SmartlinkControllerStopAllController`
