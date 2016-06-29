`import DS from 'ember-data'`

formatTimeString = (timeString, format) ->
	return null if (typeof(timeString) == 'undefined' || timeString == null)
	moment(timeString).utc().format(format)

OmissionTime = DS.Model.extend {
  startTime:              DS.attr 'string'
  endTime:                DS.attr 'string'
  smartlinkController:    DS.belongsTo 'smartlink-controller'

  startTimeHours: Ember.computed 'startTime', (key, value) -> 
  	if arguments.length > 1
  		start = moment(@get('startTime')).utc()
  		parts = value.split(':')
  		start.hour(parts[0])
  		start.minute(parts[1])
  		debugger
  		@set 'startTime', start.toISOString()
  	else
  		formatTimeString(@get('startTime'), 'hh:mm')	

  startTimeAmPm: Ember.computed 'startTime', (key, value) ->
  	if arguments.length > 1
  		start = '2002-02-02'
  		# TODO: moment js stuf...
  		@set 'startTime', start
  	else
  		formatTimeString(@get('startTime'), 'a')

  endTimeHours: Ember.computed 'endTime', (key, value) ->
  	if arguments.length > 1 
  		end = '2003-03-03'
  		@set 'endTime', end
  	else
  		formatTimeString(@get('endTime', 'hh:mm'))

	endTimeAmPm: Ember.computed 'endTime', (key, value) ->
		if arguments.length > 1
			end = '2004-04-04'
			@set 'endTime', end
		else
			formatTimeString(@get('endTime', 'a'))
}

`export default OmissionTime`
