`import DS from 'ember-data'`

SmartlinkController = DS.Model.extend
  name:   DS.attr('string')
  site:   DS.belongsTo('site')
  faults: DS.hasMany('fault', async: true)

  faultsCountText: Ember.computed 'faults.length', ->
    if count = @get('faults.length')
      return '1 fault' if count == 1
      "#{count} faults"

SmartlinkController.reopenClass
  FIXTURES: [
    { id: 1, name: 'Main Lawn', site: 1, faults: [1] }
    { id: 2, name: 'South Flower Beds', site: 1, faults: [2,3] }
    { id: 3, name: 'North Flower Beds', site: 1 }
    { id: 4, name: 'Shrubs and Bushes', site: 1 }
    { id: 5, name: 'East Lawn', site: 2 }
    { id: 6, name: 'West Lawn', site: 2 }
  ]

`export default SmartlinkController`
