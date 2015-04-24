`import Ember from 'ember'`

SmartlinkControllerRunProgramController = Ember.Controller.extend
  needs: ['smartlinkController']

  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

  cssClass: Ember.computed 'model.identifier', ->
    "weathermatic-btn-run-program-#{@get('model.identifier').toLowerCase()}"

`export default SmartlinkControllerRunProgramController`
