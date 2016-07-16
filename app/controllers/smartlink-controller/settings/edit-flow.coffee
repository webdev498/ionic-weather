`import Ember from 'ember'`
`import MetricFlowMixin from '../../../mixins/metric-flow'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`
`import Zone from '../../../models/zone'`

SmartlinkControllerSettingsEditFlowController = Ember.Controller.extend MetricFlowMixin, SmartlinkSaveMixin,
  setupDefaults: (model) ->
    @initAvailableValveSizes()
    @initAvailablePPGOptions()
    @initIsLowFlowLimitEnabled(model)
    @initIsHighFlowLimitEnabled(model)

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
    enabled = model.get('highFlowLimit') != Zone.HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER
    @set('isHighFlowLimitEnabled', enabled)

  availableFlowValues: Ember.computed 'isMetricEnabled', ->
    [1..99].map( (n) =>
      { label: @flowInLocalUnits(n), value: n }
    ).concat([10..70].map( (n) =>
      m = n * 10
      { label: @flowInLocalUnits(n), value: m }
    ))

  availableLowFlowValues: Ember.computed 'availableFlowValues', ->
    [{
      label: 'Off', value: 0
    }].concat(@get('availableFlowValues'))

  availableHighFlowValues: Ember.computed 'availableFlowValues', ->
    [{
      label: 'Off', value: Zone.HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER
    }].concat(@get('availableFlowValues'))

  isLowFlowLimitDisabled: Ember.computed 'isLowFlowLimitEnabled', ->
    !@get('isLowFlowLimitEnabled')

  isHighFlowLimitDisabled: Ember.computed 'isHighFlowLimitEnabled', ->
    !@get('isHighFlowLimitEnabled')

  saveUrl: Ember.computed 'model.smartlinkController.id', ->
    controllerId = @get('model.smartlinkController.id')
    zoneId = @get('model.id')
    "#{@get('baseUrl')}/api/v2/controllers/#{controllerId}/zones/#{zoneId}"

  timeoutThresholdMillis: 20000

  actions: {
    save: -> (
      if @get('isHighFlowLimitDisabled')
        @set('model.highFlowLimit', Zone.HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER)

      if @get('isLowFlowLimitDisabled')
        @set('model.lowFlowLimit', 0)

      @save(
        url: @get('saveUrl')
        params: {
          zone: {
            realtime_flow_enabled: @get('model.realtimeFlowEnabled')
            low_flow_limit:        @get('model.lowFlowLimit')
            high_flow_limit:       @get('model.highFlowLimit')
            valve_size:            @get('model.valveSize')
            ppg:                   @get('model.ppg')
          } }
      ).then =>
        @set('model.hasUnsentChanges', true)
    )
  }

`export default SmartlinkControllerSettingsEditFlowController`
