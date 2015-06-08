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
      @get('loadingModal').send('open')
      @submitManualRun(params).then (instruction) ->
        Ember.debug "Posted run zone: #{self.get('model.number')} \
          for controller: #{self.get('model.smartlinkController.id')}"
        self.get('loadingModal').send('loadInstruction', instruction)
      .catch (error) ->
        Ember.Logger.error(error)
        alert error
        self.get('loadingModal').send('close')

    loadingFinished: ->
      Ember.run.later this, ->
        @get('loadingModal').send('close')
      , 750

    loadingAbandoned: ->
      @get('loadingModal').send('close')

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
