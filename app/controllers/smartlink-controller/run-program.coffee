`import Ember from 'ember'`

SmartlinkControllerRunProgramController = Ember.Controller.extend
  cssClass: Ember.computed 'model.identifier', ->
    "weathermatic-btn-run-program-#{@get('model.identifier')}"

`export default SmartlinkControllerRunProgramController`
