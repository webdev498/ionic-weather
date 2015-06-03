`import ModalDialogComponent from './modal-dialog'`
`import InboundActions from 'ember-component-inbound-actions/inbound-actions'`
`import Instruction from '../models/instruction'`

LoadingModalComponent = ModalDialogComponent.extend InboundActions,
  instructionStatusCssClass: Ember.computed 'instruction.statusId', ->
    switch @get('instruction.statusId')
      when Instruction.STATUS_FINISHED then 'btn-positive'
      when Instruction.STATUS_ERROR then 'btn-negative'
      else 'btn-primary'

  instructionDidChange: Ember.observer 'instruction.statusId', ->
    return unless @get('instruction')
    switch
      when @get('instruction.isInProgress')
        @startPolling()
      when @get('instruction.isStatusError')
        @stopPolling()
      else
        @stopPolling()
        @sendAction('loadingFinished')

  startPolling: ->
    self = this
    if @get('pollingIntervalId')
      Ember.Logger.debug "Requested polling status for instruction: \
        #{@get('instruction.id')}, but polling already in progress"
      return
    Ember.Logger.debug "Start polling status for instruction: #{@get('instruction.id')}"
    intervalId = setInterval ->
      Ember.Logger.debug "Polling status for instruction: #{self.get('instruction.id')}"
      self.get('instruction').reload()
    , 1000
    @set('pollingIntervalId', intervalId)

  stopPolling: ->
    Ember.Logger.debug "Stop polling status for instruction: #{@get('instruction.id')}"
    intervalId = @get('pollingIntervalId')
    return unless intervalId
    clearInterval(intervalId)
    @set('pollingIntervalId', null)

  actions:
    loadInstruction: (instruction) ->
      @set('instruction', instruction)
      @send('open')

    open: ->
      @set('isActive', true)

    close: ->
      @set('isActive', false)
      @set('instruction', null)

`export default LoadingModalComponent`
