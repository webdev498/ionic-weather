`import Ember from 'ember'`
`import MetricFlowMixin from '../../../mixins/metric-flow'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

SmartlinkControllerSettingsEditAutoAdjustController = Ember.Controller.extend(MetricFlowMixin, SmartlinkSaveMixin, {
  init: ->
    @initAvailableSprinklerTypesImperial()
    @initAvailableSprinklerTypesMetric()
    @initAvailablePlantTypes()
    @initAvailableSoilTypes()
    @initSlopeValues()
    @initMoreLessValues()

  initAvailableSprinklerTypesImperial: ->
    opts = []

    [
      { label: "Standard (non-ET)", value: 0 },
      { label: "Off", value: 1 },
      { label: "Spray (1.5\")", value: 2 },
      { label: "Rotor (0.5\")", value: 3 },
      { label: "Drip (1.1\")", value: 4 },
      { label: "Bubbler (2.3\")", value: 5 }
    ].forEach( (sprinklerType) ->
      opts.push sprinklerType
    )
    [20..199].forEach( (n) ->
      lbl = (n/100).toFixed(2)
      opts.push {label: "#{lbl}\"", value: n}
    )
    [20..30].forEach( (n) ->
      lbl = (n/10).toFixed(2)
      val = n*10
      opts.push {label: "#{lbl}\"", value: val}
    )

    @set 'availableSprinklerTypesImperial', opts

  initAvailableSprinklerTypesMetric: ->
    opts = []

    [
      { label: "Standard (non-ET)", value: 0 },
      { label: "Off", value: 1 },
      { label: "Spray (38.1 mm)", value: 2 },
      { label: "Rotor (12.7 mm)", value: 3 },
      { label: "Drip (27.9 mm)", value: 4 },
      { label: "Bubbler (58.4 mm)", value: 5 }
    ].forEach( (sprinklerType) ->
      opts.push sprinklerType
    )
    [20..199].forEach( (n) ->
      lbl = ((n/100)*25.4).toFixed(2)
      opts.push {label: "#{lbl} mm", value: n}
    )
    [20..30].forEach( (n) ->
      lbl = ((n/10)*25.4).toFixed(2)
      val = n*10
      opts.push {label: "#{lbl} mm", value: val}
    )

    @set 'availableSprinklerTypesMetric', opts

  initAvailablePlantTypes: ->
    opts = []
    [
      { label: "CTURF", value: 0 }
      { label: "WTURF", value: 1 }
      { label: "Shrubs", value: 2 }
      { label: "Annuals", value: 3 }
      { label: "Trees", value: 4 }
      { label: "Native", value: 5 }
    ].forEach( (plantType) ->
      opts.push plantType
    )
    [10..99].forEach((n) ->
      val = n
      opts.push {
        label: "#{val}%", value: val
      }
    )
    [10..30].forEach((n) ->
      val = n*10
      lbl = n*10
      opts.push {
        label: "#{lbl}%", value: val
      }
    )
    @set 'availablePlantTypes', opts

  initAvailableSoilTypes: ->
    @set 'availableSoilTypes', [
      {label: "Sand", value: 0}
      {label: "Loam", value: 1}
      {label: "Clay", value: 2}
    ]

  initSlopeValues: ->
    opts = []
    [0..25].forEach((n) ->
      opts.push {
        label: "#{n}º", value: n
      }
    )
    @set 'slopeValues', opts

  initMoreLessValues: ->
    opts = []
    [25..-50].forEach( (n) ->
      val = n
      opts.push {
        label: "#{val}%", value: val
      }
    )
    @set 'moreLessValues', opts

  saveUrl: Ember.computed 'model.smartlinkController.id', ->
    controllerId = @get('model.smartlinkController.id')
    zoneId = @get('model.id')
    baseUrl = @get('config.apiUrl')
    "#{baseUrl}/api/v2/controllers/#{controllerId}/zones/#{zoneId}"

  timeoutThresholdMillis: 20000

  actions: {
    save: -> (
      @save(
        url: @get('saveUrl')
        params: {
          zone: {
            sprinkler_type: @get('model.sprinklerType')
            plant_type: @get('model.plantType')
            soil_type: @get('model.soilType')
            soil_slope: @get('model.soilSlope')
            adjustment: @get('model.adjustment')
          }
        }
      ).then =>
        @set('model.smartlinkController.hasUnsentChanges', true)
    )
  }
})

`export default SmartlinkControllerSettingsEditAutoAdjustController`
