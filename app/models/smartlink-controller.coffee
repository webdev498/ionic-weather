`import DS from 'ember-data'`

RAIN_FREEZE_SENSOR_MODE_ACTIVE = 0

RUN_STATUS_ACTIVE = 1

WATERING_MODE_STATUS_MANUAL = 0
WATERING_MODE_STATUS_AUTO   = 1

WEATHER_STATUS_NORMAL = 1
WEATHER_STATUS_RAIN   = 2
WEATHER_STATUS_FREEZE = 3

SmartlinkController = DS.Model.extend
  name:                 DS.attr 'string'
  runStatus:            DS.attr 'number'
  wateringMode:         DS.attr 'number'
  rainFreezeSensorMode: DS.attr 'number'
  weatherStatus:        DS.attr 'number'
  canRunCommands:       DS.attr 'boolean'
  site:                 DS.belongsTo 'site',      async: true
  faults:               DS.hasMany 'fault',       async: false
  programs:             DS.hasMany 'program',     async: false
  zones:                DS.hasMany 'zone',        async: false
  instructions:         DS.hasMany 'instruction', async: true

  isRunning: Ember.computed 'status', ->
    @get('runStatus') is RUN_STATUS_ACTIVE

  isManualWateringMode: Ember.computed 'wateringMode', ->
    @get('wateringMode') is WATERING_MODE_STATUS_MANUAL

  isSmartWateringMode: Ember.computed 'wateringMode', ->
    @get('wateringMode') is WATERING_MODE_STATUS_AUTO

  weather: Ember.computed 'weatherStatus', ->
    switch @get('weatherStatus')
      when WEATHER_STATUS_NORMAL  then 'Normal'
      when WEATHER_STATUS_RAIN    then 'Rain'
      when WEATHER_STATUS_FREEZE  then 'Freeze'

  isWeatherNormal: Ember.computed 'weatherStatus', ->
    @get('weatherStatus') is WEATHER_STATUS_NORMAL

  isWeatherBad: Ember.computed 'weatherStatus', ->
    status = @get('weatherStatus')
    (status is WEATHER_STATUS_RAIN) or (status is WEATHER_STATUS_FREEZE)

  isRainFreezeSensorEnabled: Ember.computed 'rainFreezeSensorMode', ->
    @get('rainFreezeSensorMode') is RAIN_FREEZE_SENSOR_MODE_ACTIVE

`export default SmartlinkController`
