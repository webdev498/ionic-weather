`import DS from 'ember-data'`

Instruction = DS.Model.extend
  instructionType:  DS.attr 'number'
  typeCommonName:   DS.attr 'string'
  exception:        DS.attr 'string'
  isOvernight:      DS.attr 'boolean'
  isCommand:        DS.attr 'boolean'
  status:           DS.attr 'string'
  statusId:         DS.attr 'number'
  action:           DS.attr 'string'
  user:             DS.attr 'string'
  startedAt:        DS.attr 'string'
  endedAt:          DS.attr 'string'
  delayRunTime:     DS.attr 'string'

  controller: DS.belongsTo 'smartlink-controller', async: true

  isStatusPending:  Ember.computed 'statusId', -> @get('statusId') is Instruction.STATUS_PENDING
  isStautsQueued:   Ember.computed 'statusId', -> @get('statusId') is Instruction.STATUS_QUEUED
  isStatusLocked:   Ember.computed 'statusId', -> @get('statusId') is Instruction.STATUS_LOCKED
  isStatusError:    Ember.computed 'statusId', -> @get('statusId') is Instruction.STATUS_ERROR
  isStatusFinished: Ember.computed 'statusId', -> @get('statusId') is Instruction.STATUS_FINISHED

  isInProgress: Ember.computed 'statusId', 'isOvernight', ->
    status = @get('statusId')
    (status is Instruction.STATUS_PENDING and not @get('isOvernight')) \
    or (status is Instruction.STATUS_QUEUED) \
    or (status is Instruction.STATUS_LOCKED) # locked means currently being processed

Instruction.reopenClass
  STATUS_PENDING:   0
  STATUS_QUEUED:    1
  STATUS_LOCKED:    2
  STATUS_ERROR:     3
  STATUS_FINISHED:  4


`export default Instruction`
