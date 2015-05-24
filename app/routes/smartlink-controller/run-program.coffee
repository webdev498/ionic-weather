`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerRunProgramRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @store.find 'program', params.programId

`export default SmartlinkControllerRunProgramRoute`
