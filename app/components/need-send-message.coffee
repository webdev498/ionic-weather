`import Ember from 'ember'`
`import SmartlinkSaveMixin from './../mixins/smartlink-save'`

NeedSendMessageComponent = Ember.Component.extend(SmartlinkSaveMixin,
  classNames: ['needs-send-message-container']

  transmitUrl: Ember.computed 'model.id', ->
    "#{@get('config.apiUrl')}/api/v2/controllers/#{@get('smartlinkController.id')}/transmit"

  actions: {
    transmit: ->
      Ember.Logger.debug 'transmit action called from NeedSendMessageComponent'
      @sendAction('transmit', @get('smartlinkController'), @get('loadingModal'))
  }
)

`export default NeedSendMessageComponent`
