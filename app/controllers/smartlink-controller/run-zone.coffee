`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`
`import leftPad from '../../util/strings/left-pad'`

SmartlinkControllerRunZoneController = Ember.Controller.extend ManualRunMixin,
  init: ->
    allMins = [1..59].map (num) ->
      {
        label: leftPad(2, num)
        value: num
      }

    fiveMinIntvls = []

    [0..55].forEach( (num) ->
      if num % 5 is 0
        fiveMinIntvls.push({
          label: leftPad(2, num)
          value: num
        })
    , this)

    availHrs = [0..9].map (num) ->
      {
        label: leftPad(2, num)
        value: num
      }

    @set('allMinutes', allMins)
    @set('fiveMinuteIntervals', fiveMinIntvls)

    @set('availableRunTimeHours', availHrs)
    @set('availableRunTimeMinutes', allMins)

  runTimeHours: 0

  runTimeMinutes: 5

  minutesDidChange: Ember.observer 'runTimeMinutes', ->
    if parseInt(@get('runTimeHours')) is 0
      @set('previousRunTimeMinutesSelection', @get('runTimeMinutes'))

  hoursDidChange: Ember.observer 'runTimeHours', ->
    if parseInt(@get('runTimeHours')) >= 1
      @set('availableRunTimeMinutes', @get('fiveMinuteIntervals'))
      @set('runTimeMinutes', 0)
    else
      prevMin = @get('previousRunTimeMinutesSelection')
      @set('runTimeMinutes', prevMin) if prevMin
      @set('availableRunTimeMinutes', @allMinutes)

  # This is slightly weird, see: https://weathermatic.atlassian.net/browse/SM-42
  totalRunTimeMinutesConverted: Ember.computed 'runTimeHours', 'runTimeMinutes', ->
    hrs = parseInt(@get('runTimeHours'))
    mins = parseInt(@get('runTimeMinutes'))

    totalMins = (hrs * 60) + mins

    return totalMins if totalMins <= 60

    # For every 5 minutes over 1 hour, add 1 to the original 60 minutes
    #
    # This is what the backend will actually do:
    # --------------------------
    # INPUT      ACTUAL RUN TIME
    # --------------------------
    # 59 min  |  59 min
    # 60 min  |  1 hour
    # 61 min  |  1 hour, 5 min
    # 62 min  |  1 hour, 10 min
    # ...
    # 72 min  |  2 hours
    # --------------------------

    extraMins = totalMins - 60
    fiveMinIntvls = Math.floor(extraMins / 5)

    60 + fiveMinIntvls

  actions:
    runZone: ->
      self = this
      params = {
        zone: @get('model.number')
        run_time: @get('totalRunTimeMinutesConverted')
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


`export default SmartlinkControllerRunZoneController`
