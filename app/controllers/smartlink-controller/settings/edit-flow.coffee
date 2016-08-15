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
      0.75, 1.0, 1.25, 1.5, 2.0, 2.5, 3.0, 4.0
    ].map( (size) =>
      {
        label: @sizeInLocalUnits(size)
        value: size
      }
    )

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

  isLowFlowLimitDisabled: Ember.computed 'isLowFlowLimitEnabled', ->
    !@get('isLowFlowLimitEnabled')

  isHighFlowLimitDisabled: Ember.computed 'isHighFlowLimitEnabled', ->
    !@get('isHighFlowLimitEnabled')

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
    # changes the controllers. The view sets __pageLoaded in a didInsertElement.
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
            gpm:                   @get('gpmGallons')
          } }
      ).then =>
        @set('model.smartlinkController.hasUnsentChanges', true)
    )
  }

`export default SmartlinkControllerSettingsEditFlowController`
