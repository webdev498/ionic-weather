`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`
`import MetricFlowMixin from '../../../mixins/metric-flow'`

SmartlinkControllerSettingsEditControllerAdvancedController = Ember.Controller.extend(SmartlinkSaveMixin, MetricFlowMixin, {
  init: ->
    @initNumberOfStarts()
    @initAvailableSlwDelayHours()
    @initAvailableRainDelays()
    @initAvailableZoneToZoneDelay()
    @initAvailableMasterValveZoneOnDelay()
    @initAvailableMasterValveZoneOffDelay()
    @initAvailableMinDeficit()
    @initNumberOfStarts()
    @initAvailableDaysOfWeek()
    @initAvailableWeeksOfMonth()
    @initAvailableMonths()

  initNumberOfStarts: ->
    @set 'availableNumberOfStarts', [1..8]

  initAvailableSlwDelayHours: ->
    @set 'availableSlwDelayHours', [0..99].map( (n) ->
      { label: "#{n} hr", value: n }
    )

  initAvailableRainDelays: ->
    @set 'availableRainDelayDays', [0..14].map( (n) ->
      { label: "#{n} days", value: n }
    )

  initAvailableZoneToZoneDelay: ->
    opts = []
    [0..30].forEach( (n) ->
      opts.push { label: "#{n} min", value: n }
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
    @set 'availableMasterValveZoneOnDelay', [0..60].map( (n) ->
      { label: "#{n} sec", value: n }
    )

  initAvailableMasterValveZoneOffDelay: ->
    @set 'availableMasterValveZoneOffDelay', [0..180].map( (n) ->
      hr = Math.floor(n / 60)
      min = n % 60
      min = "0#{min}" if min < 10
      { label: "0#{hr}:#{min}", value: n }
    )

  initAvailableMinDeficit: ->
    @set 'availableMinDeficit', [0..10].map (n) =>
      val = n * 0.05
      { label: @sizeInLocalUnits(val), value: n }

  initAvailableDaysOfWeek: ->
    @set 'availableDaysOfWeek', [
      { label: 'Sun', value: 0 }
      { label: 'Mon', value: 1 }
      { label: 'Tue', value: 2 }
      { label: 'Wed', value: 3 }
      { label: 'Thu', value: 4 }
      { label: 'Fri', value: 5 }
      { label: 'Sat', value: 6 }
    ]

  initAvailableWeeksOfMonth: ->
    @set 'availableWeeksOfMonth', [
      { label: '1st wk', value: 0 }
      { label: '2nd wk', value: 1 }
      { label: '3rd wk', value: 2 }
      { label: '4th wk', value: 3 }
    ]

  initAvailableMonths: ->
    @set 'availableMonths', [
      { label: 'Jan', value: 0 }
      { label: 'Feb', value: 1 }
      { label: 'Mar', value: 2 }
      { label: 'Apr', value: 3 }
      { label: 'May', value: 4 }
      { label: 'Jun', value: 5 }
      { label: 'Jul', value: 6 }
      { label: 'Aug', value: 7 }
      { label: 'Sep', value: 8 }
      { label: 'Oct', value: 9 }
      { label: 'Nov', value: 10 }
      { label: 'Dec', value: 11 }
    ]

  saveUrl: Ember.computed 'model.id', ->
    baseUrl = @get('config.apiUrl')
    "#{baseUrl}/api/v2/controllers/#{@get('model.id')}/update_advanced_settings"

  actions: {
    save: -> (
      @save(
        url: @get('saveUrl')
        params: {
          auto_set_time: if @get('model.autoSetTime') then 'on' else null
          dst_enabled:   if @get('model.dstEnabled') then 'on' else null
          control: {
            num_starts:        @get('model.numStarts')
            slw_delay:         @get('model.slwDelay')
            rain_delay:        @get('model.rainDelay')
            interzone_delay:   @get('model.interzoneDelay')
            mv_zone_on_delay:  @get('model.mvZoneOnDelay')
            mv_zone_off_delay: @get('model.mvZoneOffDelay')
            min_deficit:       @get('model.minDeficit')
            dst_start_day:     @get('model.dstStartDay')
            dst_start_week:    @get('model.dstStartWeek')
            dst_start_month:   @get('model.dstStartMonth')
            dst_stop_day:      @get('model.dstStopDay')
            dst_stop_week:     @get('model.dstStopWeek')
            dst_stop_month:    @get('model.dstStopMonth')
          }
        }
      ).then =>
        @set('model.hasUnsentChanges', true)
    )
  }

})

`export default SmartlinkControllerSettingsEditControllerAdvancedController`
