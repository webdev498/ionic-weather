`import Ember from 'ember'`

SmartlinkControllerIndexController = Ember.Controller.extend
  actions:
    refreshData: ->
      controller = this
      @set 'isLoading', true
      @get('model').reload().finally -> controller.set 'isLoading', false

`export default SmartlinkControllerIndexController`
