`import DS from 'ember-data'`

Zone = DS.Model.extend
  number: DS.attr 'number'
  description: DS.attr 'string'
  adjustment: DS.attr 'string'
  sprinkler_type: DS.attr 'string'
  plant_type: DS.attr 'string'
  soil_type: DS.attr 'string'
  soil_slope: DS.attr 'string'

  smartlinkController: DS.belongsTo 'smartlinkController', async: false

`export default Zone`