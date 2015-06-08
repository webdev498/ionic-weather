`import ManualRunMixin from '../../mixins/manual-run'`

SmartlinkControllerStopAllController = Ember.Controller.extend ManualRunMixin,
  needs: ['smartlinkController']
  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

  actions:
    stopAll: ->
      self = this
      params = {
        run_action: 'manual_stop_program'
      }
      @get('loadingModal').send('open')
      @submitManualRun(params).then (instruction) ->
        Ember.Logger.debug "Posted manual stop for controller: #{self.get('smartlinkController.id')}"
        self.get('loadingModal').send('loadInstruction', instruction)
      .catch (error) ->
        Ember.Logger.error(error)
        alert error
        self.get('loadingModal').send('close')

    loadingFinished: ->
      Ember.run.later this, ->
        @transitionToRoute('smartlink-controller.index')
      , 750

    loadingAbandoned: ->
      @transitionToRoute('smartlink-controller.index')

`export default SmartlinkControllerStopAllController`
