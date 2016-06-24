`import Ember from 'ember'`



SmartlinkControllerSettingsEditOmitTimesController = Ember.Controller.extend({
  init: ->
    @initAvailableOmitTimes()
    @initTimeSuffix()
    @initDaysOfWeek()
    @initMonthsOfYear()
    @initDaysOfMonth()

  initAvailableOmitTimes: ->
    opts = [{label: "Off", value: null}]
    [0...72].forEach (n) ->
      time = moment().startOf('day').add(n * 10, 'minutes').format('hh:mm')
      opts.push({label: time, value: time})
    
    @set 'availableOmitTimes', opts

  initTimeSuffix: ->
    @set 'timeSuffix', [
      {label: "am", value: 'am'},
      {label: "pm", value: 'pm'}
    ]

  initDaysOfWeek: ->
    @set 'daysOfWeek', ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']

  initMonthsOfYear: ->
    opts = [{label: "Off", value: 0}]
    [1..12].forEach (n) ->
      month = moment().startOf('year').add(n-1, 'month').format('MMM')
      opts.push({label: month, value: n})
    @set 'monthsOfYear', opts

  initDaysOfMonth: ->
    opts = [{label: "Off", value: 0}]
    [1..31].forEach (n) ->
      opts.push({label: n, value: n})
    @set 'daysOfMonth', opts

  omissionDates: Ember.computed 'model.omissionDates.length', ->
    [1..15].map (n) =>
      Ember.Object.create({
        number: n
        object: @get('model.omissionDates').toArray()[n-1] || @get('model.omissionDates').createRecord()  
      })     

  omissionDayNumbers: Ember.computed 'model.omissionDays.length', ->
    @get('model.omissionDays').map (omissionDay) ->
      omissionDay.get('day')

  isSundaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').includes(0) 

  isMondaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').includes(1) 

  isTuesdaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').includes(2) 

  isWednesdaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').includes(3) 

  isThursdaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').includes(4) 

  isFridaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').includes(5) 

  isSaturdaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').includes(6)

  omissionTime: Ember.computed 'model.omissionTimes.length', ->
    @get('model.omissionTimes.firstObject') || @get('model.omissionTimes').createRecord()
    
})

`export default SmartlinkControllerSettingsEditOmitTimesController`