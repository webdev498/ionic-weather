`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`

SmartlinkControllerRunProgramController = Ember.Controller.extend ManualRunMixin,
  actions:
    runProgram: ->
      self = this
      params = {
        program: @get('programNumber')
      }
      @get('loadingModal').send('open')
      @submitManualRun(params).then (instruction) ->
        Ember.debug "Posted run program: #{self.get('programNumber')} \
          for controller: #{self.get('model.smartlinkController.id')}"
        self.get('loadingModal').send('loadInstruction', instruction)
      .catch (error) ->
        Ember.Logger.error(error)
        alert error
        self.get('loadingModal').send('close')

    loadingFinished: ->
      Ember.run.later this, ->
        @get('loadingModal').send('close')
      , 750

  cssClass: Ember.computed 'model.identifier', ->
    "weathermatic-btn-run-program-#{@get('model.identifier').toLowerCase()}"

  programNumber: Ember.computed 'model.identifier', ->
    switch @get('model.identifier')
      when 'A' then 1
      when 'B' then 2
      when 'C' then 3
      when 'D' then 4

`export default SmartlinkControllerRunProgramController`
