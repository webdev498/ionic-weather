`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

SmartlinkControllerSettingsEditControllerBasicController = Ember.Controller.extend(SmartlinkSaveMixin, {

  init: ->
    @initAvailableHours()
    @initAvailableMinutes()
    @initAvailalbleAmPm()
    @initAvailableTimezones()
    @initAvailableRunStatuses()
    @initAvailableWateringModes()
    @initAvailableRainFreeze()

  saveUrl: Ember.computed 'model.id', ->
    baseUrl = @get('config.apiUrl')
    "#{baseUrl}/api/v2/controllers/#{@get('model.id')}/update_basic_settings"

  deviceTimeHours: Ember.computed 'model.currentDeviceTime', ->
    moment(@get('model.deviceTime')).utc().format('hh')

  deviceTimeMinutes: Ember.computed 'model.currentDeviceTime', ->
    moment(@get('model.deviceTime')).utc().format('mm')

  deviceTimeAmPm: Ember.computed 'model.currentDeviceTime', ->
    moment(@get('model.deviceTime')).utc().format('a')

  deviceTimeDate: Ember.computed 'model.currentDeviceTime', ->
    moment(@get('model.deviceTime')).utc().format('YYYY-MM-DD')

  actions: {
    save: -> (
      date = moment(@get('deviceTimeDate')).utc()
      @save(
        url: @get('saveUrl')
        params: {
          'date-month': date.format('M')
          'date-day': date.format('D')
          'date-year': date.format('Y')
          'date-hour': @get('deviceTimeHours')
          'date-minute': @get('deviceTimeMinutes')
          'date-ampm': @get('deviceTimeAmPm')
          'tz': @get('model.timezone')
          'control': {
            run_status: @get('model.runStatus')
            mode: @get('model.wateringMode')
            sensor_mode: @get('model.rainFreezeSensorMode')
          }
        }
      ).then =>
        @set('model.hasUnsentChanges', true)
    )
  }

  transmitUrl: (smartlinkControllerId) ->
    "#{@get('config.apiUrl')}/api/v2/controllers/#{smartlinkControllerId}/transmit"


  initAvailableHours: ->
    opts = [{ label: '', value: null }]
    [1..12].forEach( (n) ->
      n = "#{n}"
      n = "0#{n}" if n < 10
      opts.push({ label: n, value: n })
    )
    @set 'availableHours', opts

  initAvailableMinutes: ->
    opts = [{ label: 'MM', value: null }]
    [1..59].forEach( (n) ->
      n = "#{n}"
      n = "0#{n}" if n < 10
      opts.push({ label: n, value: n })
    )
    @set 'availableMinutes', opts

  initAvailalbleAmPm: ->
    @set 'availableAmPm', [{
      label: 'am', value: 'am'
    }, {
      label: 'pm', value: 'pm'
    }]

  initAvailableRunStatuses: ->
    @set 'availableRunStatuses', [
      { label: 'Run', value: 1 }
      { label: 'Remote Off', value: 2 }
      { label: 'Rain Delay', value: 3 }
    ]

  initAvailableWateringModes: ->
    @set 'availableWateringModes', [
      { label: 'Standard', value: 0 }
      { label: 'Auto-Adjust', value: 1 }
    ]

  initAvailableRainFreeze: ->
    @set 'availableRainFreeze', [
      { label: 'Active', value: 0 }
      { label: 'Bypass', value: 1 }
    ]

  initAvailableTimezones: ->
    timezones = [
      "Eastern Time (US & Canada)"
      "Central Time (US & Canada)"
      "Mountain Time (US & Canada)"
      "Pacific Time (US & Canada)"
      "American Samoa"
      "International Date Line West"
      "Midway Island"
      "Hawaii"
      "Alaska"
      "Tijuana"
      "Arizona"
      "Chihuahua"
      "Mazatlan"
      "Central America"
      "Guadalajara"
      "Mexico City"
      "Monterrey"
      "Saskatchewan"
      "Bogota"
      "Indiana (East)"
      "Lima"
      "Quito"
      "Atlantic Time (Canada)"
      "Caracas"
      "Georgetown"
      "La Paz"
      "Santiago"
      "Newfoundland"
      "Brasilia"
      "Buenos Aires"
      "Greenland"
      "Montevideo"
      "Mid-Atlantic"
      "Azores"
      "Cape Verde Is."
      "Casablanca"
      "Dublin"
      "Edinburgh"
      "Lisbon"
      "London"
      "Monrovia"
      "UTC"
      "Amsterdam"
      "Belgrade"
      "Berlin"
      "Bern"
      "Bratislava"
      "Brussels"
      "Budapest"
      "Copenhagen"
      "Ljubljana"
      "Madrid"
      "Paris"
      "Prague"
      "Rome"
      "Sarajevo"
      "Skopje"
      "Stockholm"
      "Vienna"
      "Warsaw"
      "West Central Africa"
      "Zagreb"
      "Athens"
      "Bucharest"
      "Cairo"
      "Harare"
      "Helsinki"
      "Istanbul"
      "Jerusalem"
      "Kaliningrad"
      "Kyiv"
      "Pretoria"
      "Riga"
      "Sofia"
      "Tallinn"
      "Vilnius"
      "Baghdad"
      "Kuwait"
      "Minsk"
      "Moscow"
      "Nairobi"
      "Riyadh"
      "St. Petersburg"
      "Volgograd"
      "Tehran"
      "Abu Dhabi"
      "Baku"
      "Muscat"
      "Samara"
      "Tbilisi"
      "Yerevan"
      "Kabul"
      "Ekaterinburg"
      "Islamabad"
      "Karachi"
      "Tashkent"
      "Chennai"
      "Kolkata"
      "Mumbai"
      "New Delhi"
      "Sri Jayawardenepura"
      "Kathmandu"
      "Almaty"
      "Astana"
      "Dhaka"
      "Novosibirsk"
      "Urumqi"
      "Rangoon"
      "Bangkok"
      "Hanoi"
      "Jakarta"
      "Krasnoyarsk"
      "Beijing"
      "Chongqing"
      "Hong Kong"
      "Irkutsk"
      "Kuala Lumpur"
      "Perth"
      "Singapore"
      "Taipei"
      "Ulaanbaatar"
      "Osaka"
      "Sapporo"
      "Seoul"
      "Tokyo"
      "Yakutsk"
      "Adelaide"
      "Darwin"
      "Brisbane"
      "Canberra"
      "Guam"
      "Hobart"
      "Melbourne"
      "Port Moresby"
      "Sydney"
      "Vladivostok"
      "Magadan"
      "New Caledonia"
      "Solomon Is."
      "Srednekolymsk"
      "Auckland"
      "Fiji"
      "Kamchatka"
      "Marshall Is."
      "Wellington"
      "Chatham Is."
      "Nuku'alofa"
      "Samoa"
      "Tokelau Is."
    ]
    @set 'availableTimezones', timezones.map (tz) ->
      {
        label: tz.replace("&", "&amp;")
        value: tz
      }
})

`export default SmartlinkControllerSettingsEditControllerBasicController`
