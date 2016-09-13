`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

SmartlinkControllerSettingsEditSeasonalAdjust = Ember.Controller.extend SmartlinkSaveMixin,
  init: ->
    @initAvailableSeasonalAdjustValues()

  initAvailableSeasonalAdjustValues: ->
    opts = []

    [0..60].forEach( (n) ->
      val = n * 5
      opts.push {
        label: "#{val}%", value: val
      }
    )

    @set 'availableSeasonalAdjustValues', opts

  saveUrl: (controllerId, programId) ->
    "#{@get('baseUrl')}/api/v2/controllers/#{controllerId}/programs/#{programId}/seasonal_adjustments/0"

  actions:
    save: ->
      @saveAll(['A', 'B', 'C', 'D'].map( (identifier) =>
        adj = @get("model.program#{identifier}SeasonalAdjust")
        {
          url: @saveUrl(
            @get('model.smartlinkController.id'),
            adj.get('program.id')
          )
          params: {
            percentage: adj.get('percentage')
            month: adj.get('month')
            wrap_result: true
          }
        }
      )).then =>
        @set('model.smartlinkController.hasUnsentChanges', true)


`export default SmartlinkControllerSettingsEditSeasonalAdjust`
