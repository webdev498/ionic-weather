`import Ember from 'ember'`

SmartlinkControllerIndexController = Ember.Controller.extend
  application: Ember.inject.controller('application')

  openOptionsMenu: false

  setDefaults: ->
    @setProperties(
      openOptionsMenu: false
    )

  actions:
    openOptionsMenu: ->
      @set('openOptionsMenu', true)

    closeOptionsMenu: ->
      @set('openOptionsMenu', false)

    logOut: ->


    refreshData: ->
      controller = this
      @set 'isLoading', true
      @get('model').reload().finally -> controller.set 'isLoading', false

`export default SmartlinkControllerIndexController`
