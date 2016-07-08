`import DS from 'ember-data'`

Program = DS.Model.extend
  identifier:           DS.attr 'string', defaultValue: ''
  description:          DS.attr 'string'
  maxRun:               DS.attr 'number'
  minSoak:              DS.attr 'number'
  daysOfWeek:           DS.attr 'string'
  daysInterval:         DS.attr 'number'
  oddeven:              DS.attr 'number'
  intervalStart:        DS.attr 'number'
  programType:          DS.attr 'number'

  # buhhh, somebody didn't follow conventions :(
  # aliased for now, should find/replace them to camelCase eventually
  program_type:   Ember.computed.alias 'programType'
  days_of_week:   Ember.computed.alias 'daysOfWeek'
  days_interval:  Ember.computed.alias 'daysInterval'
  interval_start: Ember.computed.alias 'intervalStart'
  min_soak:       Ember.computed.alias 'minSoak'

  smartlinkController:  DS.belongsTo 'smartlinkController', async: true
  programStartTimes: DS.hasMany 'program-start-time', async: false
  programSeasonalAdjustments: DS.hasMany 'program-seasonal-adjustment', async: false

`export default Program`
