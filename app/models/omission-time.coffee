`import DS from 'ember-data'`

formatTimeString = (timeString, format) ->
  return OmissionTime.OFF_VALUE if (typeof(timeString) == 'undefined' || timeString == null)
  moment(timeString).utc().format(format)

buildTimeString = (timeString, hoursMinutes, amPm) ->
  time = moment(timeString).utc()
  parts = hoursMinutes.split(':')
  time.hour(parts[0]).minute(parts[1])
  time.hour(time.hour() + 12) if amPm == 'pm'
  return null unless time.isValid()
  time.toISOString()

OmissionTime = DS.Model.extend {
  startTime:              DS.attr 'string'
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
      return 'am' if @get('_startTimeHours') == OmissionTime.OFF_VALUE
      @get('_startTimeAmPm') || formatTimeString(@get('startTime'), 'a')
    else
      @set '_startTimeAmPm', value
  ).property('startTime').volatile()

  endTimeHours: ( (key, value) ->
    if typeof(value) == 'undefined' || value == null
      @get('_endTimeHours') || formatTimeString(@get('endTime'), 'hh:mm')
    else
      @set '_endTimeHours', value
  ).property('endTime').volatile()

  endTimeAmPm: ( (key, value) ->
    if typeof(value) == 'undefined' || value == null
      return 'am' if @get('_endTimeHours') == OmissionTime.OFF_VALUE
      @get('_endTimeAmPm') || formatTimeString(@get('endTime'), 'a')
    else
      @set '_endTimeAmPm', value
  ).property('endTime').volatile()

  getCalcdStartTime: ->
    return @get('startTime') unless @get('_startTimeHours')
    return null if @get('_startTimeHours') == OmissionTime.OFF_VALUE
    buildTimeString(
      @get('startTime'),
      @get('_startTimeHours')
      @get('_startTimeAmPm')
    )

  getCalcdEndTime: ->
    return @get('endTime') unless @get('_endTimeHours')
    return null if @get('_endTimeHours') == OmissionTime.OFF_VALUE
    buildTimeString(
      @get('endTime'),
      @get('_endTimeHours')
      @get('_endTimeAmPm')
    )
}

OmissionTime.reopenClass(
  OFF_VALUE: 'OFF'
)

`export default OmissionTime`
