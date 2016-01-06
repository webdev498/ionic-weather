`import DS from 'ember-data'`

Zone = DS.Model.extend
  number: DS.attr 'number'
  description: DS.attr 'string'
  soilSlope: DS.attr 'number'
  adjustment: DS.attr 'number'
  sprinklerType: DS.attr 'number'
  plantType: DS.attr 'number'
  soilType: DS.attr 'number'
  photo: DS.attr 'string'
  photoUrl: DS.attr 'string'

  smartlinkController: DS.belongsTo 'smartlinkController', async: false

`export default Zone`
