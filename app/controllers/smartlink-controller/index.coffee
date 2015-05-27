`import Ember from 'ember'`

SmartlinkControllerIndexController = Ember.Controller.extend
  application: Ember.inject.controller('application')

  queryParams: ['showCommLog']

  openOptionsMenu: false

  showCommLog: false

  isCommLogOpen: false

  setDefaults: ->
    @setProperties(
      openOptionsMenu: false
      isCommLogOpen: false
    )

  isCommLogOpenDidChange: Ember.observer 'isCommLogOpen', ->
    if @get('isCommLogOpen')
      @startPollingCommLog()
    else
      @stopPollingCommLog()

  startPollingCommLog: ->
    self = this
    Ember.Logger.debug('Starting comm log poll')
    intervalId = setInterval ->
      Ember.Logger.debug('Polling comm log')
      self.get('model.instructions').reload()
    , 3000
    @set('commLogPollingIntervalId', intervalId)

  stopPollingCommLog: ->
    Ember.Logger.debug('Stopping comm log poll')
    intervalId = @get('commLogPollingIntervalId')
    return unless intervalId
    clearInterval(intervalId)
    @set('commLogPollingIntervalId', null)

  actions:
    openOptionsMenu: ->
      @set('openOptionsMenu', true)

    closeOptionsMenu: ->
      @send('closeAllModals')

    openCommLog: ->
      @set('isCommLogOpen', true)

    closeCommLog: ->
      @send('closeAllModals')

    closeAllModals: ->
      @setProperties({
        openOptionsMenu: false,
        isCommLogOpen: false
      })

    refreshData: ->
      controller = this
      @set 'isLoading', true
      @get('model').reload().finally -> controller.set 'isLoading', false

`export default SmartlinkControllerIndexController`
