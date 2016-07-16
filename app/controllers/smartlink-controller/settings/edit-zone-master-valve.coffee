`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

SmartlinkControllerSettingsEditZoneMasterValveController = Ember.Controller.extend(SmartlinkSaveMixin, {

  saveUrl: Ember.computed 'model.id', ->
    baseUrl = @get('config.apiUrl')
    "#{baseUrl}/api/v2/controllers/#{@get('model.id')}/update_advanced_settings"

  actions:
    save: ->
      zoneParams = {}
      @get('model.zones').forEach (zone) ->
        key = "zone-#{zone.get('id')}-mv-enable"
        if zone.get('mvEnabled')
          zoneParams[key] = 'on'
        else
          zoneParams[key] = 'off'

      @save(
        showLoadingModal: false
        url: @get('saveUrl')
        params: zoneParams
      ).then( =>
        @set('model.hasUnsentChanges', true)
      )

})

`export default SmartlinkControllerSettingsEditZoneMasterValveController`
