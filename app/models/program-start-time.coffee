`import DS from 'ember-data'`

ProgramStartTime = DS.Model.extend {
  number:    DS.attr 'number'
  startTime: DS.attr 'string'

  # buhhh, somebody didn't follow conventions :(
  # aliased for now, should find/replace them to camelCase eventually
  start_time: Ember.computed.alias 'startTime'

  program: DS.belongsTo 'program', async: false
}

`export default ProgramStartTime`
