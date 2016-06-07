`import Ember from 'ember'`

SmartlinkControllerSettingsEditProgramRunTimeController = Ember.Controller.extend
  init: ->
    @initAvailableProgramTimes()

  initAvailableProgramTimes: ->
    opts = [{
      label: 'Off', value: 0
    }]

    [1..9].forEach( (minute) ->
      [1..11].forEach ( (second) ->
        second = second * 5
        second = "0#{second}" if second < 10
        str = "#{minute}:#{second}"
        opts.push({
          label: str, value: str
        })
      )
    )

    @set 'availableProgramTimes', opts

  actions:
    save: ->
      alert('TODO')

`export default SmartlinkControllerSettingsEditProgramRunTimeController`
