`import DS from 'ember-data'`

ProgramSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin,
  attrs:
    programStartTimes:
      serialize: 'records'
      deserialize: 'records'
)

`export default ProgramSerializer`
