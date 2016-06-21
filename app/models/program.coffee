`import DS from 'ember-data'`

Program = DS.Model.extend
  identifier:           DS.attr 'string', defaultValue: ''
  description:          DS.attr 'string'
  maxRun:               DS.attr 'number'
  minSoak:              DS.attr 'number'

  smartlinkController:  DS.belongsTo 'smartlinkController'

`export default Program`
