`import Ember from 'ember'`

SmartlinkControllerSettingsEditSeasonalAdjust = Ember.Controller.extend
  init: ->
    @initAvailableSeasonalAdjustValues()

  initAvailableSeasonalAdjustValues: ->
    opts = []

    [1..60].forEach( (n) ->
      val = n * 5
      opts.push {
        label: "#{val}%", value: val
      }
    )

    @set 'availableSeasonalAdjustValues', opts

  actions:
    save: ->
      alert('TODO')

`export default SmartlinkControllerSettingsEditSeasonalAdjust`
