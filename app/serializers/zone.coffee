`import DS from 'ember-data'`
`import { ActiveModelSerializer } from 'active-model-adapter'`

ZoneSerializer = ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    smartlinkController:
      serialize: false
      deserialize: 'id'
    programZones:
      serialize: false
      deserialize: 'records'

  normalizeLinks: (data) ->
    data.smartlink_controller_id = data.controller_id
    delete data.controller_id
    this._super(arguments...)

`export default ZoneSerializer`
