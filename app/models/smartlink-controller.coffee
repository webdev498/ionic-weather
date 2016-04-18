`import DS from 'ember-data'`

RAIN_FREEZE_SENSOR_MODE_ACTIVE = 0

RUN_STATUS_OFF = 0
RUN_STATUS_RUN = 1
RUN_STATUS_REMOTE_OFF = 2
RUN_STATUS_RAIN_DELAY = 3

WATERING_MODE_STANDARD = 0
WATERING_MODE_AUTO   = 1

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
  programs:             DS.hasMany 'program',     async: true
  zones:                DS.hasMany 'zone',        async: true
  instructions:         DS.hasMany 'instruction', async: true

  isRunning: Ember.computed 'runStatus', ->
    @get('runStatus') is RUN_STATUS_RUN

  isRunStatusOff: Ember.computed 'runStatus', ->
    @get('runStatus') is RUN_STATUS_OFF

  isWateringModeStandard: Ember.computed 'wateringMode', ->
    @get('wateringMode') is WATERING_MODE_STANDARD

  isWateringModeAuto: Ember.computed 'wateringMode', ->
    @get('wateringMode') is WATERING_MODE_AUTO

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

  runStatusForHumans: Ember.computed 'runStatus', ->
    switch @get('runStatus')
      when RUN_STATUS_RUN then 'Run'
      when RUN_STATUS_OFF then 'Off'
      when RUN_STATUS_REMOTE_OFF then 'Remote Off'
      when RUN_STATUS_RAIN_DELAY then 'Rain Delay'

`export default SmartlinkController`
