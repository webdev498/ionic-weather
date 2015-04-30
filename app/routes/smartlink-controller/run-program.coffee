`import Ember from 'ember'`

SmartlinkControllerRunProgramRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'program', params.programId

`export default SmartlinkControllerRunProgramRoute`
