`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`

SmartlinkControllerRunProgramController = Ember.Controller.extend ManualRunMixin,
  actions:
    runProgram: ->
      controller = this

      params = {
        program: @get('programNumber')
      }

      @submitManualRun(params).then ->
        controller.transitionToRoute('smartlink-controller.command-success')

  cssClass: Ember.computed 'model.identifier', ->
    "weathermatic-btn-run-program-#{@get('model.identifier').toLowerCase()}"

  programNumber: Ember.computed 'model.identifier', ->
    switch @get('model.identifier')
      when 'A' then 1
      when 'B' then 2
      when 'C' then 3
      when 'D' then 4

`export default SmartlinkControllerRunProgramController`
