`import DS from 'ember-data'`

ProgramZoneSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    program: {
      serialize: false
      deserialize: 'id'
    }
  }

})

`export default ProgramZoneSerializer`
