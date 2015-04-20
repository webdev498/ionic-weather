`import DS from 'ember-data'`

Site = DS.Model.extend
  name:                 DS.attr 'string'
  address1:             DS.attr 'string', defaultValue: ''
  address2:             DS.attr 'string', defaultValue: ''
  city:                 DS.attr 'string', defaultValue: ''
  state:                DS.attr 'string', defaultValue: ''
  postalCode:           DS.attr 'string', defaultValue: ''
  smartlinkControllers: DS.hasMany 'smartlink-controller', async: true
  milesAway:            DS.attr 'number', defaultValue: 0

  faultsCount: Ember.computed 'faults', ->
    totalFaults = 0
    @get('smartlinkControllers').forEach (smartlinkController) ->
      totalFaults += smartlinkController.get('faults.length')
    totalFaults

  faultsCountText: Ember.computed 'faultsCount', ->
    if count = @get('faultsCount')
      return '1 fault' if count == 1
      "#{count} faults"

  cityState: Ember.computed 'city', 'state', -> "#{@get('city')}, #{@get('state')}"

  fullAddress: Ember.computed 'address1', 'address2', 'city', 'state', 'postalCode', ->
    "#{@get('address1')} #{@get('address2') or ''} #{@get('city')}, #{@get('state')} #{@get('postalCode')}"

  controllersCountText: Ember.computed 'smartlinkControllers', ->
    if count = @get('smartlinkControllers.length')
      return '1 controller' if count == 1
      "#{count} controllers"
    else
      "no controllers"

Site.reopenClass
  FIXTURES: [
    { id: 1, name: 'Mega Mansion', address1: '1400 Fake Ave', city: 'Dallas', state: 'TX', postalCode: '75063', milesAway: 1, \
      smartlinkControllers: [1,2,3,4] },
    { id: 2, name: 'Mobile Home', address1: '315 Treeview Ave', city: 'Duncanville', state: 'TX', postalCode: '74201', milesAway: 10 }
  ]

`export default Site`
