`import DS from 'ember-data'`

ProgramZone = DS.Model.extend {
    formattedRunTime: DS.attr 'string'
    programIdentifier: DS.attr 'string'

    zone: DS.belongsTo 'zone', async: true
    program: DS.belongsTo 'program', async: true

    fullRunTime: Ember.computed 'formattedRunTime', ->
      t = @get('formattedRunTime')
      "2000-01-01T#{t}:00.000Z"

    isOff: Ember.computed 'formattedRunTime', ->
      t = @get('formattedRunTime').split(':')
      parseInt(t[0]) == 0 && parseInt(t[1]) == 0

    isUsed: ( ->
      # If program D is used, A-C cannot be.  Inversely, if one of A-C is used, D is not allowed

      if @get('programIdentifier') == 'D'
        used = false
        @get('zone.programZones').forEach (pz) ->
          used = true if pz.get('programIdentifier') != 'D' && !pz.get('isOff')
        return used
      else
        programZoneD = @get('zone.programZones').findBy(
          'programIdentifier', 'D')
        !programZoneD.get('isOff')
    ).property('zone.programZones.@each.{formattedRunTime,programIdentifier}')
}

`export default ProgramZone`
