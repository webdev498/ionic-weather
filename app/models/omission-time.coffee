`import DS from 'ember-data'`

formatTimeString = (timeString, format) ->
  return null if (typeof(timeString) == 'undefined' || timeString == null)
  moment(timeString).utc().format(format)

buildTimeString = (hoursMinutes, amPm) ->
  baseTime = '2000-01-01'
  time = moment(baseTime).utc()
  parts = hoursMinutes.split(':')
  time.hour(parts[0]).minute(parts[1])
  time.hour(time.hour() + 12) if amPm == 'pm' && parts[0] != '12'
  time.hour(time.hour() - 12) if amPm == 'am' && parts[0] == '12'
  return null unless time.isValid()
  time.toISOString()

OmissionTime = DS.Model.extend {
  startTime:              DS.attr 'string'
  endTime:                DS.attr 'string'

  startTimeHours:         DS.attr 'string'
  startTimeAmPm:          DS.attr 'string'
  endTimeHours:           DS.attr 'string'
  endTimeAmPm:            DS.attr 'string'

  smartlinkController:    DS.belongsTo 'smartlink-controller'

  init: ->
    this.initStartTime()
    this.initEndTime()

  initStartTime: ->
    if !!@get('startTime')
      @set 'startTimeHours', formatTimeString(@get('startTime'), 'hh:mm')
      @set 'startTimeAmPm', formatTimeString(@get('startTime'), 'a')

  initEndTime: ->
    if !!@get('endTime')
      @set 'endTimeHours', formatTimeString(@get('endTime'), 'hh:mm')
      @set 'endTimeAmPm', formatTimeString(@get('endTime'), 'a')

  updateStartTime: Ember.observer('startTimeHours', 'startTimeAmPm', ->
    hr = this.get('startTimeHours')
    a = this.get('startTimeAmPm')
    if (hr)
      @set 'startTime', buildTimeString(hr, a)
    else
      @set 'startTime', null
  )

  updateEndTime: Ember.observer('endTimeHours', 'endTimeAmPm', ->
    hr = this.get('endTimeHours')
    a = this.get('endTimeAmPm')
    if (hr)
      @set 'endTime', buildTimeString(hr, a)
    else
      @set 'endTime', null
  )
}

`export default OmissionTime`
