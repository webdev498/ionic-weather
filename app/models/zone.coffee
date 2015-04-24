`import DS from 'ember-data'`

Zone = DS.Model.extend
  number: DS.attr 'number'
  description: DS.attr 'string'

  smartlinkController: DS.belongsTo 'smartlinkController', async: true

`export default Zone`
