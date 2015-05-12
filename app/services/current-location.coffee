`import Ember from 'ember'`

CurrentLocationService = Ember.Service.extend
  getCurrentLocation: ->
    # TODO: really ask the device where it's at
    # maybe fall back to ip gelocation?
    {
      latitude: '38.4495690',
      longitude: '-78.8689160'
    }

`export default CurrentLocationService`
