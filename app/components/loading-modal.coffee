`import ModalDialogComponent from './modal-dialog'`
`import InboundActions from 'ember-component-inbound-actions/inbound-actions'`

LoadingModalComponent = ModalDialogComponent.extend InboundActions,
  store: Ember.inject.service('store:main')

  instructionDidChange: Ember.observer 'instruction.status', ->
    return unless @get('instruction')
    if @get('instruction.isInProgress')
      @startPolling()
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

  instructionStatusCssClass: Ember.computed 'instruction.status', ->
    return 'btn-positive' if @get('instruction.isFinished')
    return 'btn-negative' if @get('instruction.isError')
    return 'btn-primary'

  actions:
    loadInstruction: (instructionData) ->
      instruction = @get('store').push('instruction', instructionData.result.instruction)
      @set('instruction', instruction)
      @send('open')

    open: ->
      @set('isActive', true)

    close: ->
      @set('isActive', false)
      @set('instruction', null)

`export default LoadingModalComponent`
