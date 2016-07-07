`import DS from 'ember-data'`

ProgramZone = DS.Model.extend {
    formattedRunTime: DS.attr 'string'
    programIdentifier: DS.attr 'string'

    zone: DS.belongsTo 'zone', async: true
    program: DS.belongsTo 'program', async: true

    fullRunTime: Ember.computed 'formattedRunTime', ->
      t = @get('formattedRunTime')
      "2000-01-01T#{t}:00.000Z"
}

`export default ProgramZone`
