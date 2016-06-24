`import DS from 'ember-data'`

OmissionDate = DS.Model.extend {
  date:                    DS.attr 'string'
  smartlinkController:     DS.belongsTo 'smartlink-controller'

  monthNumber: Ember.computed 'date', ->
  	date = @get('date')
  	return 0 if (typeof(date) == 'undefined' || date == null)
  	parseInt(moment(date).format('M'))

  dayNumber: Ember.computed 'date', ->
    date = @get('date')
    return 0 if (typeof(date) == 'undefined' || date == null)
    parseInt(moment(date).format('D'))
}

`export default OmissionDate`
