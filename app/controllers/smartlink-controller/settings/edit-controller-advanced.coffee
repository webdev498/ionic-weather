`import Ember from 'ember'`

SmartlinkControllerSettingsEditControllerAdvancedController = Ember.Controller.extend({
  init: ->
    @initNumberOfStarts()
    @initAvailableSlwDelayHours()
    @initAvailableRainDelays()
    @initAvailableZoneToZoneDelay()
    @initAvailableMasterValveZoneOnDelay()
    @initAvailableMasterValveZoneOffDelay()

  initNumberOfStarts: ->
    @set 'availableNumberOfStarts', [1..8]

  initAvailableSlwDelayHours: ->
    @set 'availableSlwDelayHours', [0..99].map( (n) ->
      { label: "#{n} hours", value: n }
    )

  initAvailableRainDelays: ->
    @set 'availableRainDelayDays', [0..14].map( (n) ->
      { label: "#{n} days", value: n }
    )

  initAvailableZoneToZoneDelay: ->
    opts = []
    [0..30].forEach( (n) ->
      opts.push { label: "#{n} minutes", value: n }
    )
    [31..45].forEach( (n) ->
      minutes = ((n - 30) * 10) + 30
      hours = Math.floor(minutes / 60)
      minutes = minutes % 60
      minutes = "0#{minutes}" if minutes < 10
      lbl = "0#{hours}:#{minutes}"
      opts.push { label: lbl, value: n }
    )
    @set 'availableZoneToZoneDelay', opts

  initAvailableMasterValveZoneOnDelay: ->
    @set 'availableMasterValveZoneOnDelay', [1..60].map( (n) ->
      { label: "#{n} min", value: n }
    )

  initAvailableMasterValveZoneOffDelay: ->
    @set 'availableMasterValveZoneOffDelay', [1..180].map( (n) ->
      hr = Math.floor(n / 60)
      min = n % 60
      min = "0#{min}" if min < 10
      { label: "0#{hr}:#{min}", value: n }
    )

})

`export default SmartlinkControllerSettingsEditControllerAdvancedController`
