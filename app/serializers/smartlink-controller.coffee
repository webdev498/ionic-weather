`import DS from 'ember-data'`

SmartlinkControllerSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    site:
      serialize: 'id'
      deserialize: 'id'
    programs:
      serialize: false
      deserialize: 'records'
    faults:
      serialize: false
      deserialize: 'records'
    zones:
      serialize: false
      deserialize: 'records'

  keyForAttribute: (attr) ->
    switch attr
      when 'weatherStatus' then 'sw_status'
      when 'wateringMode' then 'mode'
      when 'rainFreezeSensorMode' then 'sensor_mode'
      when 'canRunCommands' then 'run_remote'
      else this._super(attr)

  normalizePayload: (payload) ->
    if payload.controller
      payload.smartlinkController = payload.controller
      delete payload.controller

    if payload.controllers
      payload.smartlinkController = payload.controllers
      delete payload.controllers

    payload

`export default SmartlinkControllerSerializer`
