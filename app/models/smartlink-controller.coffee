`import DS from 'ember-data'`

RAIN_FREEZE_SENSOR_MODE_ACTIVE = 0

RUN_STATUS_OFF = 0
RUN_STATUS_RUN = 1
RUN_STATUS_REMOTE_OFF = 2
RUN_STATUS_RAIN_DELAY = 3

WATERING_MODE_STANDARD = 0
WATERING_MODE_AUTO   = 1

WEATHER_STATUS_NONE   = 0
WEATHER_STATUS_NORMAL = 1
WEATHER_STATUS_RAIN   = 2
WEATHER_STATUS_FREEZE = 3
WEATHER_STATUS_DELAY  = 4
WEATHER_STATUS_FAULT  = 5

FLOW_MODE_VIRTUAL = 0
FLOW_MODE_REALTIME = 1

CONTROLLER_MV_TYPE_NORMALLY_CLOSED = 0
CONTROLLER_MV_TYPE_NORMALLY_OPEN = 1

SmartlinkController = DS.Model.extend
  name:                     DS.attr 'string'
  runStatus:                DS.attr 'number'
  wateringMode:             DS.attr 'number'
  rainFreezeSensorMode:     DS.attr 'number'
  weatherStatus:            DS.attr 'number'
  canRunCommands:           DS.attr 'boolean'
  flowMode:                 DS.attr 'number'
  latitude:                 DS.attr 'number'
  numStarts:                DS.attr 'number'
  postalCode:               DS.attr 'string'
  slwDelay:                 DS.attr 'number'
  rainDelay:                DS.attr 'number'
  interzoneDelay:           DS.attr 'number'
  mvZoneOnDelay:            DS.attr 'number'
  mvZoneOffDelay:           DS.attr 'number'
  mv2ZoneOnDelay:           DS.attr 'number'
  mv2ZoneOffDelay:          DS.attr 'number'
  winterized:               DS.attr 'boolean'
  minDeficit:               DS.attr 'number'
  deviceTime:               DS.attr 'string'
  deviceTimeSampledAt:      DS.attr 'string'
  timezone:                 DS.attr 'string'
  autoSetTime:              DS.attr 'boolean'
  dstEnabled:               DS.attr 'boolean'
  dstStartDay:              DS.attr 'number'
  dstStartWeek:             DS.attr 'number'
  dstStartMonth:            DS.attr 'number'
  dstStopDay:               DS.attr 'number'
  dstStopWeek:              DS.attr 'number'
  dstStopMonth:             DS.attr 'number'
  hasUnsentChanges:         DS.attr 'boolean'
  hasDripZoneConstraint:    DS.attr 'boolean'
  commErrorInterval:        DS.attr 'number'
  hasSecondMasterValve:     DS.attr 'boolean'
  maxConcurrentPrograms:    DS.attr 'number'
  masterValveType:          DS.attr 'number'
  masterValve2Type:         DS.attr 'number'
  model:                    DS.attr 'string'

  site:                 DS.belongsTo 'site',        async: true

  faults:               DS.hasMany 'fault',         async: false
  programs:             DS.hasMany 'program',       async: true
  zones:                DS.hasMany 'zone',          async: true
  instructions:         DS.hasMany 'instruction',   async: true
  omissionDays:         DS.hasMany 'omission-day',  async: false
  omissionTimes:        DS.hasMany 'omission-time', async: false
  omissionDates:        DS.hasMany 'omission-date', async: false
  inspections:          DS.hasMany 'inspection', async: true


  isNormallyClosedMasterValve: Ember.computed 'masterValveType', ->
    @get('masterValveType') is CONTROLLER_MV_TYPE_NORMALLY_CLOSED

  isNormallyClosedMasterValve2: Ember.computed 'masterValve2Type', ->
    @get('masterValve2Type') is CONTROLLER_MV_TYPE_NORMALLY_CLOSED

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
      when WEATHER_STATUS_NONE   then 'None'
      when WEATHER_STATUS_NORMAL then 'Normal'
      when WEATHER_STATUS_RAIN   then 'Rain'
      when WEATHER_STATUS_FREEZE then 'Freeze'
      when WEATHER_STATUS_DELAY  then 'Delay'
      when WEATHER_STATUS_FAULT  then 'Fault'

  isWeatherNormal: Ember.computed 'weatherStatus', ->
    @get('weatherStatus') is WEATHER_STATUS_NORMAL

  isWeatherBad: Ember.computed 'weatherStatus', ->
    status = @get('weatherStatus')
    (status is WEATHER_STATUS_RAIN) or (status is WEATHER_STATUS_FREEZE) or (status is WEATHER_STATUS_FAULT)

  isRainFreezeSensorEnabled: Ember.computed 'rainFreezeSensorMode', ->
    @get('rainFreezeSensorMode') is RAIN_FREEZE_SENSOR_MODE_ACTIVE

  runStatusForHumans: Ember.computed 'runStatus', ->
    switch @get('runStatus')
      when RUN_STATUS_RUN then 'Run'
      when RUN_STATUS_OFF then 'Off'
      when RUN_STATUS_REMOTE_OFF then 'Remote Off'
      when RUN_STATUS_RAIN_DELAY then 'Rain Delay'

  isVirtualFlow: Ember.computed 'flowMode', ->
    @get('flowMode') == FLOW_MODE_VIRTUAL

  isRealtimeFlow: Ember.computed 'flowMode', ->
    @get('flowMode') == FLOW_MODE_REALTIME

  programA: Ember.computed 'programs.@each.id', ->
    @get('programs').findBy('identifier', 'A')

  programB: Ember.computed 'programs.@each.id', ->
    @get('programs').findBy('identifier', 'B')

  programC: Ember.computed 'programs.@each.id', ->
    @get('programs').findBy('identifier', 'C')

  programD: Ember.computed 'programs.@each.id', ->
    @get('programs').findBy('identifier', 'D')

  activeZones: Ember.computed 'zones.@each.active', ->
    @get('zones').filterBy('active', true)

  skipTransmitAttrs: ['commErrorInterval', 'winterized', 'autoSetTime', 'hasUnsentChanges']

  needsTransmit: ->
    needsTransmit = false
    Object.keys(@changedAttributes()).forEach (attr) =>
      if @skipTransmitAttrs.indexOf(attr) < 0
        needsTransmit = true
    return needsTransmit

  clearChangedAttributes: ->
    # LOL! suck it ember data!
    # Since we don't use [ember-data model].save, but instead
    # use our own SmartlinkSave mixin to do ajax calls out of band
    # from ember-data (because our APIs are kinda weird), sometimes
    # we need to tell ember-data that yes, we have actually saved the
    # model, even though .save() was never actually called.
    @set '_attributes', {}

SmartlinkController.reopenClass({
  RAIN_FREEZE_SENSOR_MODE_ACTIVE: RAIN_FREEZE_SENSOR_MODE_ACTIVE

  RUN_STATUS_OFF: RUN_STATUS_OFF
  RUN_STATUS_RUN: RUN_STATUS_RUN
  RUN_STATUS_REMOTE_OFF: RUN_STATUS_REMOTE_OFF
  RUN_STATUS_RAIN_DELAY: RUN_STATUS_RAIN_DELAY

  WATERING_MODE_STANDARD: WATERING_MODE_STANDARD
  WATERING_MODE_AUTO: WATERING_MODE_AUTO

  WEATHER_STATUS_NONE: WEATHER_STATUS_NONE
  WEATHER_STATUS_NORMAL: WEATHER_STATUS_NORMAL
  WEATHER_STATUS_RAIN: WEATHER_STATUS_RAIN
  WEATHER_STATUS_FREEZE: WEATHER_STATUS_FREEZE
  WEATHER_STATUS_DELAY: WEATHER_STATUS_DELAY
  WEATHER_STATUS_FAULT: WEATHER_STATUS_FAULT

  FLOW_MODE_VIRTUAL: FLOW_MODE_VIRTUAL
  FLOW_MODE_REALTIME: FLOW_MODE_REALTIME

  CONTROLLER_MV_TYPE_NORMALLY_CLOSED: CONTROLLER_MV_TYPE_NORMALLY_CLOSED
  CONTROLLER_MV_TYPE_NORMALLY_OPEN: CONTROLLER_MV_TYPE_NORMALLY_OPEN
});

`export default SmartlinkController`
