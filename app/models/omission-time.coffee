`import DS from 'ember-data'`

formatTimeString = (timeString, format) ->
  return null if (typeof(timeString) == 'undefined' || timeString == null)
  moment(timeString).utc().format(format)

buildTimeString = (timeString, hoursMinutes, amPm) ->
  time = moment(timeString).utc()
  parts = hoursMinutes.split(':')
  time.hour(parts[0]).minute(parts[1])
  time.hour(time.hour() + 12) if amPm == 'pm'
  time.toISOString()

OmissionTime = DS.Model.extend {
  startTime:              DS.attr 'string'
  _startTimeHours:        DS.attr 'string'
  _startTimeAmPm:         DS.attr 'string'
  endTime:                DS.attr 'string'
  smartlinkController:    DS.belongsTo 'smartlink-controller'

  startTimeHours: ( (key, value) ->
    if typeof(value) == 'undefined' || value == null
      @get('_startTimeHours') || formatTimeString(@get('startTime'), 'hh:mm')
    else
      @set '_startTimeHours', value
  ).property('startTime').volatile()

  startTimeAmPm: ( (key, value) ->
    if typeof(value) == 'undefined' || value == null
      @get('_startTimeAmPm') || formatTimeString(@get('startTime'), 'a')
    else
      @set '_startTimeAmPm', value
  ).property('startTime').volatile()

  getCalcdStartTime: ->
    return @get('startTime') unless @get('_startTimeHours')
    buildTimeString(
      @get('startTime'),
      @get('_startTimeHours')
      @get('_startTimeAmPm')
    )

  getCalcdEndTime: ->
    return @get('endTime') unless @get('_endTimeHours')
    buildTimeString(
      @get('endTime'),
      @get('endTimeHours')
      @get('endTimeAmPm')
    )
}

`export default OmissionTime`
