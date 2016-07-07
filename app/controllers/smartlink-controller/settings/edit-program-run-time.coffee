`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

SmartlinkControllerSettingsEditProgramRunTimeController = Ember.Controller.extend(SmartlinkSaveMixin, {
  init: ->
    @initAvailableProgramTimes()

  initAvailableProgramTimes: -> (
    opts = [{
      label: 'Off', value: '00:00'
    }]

    # TODO: 0-:59 should be 1 sec intervals
    [1..9].forEach( (hr) ->
      [1..11].forEach ( (min) ->
        # XXX cleanup, use leftPad util here
        min = min * 5
        min = "0#{min}" if min < 10
        label = "#{hr}:#{min}"
        val = "0#{label}" if hr < 10
        opts.push({
          label: label, value: val
        })
      )
    )

    @set 'availableProgramTimes', opts
  )

  saveUrl: Ember.computed 'model.id', ->
    baseUrl = @get('config.apiUrl')
    zoneId = @get('model.id')
    "#{baseUrl}/api/v2/zones/#{zoneId}"

  actions: {
    save: -> (
      @save(
        url: @get('saveUrl')
        params: {
          zone: {
            program_zones: @get('model.programZones').map( (programZone) =>
              id: programZone.get('id')
              run_time: programZone.get('fullRunTime')
            )
          }
        }
      )
    )
  }
})

`export default SmartlinkControllerSettingsEditProgramRunTimeController`
