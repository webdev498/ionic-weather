`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`

SmartlinkControllerStopAllController = Ember.Controller.extend ManualRunMixin,
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

  actions:
    stopAll: ->
      self = this

      params = {
        run_action: 'manual_stop_program'
      }

      Ember.RSVP.all([
        @submitManualRun(params),
        self.get('smartlinkController.instructions').reload()
      ]).then ->
        self.transitionToRoute('smartlink-controller.index', queryParams: {
          showCommLog: true
        })



`export default SmartlinkControllerStopAllController`
