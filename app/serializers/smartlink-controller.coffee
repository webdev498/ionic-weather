`import DS from 'ember-data'`

SmartlinkControllerSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    site:
      serialize: 'id'
      deserialize: 'id'
    faults:
      serialize: false
      deserialize: 'records'
    omissionDays:
      serialize: false
      deserialize: 'records'
    omissionTimes:
      serialize: false
      deserialize: 'records'

  keyForAttribute: (attr) ->
    switch attr
      when 'weatherStatus' then 'sw_status'
      when 'wateringMode' then 'mode'
      when 'rainFreezeSensorMode' then 'sensor_mode'
      when 'canRunCommands' then 'run_remote'
      else this._super(attr)

  keyForRelationship: (rawKey, kind) ->
    this._super(arguments...)
    switch rawKey
      when 'omissionDays' then 'controller_omission_days'
      when 'omissionTimes' then 'controller_omission_times'
      else this._super(arguments...)

  normalizePayload: (payload) ->
    if payload.controller
      payload.smartlinkController = payload.controller
      delete payload.controller

    if payload.controllers
      payload.smartlinkController = payload.controllers
      delete payload.controllers

    payload

`export default SmartlinkControllerSerializer`
