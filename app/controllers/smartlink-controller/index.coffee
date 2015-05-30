`import Ember from 'ember'`

SmartlinkControllerIndexController = Ember.Controller.extend
  application: Ember.inject.controller('application')

  queryParams: ['showCommLog']

  isOptionsMenuOpen: false

  showCommLog: false

  setDefaults: ->
    @send('closeOptionsMenu')

  actions:
    openOptionsMenu: ->
      @set('isOptionsMenuOpen', true)

    closeOptionsMenu: ->
      @set('isOptionsMenuOpen', false)

    openCommLog: ->
      @get('commLog').send('open')

    commLogClosed: ->
      @send('closeOptionsMenu')

    refreshData: ->
      self = this
      @send 'closeOptionsMenu'
      @set 'isLoading', true
      @get('model').reload().finally ->
        self.set 'isLoading', false

`export default SmartlinkControllerIndexController`
