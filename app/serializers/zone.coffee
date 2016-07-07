`import ApplicationSerializer from './application'`

ZoneSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    smartlinkController:
      serialize: false
      deserialize: 'id'

  normalizeLinks: (data) ->
    data.smartlink_controller_id = data.controller_id
    delete data.controller_id
    this._super(arguments...)

`export default ZoneSerializer`
