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
  mv2Enabled:          DS.attr 'boolean'
  runningAverageFlow:  DS.attr 'number'
  currentAverageFlow:  DS.attr 'number'

  smartlinkController: DS.belongsTo 'smartlinkController', async: true
  programZones: DS.hasMany 'program-zone', async: false

  programZoneA: Ember.computed 'programZones', ->
    @get('programZones').findBy('programIdentifier', 'A')

  programZoneB: Ember.computed 'programZones', ->
    @get('programZones').findBy('programIdentifier', 'B')

  programZoneC: Ember.computed 'programZones', ->
    @get('programZones').findBy('programIdentifier', 'C')

  programZoneD: Ember.computed 'programZones', ->
    @get('programZones').findBy('programIdentifier', 'D')

  usesRainSensor: Ember.computed 'ignoreRain', ->
    @get('ignoreRain') == false

  usesFreezeSensor: Ember.computed 'ignoreFreeze', ->
    @get('ignoreFreeze') == false

  usesSensorLoop: Ember.computed 'ignoreSensor', ->
    @get('ignoreSensor') == false

  realtimeFlowDisabled: Ember.computed 'realtimeFlowEnabled', ->
    !@get('realtimeFlowEnabled')

Zone.reopenClass
  HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER: 65535


`export default Zone`
