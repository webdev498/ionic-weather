`import Ember from 'ember'`
`import InboundActions from 'ember-component-inbound-actions/inbound-actions'`

CommLogComponent = Ember.Component.extend InboundActions,
  actions:
    open: ->
      @set('isOpen', true)

    close: ->
      @set('isOpen', false)
      @sendAction('close')

    startPolling: ->
      self = this
      Ember.Logger.debug('Starting comm log poll')
      intervalId = setInterval ->
        Ember.Logger.debug('Polling comm log')
        self.get('smartlinkController.instructions').reload()
      , 3000
      @set('pollingIntervalId', intervalId)

    stopPolling: ->
      Ember.Logger.debug('Stopping comm log poll')
      intervalId = @get('pollingIntervalId')
      return unless intervalId
      clearInterval(intervalId)
      @set('pollingIntervalId', null)

  isOpen: false

  isOpenDidChange: Ember.observer 'isOpen', ->
    if @get('isOpen')
      @send('startPolling')
    else
      @send('stopPolling')


`export default CommLogComponent`
