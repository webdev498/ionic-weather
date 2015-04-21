`import Ember from 'ember'`

SmartlinkControllerSelectZoneRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('smartlinkController').get('zones')

`export default SmartlinkControllerSelectZoneRoute`
