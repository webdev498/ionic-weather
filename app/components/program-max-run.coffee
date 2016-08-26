`import Ember from 'ember'`

ProgramMaxRunComponent = Ember.Component.extend
  tagName: 'div'
  classNames: ['card']

  programClass: Ember.computed 'program.identifier', ->
    ident = @get('program.identifier').toLowerCase()
    "weathermatic-select-program-#{ident}"

  availableMaxRun: Ember.computed ->
    [{ label: 'Off', value: 0 }].concat [1..30].map (n) ->
      { label: "#{n} min", value: n }

  availableMinSoak: Ember.computed ->
    [{label: 'Off', value: 0 }].concat [1..120].map (n) ->
      { label: "#{n} min", value: n }

  isMaxRunDisabled: Ember.computed 'program.maxRun', ->
    parseInt(@get('program.maxRun')) == 0

  minSoakCssClass: Ember.computed 'isMaxRunDisabled', ->
    if @get('isMaxRunDisabled')
      'invisible'
    else
      ''

`export default ProgramMaxRunComponent`
