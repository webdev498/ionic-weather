`import Ember from 'ember'`

SmartlinkControllerSelectProgramItemController = Ember.Controller.extend
  cssClass: Ember.computed 'model.identifier', ->
    "weathermatic-select-program-#{@get('model.identifier').toLowerCase()}"

`export default SmartlinkControllerSelectProgramItemController`
