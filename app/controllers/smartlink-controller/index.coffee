`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../mixins/smartlink-save'`

SmartlinkControllerIndexController = Ember.Controller.extend(SmartlinkSaveMixin,
  application: Ember.inject.controller('application')

  queryParams: ['showCommLog']

  isOptionsMenuOpen: false

  showCommLog: false

  setDefaults: ->
    @send('closeOptionsMenu')

  runStatusCssClass: Ember.computed 'model.runStatus', ->
    return 'btn-positive' if @get('model.isRunning')
    return 'btn-negative' if @get('model.isRunStatusOff')
    return 'btn-primary'

  actions:
    goBack: ->
      if @get('model.site.smartlinkControllers.length') is 1
        @transitionToRoute 'sites'
      else
       @transitionToRoute 'site', @get('model.site')

    openOptionsMenu: ->
      @set('isOptionsMenuOpen', true)

    closeOptionsMenu: ->
      @set('isOptionsMenuOpen', false)

    openCommLog: ->
      @get('commLog').send('open')

    commLogClosed: ->
      @send('closeOptionsMenu')

    refreshData: ->
      window.location.reload()

)

`export default SmartlinkControllerIndexController`
