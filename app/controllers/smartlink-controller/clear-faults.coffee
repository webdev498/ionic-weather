`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`

SmartlinkControllerClearFaultsController = Ember.Controller.extend ManualRunMixin,
  needs: ['smartlinkController']

  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

  actions:
    clearFaults: ->
      self = this
      @get('loadingModal').send('open')
      Ember.RSVP.hash({
        instruction: @submitManualRun(clear_all_faults: true),
        reload: @get('smartlinkController').reload()
      }).then (results) ->
        Ember.Logger.debug "Posted clear faults for controller: \
          #{self.get('smartlinkController.id')}"
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
