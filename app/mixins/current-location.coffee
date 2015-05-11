`import Ember from 'ember'`

CurrentLocationMixin = Ember.Mixin.create
  getCurrentLocation: ->
    # TODO: really ask the device where it's at
    # maybe fall back to ip gelocation?
    {
      latitude: '38.4495690',
      longitude: '-78.8689160'
    }

`export default CurrentLocationMixin`
