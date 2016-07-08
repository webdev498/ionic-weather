`import DS from 'ember-data'`

ProgramSeasonalAdjustment = DS.Model.extend {
  month:        DS.attr 'number'
  percentage:   DS.attr 'number'
  program:      DS.belongsTo 'program'
}

`export default ProgramSeasonalAdjustment`
