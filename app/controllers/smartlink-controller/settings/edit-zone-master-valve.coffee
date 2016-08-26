`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

setMv1Params = (zone, params) ->
  key = "zone-#{zone.get('id')}-mv-enable"
  if zone.get('mvEnabled')
    params[key] = 'on'
  else
    params[key] = 'off'

setMv2Params = (zone, params) ->
  return unless zone.get('smartlinkController.hasSecondMasterValve')
  key = "zone-#{zone.get('id')}-mv2-enable"
  if zone.get('mv2Enabled')
    params[key] = 'on'
  else
    params[key] = 'off'

SmartlinkControllerSettingsEditZoneMasterValveController = Ember.Controller.extend(SmartlinkSaveMixin, {

  saveUrl: Ember.computed 'model.id', ->
    "#{@get('baseUrl')}/api/v2/controllers/#{@get('model.id')}/update_advanced_settings"

  zoneMasterValveDidChange: Ember.observer('model.zones.@each.{mvEnabled,mv2Enabled}', ->
    this.send('save')
  )

  actions:
    save: ->
      zoneParams = {}
      @get('model.zones').forEach (zone) ->
        setMv1Params(zone, zoneParams)
        setMv2Params(zone, zoneParams)

      @save(
        showLoadingModal: false
        url: @get('saveUrl')
        params: zoneParams
      ).then( =>
        @set('model.hasUnsentChanges', true)
      )

})

`export default SmartlinkControllerSettingsEditZoneMasterValveController`
