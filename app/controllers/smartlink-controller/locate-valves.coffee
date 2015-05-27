`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`

SmartlinkControllerLocateValvesController = Ember.Controller.extend ManualRunMixin,
  needs: ['smartlinkController']

  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

  actions:
    locateValves: ->
      self = this

      params = {
        valve_zone: @get('model.number')
      }

      Ember.RSVP.all([
        @submitManualRun(params),
        self.get('smartlinkController.instructions').reload()
      ]).then ->
        self.transitionToRoute('smartlink-controller.index', queryParams: {
          showCommLog: true
        })


`export default SmartlinkControllerLocateValvesController`
