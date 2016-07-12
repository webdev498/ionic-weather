`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

SmartlinkControllerSettingsEditZoneActivationsController = Ember.Controller.extend(SmartlinkSaveMixin, {

  saveUrl: Ember.computed 'model.id', ->
    baseUrl = @get('config.apiUrl')
    "#{baseUrl}/api/v2/controllers/#{@get('model.id')}/update_advanced_settings"

  actions:
    save: ->
      zoneParams = {}
      @get('model.zones').forEach (zone) ->
        key = "zone-#{zone.get('id')}-active-sln"
        if zone.get('active')
          zoneParams[key] = 'on'
        else
          zoneParams[key] = 'off'

      @save(
        showLoadingModal: false
        url: @get('saveUrl')
        params: zoneParams
      )
})

`export default SmartlinkControllerSettingsEditZoneActivationsController`
