`import Ember from 'ember'`

SmartlinkControllerSelectValvesRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('smartlinkController').get('zones')

`export default SmartlinkControllerSelectValvesRoute`
