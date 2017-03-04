`import DS from 'ember-data'`

Inspection = DS.Model.extend
  title:              DS.attr 'number'
  description:         DS.attr 'string'

  smartlinkController: DS.belongsTo 'smartlinkController', async: true

`export default Inspection`