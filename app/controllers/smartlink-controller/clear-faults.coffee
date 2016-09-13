`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`

SmartlinkControllerClearFaultsController = Ember.Controller.extend ManualRunMixin,

  actions:
    clearFaults: ->
      self = this
      @get('loadingModal').send('open')
      Ember.RSVP.hash({
        instruction: @submitManualRun(clear_all_faults: true),
        reload: @get('model').reload()
      }).then (results) ->
        Ember.Logger.debug "Posted clear faults for controller: \
          #{self.get('model.id')}"
        self.get('loadingModal').send('loadInstruction', results.instruction)
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

`export default SmartlinkControllerClearFaultsController`
