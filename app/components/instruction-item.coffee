`import Ember from 'ember'`
`import Instruction from '../models/instruction'`

InstructionItemComponent = Ember.Component.extend
  tagName: 'li'

  classNameBindings: ['instructionCssClass', ':table-view-cell']

  instructionCssClass: Ember.computed 'instruction.isCommand', ->

  statusCssClass: Ember.computed 'instruction.statusId', ->
    switch @get('instruction.statusId')
      when Instruction.STATUS_QUEUED then 'badge-primary'
      when Instruction.STATUS_FINISHED then 'badge-positive'
      when Instruction.STATUS_ERROR then 'badge-negative'
      when Instruction.STATUS_PENDING then 'weathermatic-badge-warning'

  iconName: Ember.computed 'instruction.typeCommonName', ->
    icon = switch @getWithDefault('instruction.typeCommonName', '').toLowerCase()
      when 'send' then 'exchange'
      when 'receive' then 'exchange'
      when 'command' then 'gears'
      else 'asterisk'
    return "#{icon} fa-lg"

`export default InstructionItemComponent`
