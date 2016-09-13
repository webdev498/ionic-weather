`import DS from 'ember-data'`
`import { ActiveModelSerializer } from 'active-model-adapter'`

ProgramZoneSerializer = ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    program: {
      serialize: false
      deserialize: 'id'
    }
  }

})

`export default ProgramZoneSerializer`
