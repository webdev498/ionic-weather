`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

SmartlinkControllerSettingsEditZoneFreezeSensorController = Ember.Controller.extend(SmartlinkSaveMixin, {

  saveUrl: Ember.computed 'model.id', ->
    "#{@get('baseUrl')}/api/v2/controllers/#{@get('model.id')}/update_advanced_settings"

  zoneUsesFreezeSensorDidChange: Ember.observer('model.zones.@each.usesFreezeSensor', ->
    this.send('save')
  )

  actions:
    save: ->
      zoneParams = {}
      @get('model.zones').forEach (zone) ->
        key = "zone-#{zone.get('id')}-ignore-freeze"
        if zone.get('usesFreezeSensor')
          zoneParams[key] = 'off'
        else
          zoneParams[key] = 'on'

      @save(
        showLoadingModal: false
        url: @get('saveUrl')
        params: zoneParams
      ).then( =>
        @set('model.hasUnsentChanges', true)
      )
})

`export default SmartlinkControllerSettingsEditZoneFreezeSensorController`
