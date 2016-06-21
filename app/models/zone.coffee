`import DS from 'ember-data'`

Zone = DS.Model.extend
  number:              DS.attr 'number'
  description:         DS.attr 'string'
  soilSlope:           DS.attr 'number'
  adjustment:          DS.attr 'number'
  sprinklerType:       DS.attr 'number'
  plantType:           DS.attr 'number'
  soilType:            DS.attr 'number'
  photo:               DS.attr 'string'
  photoThumbnail:      DS.attr 'string'
  realtimeFlowEnabled: DS.attr 'boolean'
  valveSize:           DS.attr 'number'
  ppg:                 DS.attr 'number'
  gpm:                 DS.attr 'number'
  lowFlowLimit:        DS.attr 'number'
  highFlowLimit:       DS.attr 'number'
  active:              DS.attr 'boolean'
  ignoreRain:          DS.attr 'boolean'
  ignoreFreeze:        DS.attr 'boolean'
  ignoreSensor:        DS.attr 'boolean'
  mvEnabled:           DS.attr 'boolean'

  smartlinkController: DS.belongsTo 'smartlinkController', async: false
  # programRunTimes: DS.hasMany 'program-run-time', async: true

  programARunTime: Ember.computed ->
    0

  programBRunTime: Ember.computed ->
    0

  programCRunTime: Ember.computed ->
    0

  programDRunTime: Ember.computed ->
    0

  usesRainSensor: Ember.computed 'ignoreRain', ->
    !@get('ignoreRain')

  usesFreezeSensor: Ember.computed 'ignoreFreeze', ->
    !@get('ignoreFreeze')

  usesSensorLoop: Ember.computed 'ignoreSensor', ->
    !@get('ignoreSensor')

`export default Zone`
