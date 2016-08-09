`import Ember from 'ember'`

SelectProgramItemComponent = Ember.Component.extend(
  cssClass: Ember.computed 'program.identifier', ->
    "weathermatic-select-program-#{@get('program.identifier').toLowerCase()}"
)

`export default SelectProgramItemComponent`
