`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`

SmartlinkControllerClearFaultsController = Ember.Controller.extend ManualRunMixin,
  needs: ['smartlinkController']

  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

  actions:
    clearFaults: ->
      self = this

      Ember.RSVP.all([
        @submitManualRun(clear_all_faults: true),
        self.get('smartlinkController').reload()
      ]).then ->
        self.transitionToRoute('smartlink-controller.index')

`export default SmartlinkControllerClearFaultsController`
