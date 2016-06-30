`import DS from 'ember-data'`

formatTimeString = (timeString, format) ->
  return null if (typeof(timeString) == 'undefined' || timeString == null)
  moment(timeString).utc().format(format)

X = 0

OmissionTime = DS.Model.extend {
  startTime:              DS.attr 'string'
  endTime:                DS.attr 'string'
  smartlinkController:    DS.belongsTo 'smartlink-controller'

  startTimeHours: ( (key, value) ->
    X += 1
    if X > 20
      diediedie()

    Ember.Logger.debug 'args', arguments
    if typeof(value) == 'undefined' || value == null
      st = @get('startTime')
      Ember.Logger.debug 'get, startTime set to', st
      formatted = formatTimeString(st, 'hh:mm')
      Ember.Logger.debug 'formatted result: ', formatted
      return formatted
    else
      st = @get('startTime')
      Ember.Logger.debug 'set, startTime set to', st
      start = moment(st).utc()
      parts = value.split(':')
      start.hour(parts[0])
      start.minute(parts[1])
      newst = start.toISOString()
      Ember.Logger.debug 'setting new start time', newst
      @set 'startTime', newst
      return null
  ).property('startTime').cacheable(false)

#   startTimeAmPm: Ember.computed 'startTime', (key, value) ->
#     if arguments.length > 1
#       start = '2002-02-02'
#       # TODO: moment js stuf...
#       # @set 'startTime', start
#     else
#       formatTimeString(@get('startTime'), 'a')
#
#   endTimeHours: Ember.computed 'endTime', (key, value) ->
#     if arguments.length > 1
#       end = '2003-03-03'
#       #  @set 'endTime', end
#     else
#       formatTimeString(@get('endTime', 'hh:mm'))
#
#   endTimeAmPm: Ember.computed 'endTime', (key, value) ->
#     if arguments.length > 1
#       end = '2004-04-04'
#       # @set 'endTime', end
#     else
#       formatTimeString(@get('endTime', 'a'))
}

`export default OmissionTime`
