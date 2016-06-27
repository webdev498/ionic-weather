`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsEditProgramDetailsController = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    id = @paramsFor('smartlink-controller').controllerId
    @store.find('smartlink-controller', id).then (ctrl) ->
      ctrl.get('programs').find(params.programId)
})

`export default SmartlinkControllerSettingsEditProgramDetailsController`
