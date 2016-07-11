`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

SmartlinkControllerSettingsEditZoneRainSensorController = Ember.Controller.extend(SmartlinkSaveMixin, {

  saveUrl: Ember.computed 'model.id', ->
    baseUrl = @get('config.apiUrl')
    "#{baseUrl}/api/v2/controllers/#{@get('model.id')}/update_advanced_settings"

  actions:
    save: ->
      zoneParams = {}
      @get('model.zones').forEach (zone) ->
        key = "zone-#{zone.get('id')}-ignore-rain"
        if zone.get('usesRainSensor')
          zoneParams[key] = 'off'
        else
          zoneParams[key] = 'on'

      @save(
        url: @get('saveUrl')
        params: zoneParams
      )
})

`export default SmartlinkControllerSettingsEditZoneRainSensorController`
