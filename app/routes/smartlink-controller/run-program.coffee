`import Ember from 'ember'`

SmartlinkControllerRunProgramRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'program', params.programId

  serialize: (model) ->
    programId: model.id

`export default SmartlinkControllerRunProgramRoute`
