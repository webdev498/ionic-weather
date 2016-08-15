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

  transmitUrl: Ember.computed 'model.id', ->
    "#{@get('config.apiUrl')}/api/v2/controllers/#{@get('model.id')}/transmit"

  receiveUrl: Ember.computed 'model.id', ->
    "#{@get('config.apiUrl')}/api/v2/controllers/#{@get('model.id')}/receive"

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

    transmit: ->
      @save(
        url: @get('transmitUrl')
      ).catch( (errors) ->
        alert errors.join('. ')
      ).then => (
        @set 'model.hasUnsentChanges', false
      ).finally => (
        @send 'openCommLog'
      )

    receive: ->
      @save(
        url: @get('receiveUrl')
      ).catch( (errors) ->
        alert errors.join('. ')
      ).finally => (
        @send 'openCommLog'
      )

)

`export default SmartlinkControllerIndexController`
