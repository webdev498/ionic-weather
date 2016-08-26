`import Ember from 'ember'`
`import MetricFlowMixin from '../../../mixins/metric-flow'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`
`import Zone from '../../../models/zone'`

SmartlinkControllerSettingsEditFlowController = Ember.Controller.extend MetricFlowMixin, SmartlinkSaveMixin,
  setupDefaults: (model) ->
    @initAvailableValveSizes(model)
    @initAvailablePPGOptions()

  initAvailableValveSizes: (model) ->
    sizes = [
      0.75, 1.0, 1.25, 1.5, 2.0, 2.5, 3.0
    ].map( (size) =>
      {
        label: @sizeInLocalUnits(size)
        value: size
      }
    )
    if model.get('smartlinkController.isVirtualFlow')
      sizes = [{
        label: 'Not Set'
        value: 0.0
      }].concat(sizes)
    @set 'availableValveSizes', sizes

  initAvailablePPGOptions: ->
    @set 'availablePPGOptions', [
      { label: '0.0', 0.0 }
    ]

  availableFlowValues: Ember.computed 'isMetricEnabled', ->
    [1..99].map( (n) =>
      { label: @flowInLocalUnits(n), value: n }
    ).concat([10..35].map( (n) =>
      m = n * 10
      { label: @flowInLocalUnits(m), value: m }
    ))

  availableLowFlowValues: Ember.computed 'availableFlowValues', ->
    [{
      label: 'Off', value: 0
    }].concat(@get('availableFlowValues'))

  availableHighFlowValues: Ember.computed 'availableFlowValues', ->
    [{
      label: 'Off', value: Zone.HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER
    }].concat(@get('availableFlowValues'))

  saveUrl: Ember.computed 'model.smartlinkController.id', ->
    controllerId = @get('model.smartlinkController.id')
    zoneId = @get('model.id')
    "#{@get('baseUrl')}/api/v2/controllers/#{controllerId}/zones/#{zoneId}"

  timeoutThresholdMillis: 20000

  gpmInLocalUnits: Ember.computed 'model.gpm', 'isMetricEnabled', ->
    @flowValueInLocalUnits(@get('model.gpm'))

  gpmGallons: Ember.computed 'gpmInLocalUnits', 'isMetricEnabled', ->
    value = @get('gpmInLocalUnits')
    if @get('isMetricEnabled')
      @lpmToGpm(value)
    else
      value

  valveSizeDidChange: Ember.observer 'model.valveSize', ->
    return if @get('model.smartlinkController.isRealtimeFlow')
    # __pageLoaded works around the fact that change occurs while loading, I guess to
    # set the initial values. We only want to run this observer if the user actually
    # changes the controllers. The route sets __pageLoaded in `setupController`.
    return unless @get('__pageLoaded')
    valveSize = @get('model.valveSize')
    gpm = {
      0:    0
      0.75: 10
      1.0:  16
      1.25: 26
      1.5:  35
      2.0:  35
      2.5:  80
      3.0:  120
    }[valveSize]
    @set('model.gpm', gpm) if gpm?

  flowLimitPulses: (flowLimitGPM) ->
    if (flowLimitGPM == 0) || (flowLimitGPM == Zone.HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER)
      return flowLimitGPM

    ppg = @get('model.ppg') || 1
    Math.ceil(flowLimitGPM * ppg)

  realTimeFlowEnabledDidChange: Ember.observer('model.realtimeFlowEnabled', ->
    if @get('model.realtimeFlowEnabled')
      prevLow = @get('prevLowFlowLimit')
      prevHigh = @get('prevHighFlowLimit')
      if prevLow?
        @set('model.lowFlowLimit', prevLow)
        @set('prevLowFlowLimit', null)
      if prevHigh?
        @set('model.highFlowLimit', prevHigh)
        @set('prevHighFlowLimit', null)
    else
      @set('prevLowFlowLimit', parseInt(@get('model.lowFlowLimit')))
      @set('prevHighFlowLimit', parseInt(@get('model.highFlowLimit')))
      @set('model.lowFlowLimit', 0)
      @set('model.highFlowLimit', Zone.HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER)
  )

  actions: {
    save: -> (
      @save(
        url: @get('saveUrl')
        params: {
          zone: {
            realtime_flow_enabled: @get('model.realtimeFlowEnabled')
            low_flow_limit:        @flowLimitPulses(@get('model.lowFlowLimit'))
            high_flow_limit:       @flowLimitPulses(@get('model.highFlowLimit'))
            valve_size:            @get('model.valveSize')
            ppg:                   @get('model.ppg')
            gpm:                   @get('gpmGallons')
          } }
      ).then =>
        @set('model.smartlinkController.hasUnsentChanges', true)
    )
  }

`export default SmartlinkControllerSettingsEditFlowController`
