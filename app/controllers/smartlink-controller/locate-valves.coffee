`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`

SmartlinkControllerLocateValvesController = Ember.Controller.extend ManualRunMixin,
  actions:
    locateValves: ->
      controller = this

      params = {
        valve_zone: @get('model.number')
      }

      @submitManualRun(params).then ->
        controller.transitionToRoute('smartlink-controller.command-success')


`export default SmartlinkControllerLocateValvesController`
