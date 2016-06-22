`import Ember from 'ember'`



SmartlinkControllerSettingsEditOmitTimesController = Ember.Controller.extend({
  init: ->
    @initAvailableOmitTimes()
    @initTimeSuffix()

  initAvailableOmitTimes: ->
    opts = []

    time_array = []
    i = 0
    while i < 72
      time_array.push i
      i++

    opts.push {label: "Off", value: 0}

    time_array.forEach( (n) ->
      time = moment().startOf('day').add(n*10, 'minutes').format('hh:mm')

      opts.push({label: time, value: time})
    )
    @set 'availableOmitTimes', opts

  initTimeSuffix: ->
    @set 'timeSuffix', [
      {label: "am", value: 'am'},
      {label: "pm", value: 'pm'}
    ]

})

`export default SmartlinkControllerSettingsEditOmitTimesController`