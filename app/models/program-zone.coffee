`import DS from 'ember-data'`

ProgramZone = DS.Model.extend {
    formattedRunTime: DS.attr 'string'

    zone: DS.belongsTo 'zone', async: true
    program: DS.belongsTo 'program', async: true
}

`export default ProgramZone`
