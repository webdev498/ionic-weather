`import Ember from 'ember'`

ProgramDetailsComponent = Ember.Component.extend(
  tagName: 'li'

  classNames: ['table-view-cell', 'weathermatic-select-program']

  classNameBindings: ['programClass']

  programClass: Ember.computed 'program.identifier', ->
    ident = @get('program.identifier').toLowerCase()
    "weathermatic-select-program-#{ident}"
)

`export default ProgramDetailsComponent`
