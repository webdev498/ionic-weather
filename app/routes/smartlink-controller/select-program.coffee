`import Ember from 'ember'`

SmartlinkControllerSelectProgramRoute = Ember.Route.extend
  model: (params) ->
    smartlinkController = @modelFor('smartlinkController')
    console.log smartlinkController
    smartlinkController.get('programs')

`export default SmartlinkControllerSelectProgramRoute`
