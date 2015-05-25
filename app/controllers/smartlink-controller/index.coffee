`import Ember from 'ember'`

SmartlinkControllerIndexController = Ember.Controller.extend
  application: Ember.inject.controller('application')

  queryParams: ['showCommLog']

  openOptionsMenu: false

  showCommLog: false

  # TODO: rename to isCommLogOpen
  openCommLog: false

  setDefaults: ->
    @setProperties(
      openOptionsMenu: false
      openCommLog: false
    )

  actions:
    openOptionsMenu: ->
      @set('openOptionsMenu', true)

    closeOptionsMenu: ->
      @send('closeAllModals')

    openCommLog: ->
      @set('openCommLog', true)

    closeCommLog: ->
      @send('closeAllModals')

    closeAllModals: ->
      @setProperties({
        openOptionsMenu: false,
        openCommLog: false
      })

    refreshData: ->
      controller = this
      @set 'isLoading', true
      @get('model').reload().finally -> controller.set 'isLoading', false

`export default SmartlinkControllerIndexController`
