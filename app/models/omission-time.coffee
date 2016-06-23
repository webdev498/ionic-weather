`import DS from 'ember-data'`

OmissionTime = DS.Model.extend {
  startTime:              DS.attr 'string'
  endTime:                DS.attr 'string'
  smartlinkController:    DS.belongsTo 'smartlink-controller'

  startTimeHours: Ember.computed 'startTime', ->
  	start = @get('startTime')
  	return null if (typeof(start) == 'undefined' || start == null)
  	moment(start).utc().format('hh:mm')

  startTimeAmPm: Ember.computed 'startTime', ->
  	start = @get('startTime')
  	return null if (typeof(start) == 'undefined' || start == null)
  	moment(start).utc().format('a')

  endTimeHours: Ember.computed 'endTime', ->
  	end = @get('endTime')
  	return null if (typeof(end) == 'undefined' || end == null)
  	moment(end).utc().format('hh:mm')

  endTimeAmPm: Ember.computed 'endTime', ->
  	end = @get('endTime')
  	return null if (typeof(end) == 'undefined' || end == null)
  	moment(end).utc().format('a')	
}

`export default OmissionTime`
