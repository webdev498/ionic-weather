`import DS from 'ember-data'`

SmartlinkController = DS.Model.extend
  name:                 DS.attr 'string'
  status:               DS.attr 'string'
  wateringMode:         DS.attr 'string'
  rainFreezeProtection: DS.attr 'boolean'
  weather:              DS.attr 'attr'
  site:                 DS.belongsTo 'site'
  faults:               DS.hasMany 'fault', async: true
  programs:             DS.hasMany 'program', async: true

  isStatusActive: Ember.computed 'status', ->
    @get('status') is 'Active'

  isSmartWateringMode: Ember.computed 'wateringMode', ->
    @get('wateringMode') is 'Smart'

  isWeatherNormal: Ember.computed 'weather', ->
    @get('weather') is 'Normal'

  faultsCountText: Ember.computed 'faults.length', ->
    if count = @get('faults.length')
      return '1 fault' if count == 1
      "#{count} faults"

SmartlinkController.reopenClass
  FIXTURES: [
    { id: 1, name: 'Main Lawn', status: 'Run', wateringMode: 'Smart', rainFreezeProtection: true, weather: 'Normal', site: 1, faults: [1], programs: [1,2,3,4] }
    { id: 2, name: 'South Flower Beds', status: 'Off', wateringMode: 'Manual', rainFreezeProtection: false, weather: 'Rain', site: 1, faults: [2,3], programs: [5,6,7,8] }
    { id: 3, name: 'North Flower Beds', status: 'Off', wateringMode: 'Manual', rainFreezeProtection: false, weather: 'Rain', site: 1, programs: [9,10,11,12] }
    { id: 4, name: 'Shrubs and Bushes', status: 'Off', wateringMode: 'Manual', rainFreezeProtection: false, weather: 'Rain', site: 1, programs: [13,14,15,16] }
    { id: 5, name: 'East Lawn', status: 'Off', wateringMode: 'Manual', rainFreezeProtection: false, weather: 'Rain', site: 2, programs: [17,18,19,20] }
    { id: 6, name: 'West Lawn', status: 'Off', wateringMode: 'Manual', rainFreezeProtection: false, weather: 'Rain', site: 2, programs: [21,22,23,24] }
  ]

`export default SmartlinkController`
