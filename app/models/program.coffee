`import DS from 'ember-data'`

Program = DS.Model.extend
  identifier:           DS.attr 'string', defaultValue: ''
  description:          DS.attr 'string'
  smartlinkController:  DS.belongsTo 'smartlinkController'

`export default Program`
