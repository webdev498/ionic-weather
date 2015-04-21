`import Ember from 'ember'`

SmartlinkControllerSelectProgramRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('smartlinkController').get('programs')

`export default SmartlinkControllerSelectProgramRoute`
