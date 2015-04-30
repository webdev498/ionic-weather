`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`
`import leftPad from '../../util/strings/left-pad'`

SmartlinkControllerRunZoneController = Ember.Controller.extend ManualRunMixin,
  actions:
    runZone: ->
      controller = this

      params = {
        zone: @get('model.number')
        run_time: @get('runTimeMinutesTotal')
      }

      @submitManualRun(params).then (response) ->
        controller.transitionToRoute('smartlink-controller.command-success')

  runTimeHours: 0

  runTimeMinutes: 5

  availableRunTimeHours: Ember.computed ->
    [0..9].map (num) ->
      {
        label: leftPad(2, num)
        value: num
      }

  availableRunTimeMinutes: Ember.computed ->
    [1..59].map (num) ->
      {
        label: leftPad(2, num)
        value: num
      }

  runTimeMinutesTotal: Ember.computed 'runTimeHours', 'runTimeMinutes', ->
    runTimeHoursInMinutes = parseInt(@get('runTimeHours')) * 60
    runTimeHoursInMinutes + parseInt(@get('runTimeMinutes'))

`export default SmartlinkControllerRunZoneController`
