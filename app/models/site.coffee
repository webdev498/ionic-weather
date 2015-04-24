`import DS from 'ember-data'`

Site = DS.Model.extend
  name:                 DS.attr 'string', defaultValue: ''
  address1:             DS.attr 'string', defaultValue: ''
  address2:             DS.attr 'string', defaultValue: ''
  city:                 DS.attr 'string', defaultValue: ''
  state:                DS.attr 'string', defaultValue: ''
  postalCode:           DS.attr 'string', defaultValue: ''
  milesAway:            DS.attr 'number', defaultValue: 0
  controllersCount:     DS.attr 'number', defaultValue: 0
  faultsCount:          DS.attr 'number', defaultValue: 0
  smartlinkControllers: DS.hasMany 'smartlink-controller', async: true

  cityState: Ember.computed 'city', 'state', -> "#{@get('city')}, #{@get('state')}"

  fullAddress: Ember.computed 'address1', 'address2', 'city', 'state', 'postalCode', ->
    "#{@get('address1')} #{@get('address2') or ''} #{@get('city')}, #{@get('state')} #{@get('postalCode')}"

`export default Site`
