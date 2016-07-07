`import DS from 'ember-data'`

ProgramSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin,
  attrs:
    programStartTimes:
      serialize: 'records'
      deserialize: 'records'
    smartlinkController:
      serialize: false
      deserialize: 'id'

  normalizeLinks: (data) ->
    data.smartlink_controller_id = data.controller_id
    delete data.controller_id
    this._super(arguments...)
)

`export default ProgramSerializer`
