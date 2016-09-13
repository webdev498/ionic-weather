`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsEditProgramDetailsController = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    @store.find('program', params.programId)

  setupController: (controller, model) ->
    this._super(arguments...)
    # model.programStartTimes = model._data.program_start_times
    # controller.set 'model', model
    controller.setDefaults()

  serialize: (model, params) ->
    { programId: model.get('id') }
})

`export default SmartlinkControllerSettingsEditProgramDetailsController`
