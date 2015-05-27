`import Ember from 'ember'`
`import ManualRunMixin from '../../mixins/manual-run'`

SmartlinkControllerRunProgramController = Ember.Controller.extend ManualRunMixin,
  actions:
    runProgram: ->
      self = this

      params = {
        program: @get('programNumber')
      }

      Ember.RSVP.all([
        @submitManualRun(params),
        self.get('smartlinkController.instructions').reload()
      ]).then ->
        self.transitionToRoute('smartlink-controller.index', queryParams: {
          showCommLog: true
        })

  cssClass: Ember.computed 'model.identifier', ->
    "weathermatic-btn-run-program-#{@get('model.identifier').toLowerCase()}"

  programNumber: Ember.computed 'model.identifier', ->
    switch @get('model.identifier')
      when 'A' then 1
      when 'B' then 2
      when 'C' then 3
      when 'D' then 4

`export default SmartlinkControllerRunProgramController`
