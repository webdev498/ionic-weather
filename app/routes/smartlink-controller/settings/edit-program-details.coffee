`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsEditProgramDetailsController = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    id = @paramsFor('smartlink-controller').controllerId
    @store.find('smartlink-controller', id).then (ctrl) ->
      ctrl.get('programs').find(params.programId)

  setupController: (controller, _model) ->
    this._super(arguments...)
    # _model.programStartTimes = _model._data.program_start_times
    # controller.set 'model', _model
    controller.setDefaults()

  serialize: (model, params) ->
    { programId: model.get('id') }
})

`export default SmartlinkControllerSettingsEditProgramDetailsController`
