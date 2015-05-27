`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`
`import leftPad from '../../util/strings/left-pad'`

SmartlinkControllerRunZoneController = Ember.Controller.extend ManualRunMixin,
  actions:
    runZone: ->
      self = this

      params = {
        zone: @get('model.number')
        run_time: @get('runTimeMinutesTotal')
      }

      Ember.RSVP.all([
        @submitManualRun(params),
        self.get('smartlinkController.instructions').reload()
      ]).then ->
        self.transitionToRoute('smartlink-controller.index', queryParams: {
          showCommLog: true
        })


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
