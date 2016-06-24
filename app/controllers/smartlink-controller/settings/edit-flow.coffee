`import Ember from 'ember'`
`import CurrentUserMixin from '../../../mixins/current-user'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

VOLUME_MEASURE_LITERS = 1

HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER = 65535

SmartlinkControllerSettingsEditFlowController = Ember.Controller.extend CurrentUserMixin, SmartlinkSaveMixin,
  setupDefaults: (model) ->
    @initAvailableFlowValues()
    @initAvailableValveSizes()
    @initAvailablePPGOptions()
    @initIsLowFlowLimitEnabled(model)
    @initIsHighFlowLimitEnabled(model)

  initAvailableFlowValues: ->
    opts = [
      { label: '', value: 0 }
    ].concat([1..99].map( (n) ->
      { label: n, value: n }
    )).concat([10..70].map( (n) ->
      m = n * 10
      { label: m, value: m }
    ))
    @set 'availableFlowValues', opts

  initAvailableValveSizes: ->
    @set 'availableValveSizes', [
      { label: '0.75"', value: 0.75 }
      { label: '1.00"', value: 1.00 }
      { label: '1.25"', value: 1.25 }
      { label: '1.50"', value: 1.50 }
      { label: '1.75"', value: 1.75 }
      { label: '2.00"', value: 2.00 }
      { label: '3.00"', value: 3.00 }
      { label: '4.00"', value: 4.00 }
    ]

  initAvailablePPGOptions: ->
    @set 'availablePPGOptions', [
      { label: '0.0', 0.0 }
    ]

  initIsLowFlowLimitEnabled: (model) ->
    enabled = model.get('lowFlowLimit') != 0
    @set('isLowFlowLimitEnabled', enabled)

  initIsHighFlowLimitEnabled: (model) ->
    enabled = model.get('highFlowLimit') != HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER
    @set('isHighFlowLimitEnabled', enabled)

  isLowFlowLimitDisabled: Ember.computed 'isLowFlowLimitEnabled', ->
    !@get('isLowFlowLimitEnabled')

  isHighFlowLimitDisabled: Ember.computed 'isHighFlowLimitEnabled', ->
    !@get('isHighFlowLimitEnabled')

  isLowFlowLimitEnabledDidChange: Ember.observer 'isLowFlowLimitEnabled', ->
    return unless @get('model')
    if !@get('isLowFlowLimitEnabled')
      @set('model.lowFlowLimit', 0)

  isHighFlowLimitEnabledDidChange: Ember.observer 'isHighFlowLimitEnabled', ->
    return unless @get('model')
    if !@get('isHighFlowLimitDisabled')
      @set('model.highFlowLimit', HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER)

  isMetricEnabled: Ember.computed 'currentUser', ->
    @get('currentUser.volume_measure') == VOLUME_MEASURE_LITERS

  saveUrl: Ember.computed 'model.smartlinkController.id', ->
    controllerId = @get('model.smartlinkController.id')
    zoneId = @get('model.id')
    "#{@get('baseUrl')}/api/v2/controllers/#{controllerId}/zones/#{zoneId}"

  timeoutThresholdMillis: 20000

  actions:
    save: ->
      @get('loadingModal').send('open')

      self = this
      url = @get('saveUrl')

      timeoutWatcher = null
      defaultErrorMessage = 'There was a problem communicating with our servers. Please try again later'

      allParams = {
        zone: {
          realtime_flow_enabled: @get('model.realtimeFlowEnabled')
          low_flow_limit:        @get('model.lowFlowLimit')
          high_flow_limit:       @get('model.highFlowLimit')
          valve_size:            @get('model.valveSize')
          ppg:                   @get('model.ppg')
        }
        timestamp: new Date().getTime()
      }

      savePromise = new Ember.RSVP.Promise (resolve, reject) ->

        timeoutWatcher = Ember.run.later(this, ->
          reject new Error(defaultErrorMessage)
        self.timeoutThresholdMillis)

        ajaxOptions = {
          type: 'PATCH'
          data: allParams
          success: (response) ->
            if Ember.get(response, 'meta.success')
              self.transitionToRoute('smartlink-controller.settings.flow',
                self.get('model.smartlinkController'))
            else
              message = Ember.get(response, 'result.instruction.exception')
              reject new Error(message)
          error: ->
            reject new Error(defaultErrorMessage)
        }

        Ember.$.ajax(url, ajaxOptions)

      savePromise
        .finally ->
          Ember.run.cancel(timeoutWatcher) if timeoutWatcher

    loadingFinished: ->
      Ember.run.later this, ->
        @transitionToRoute('smartlink-controller.index')
      , 750

    loadingAbandoned: ->
      @transitionToRoute('smartlink-controller.index')

`export default SmartlinkControllerSettingsEditFlowController`
