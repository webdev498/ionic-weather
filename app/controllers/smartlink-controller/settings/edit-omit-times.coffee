`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`
`import OmissionTime from '../../../models/omission-time'`
`import leftPad  from '../../../util/strings/left-pad'`
`import { translationMacro as t } from 'ember-i18n'`

SmartlinkControllerSettingsEditOmitTimesController = Ember.Controller.extend(SmartlinkSaveMixin, {
  i18n: Ember.inject.service(),
  init: ->
    @initAvailableOmitTimes()
    @initTimeSuffix()
    @initDaysOfWeek()
    @initMonthsOfYear()
    @initDaysOfMonth()

  initAvailableOmitTimes: ->
    opts = [{label: this.get('i18n').t('common.off'), value: OmissionTime.OFF_VALUE }]
    [0...72].forEach (n) ->
      time = moment().startOf('day').add(n * 10, 'minutes').format('hh:mm')
      opts.push({label: time, value: time})

    @set 'availableOmitTimes', opts

  initTimeSuffix: ->
    @set 'timeSuffix', [
      {label: this.get('i18n').t('common.am'), value: 'am'},
      {label: this.get('i18n').t('common.pm'), value: 'pm'}
    ]

  initDaysOfWeek: ->
    @set 'daysOfWeek', ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']

  initMonthsOfYear: ->
    opts = [{label: this.get('i18n').t('common.off'), value: 0}]
    [1..12].forEach (n) ->
      month = moment().startOf('year').add(n-1, 'month').format('MMM')
      opts.push({label: month, value: n})
    @set 'monthsOfYear', opts

  initDaysOfMonth: ->
    opts = [{label: this.get('i18n').t('common.off'), value: 0}]
    [1..31].forEach (n) ->
      opts.push({label: n, value: n})
    @set 'daysOfMonth', opts

  omissionDates: Ember.computed 'model.omissionDates.length', ->
    dates = @get('model.omissionDates').toArray()
    [1..15].map (n) =>
      Ember.Object.create({
        number: n
        object: dates[n-1] || Ember.Object.create()
      })

  omissionDayNumbers: Ember.computed 'model.omissionDays.length', ->
    @get('model.omissionDays').map (omissionDay) ->
      omissionDay.get('day')

  isSundaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').indexOf(0) >= 0

  isMondaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').indexOf(1) >= 0

  isTuesdaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').indexOf(2) >= 0

  isWednesdaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').indexOf(3) >= 0

  isThursdaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').indexOf(4) >= 0

  isFridaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').indexOf(5) >= 0

  isSaturdaySelected: Ember.computed 'omissionDayNumbers', ->
    @get('omissionDayNumbers').indexOf(6) >= 0

  omissionTime: Ember.computed 'model.omissionTimes.length', ->
    @get('model.omissionTimes.firstObject') || @get('model.omissionTimes').createRecord()

  saveUrl: Ember.computed 'model.id', 'baseUrl', ->
    "#{@get('baseUrl')}/api/v2/controllers/#{@get('model.id')}/controller_omissions"

  getOmissionDateProperties: ->
    @get('omissionDates').map( (omissionDate) ->
      od = omissionDate.get('object')
      return null if od.get('dayNumber') == 0 || od.get('monthNumber') == 0
      m = leftPad(2, od.get('monthNumber'))
      d = leftPad(2, od.get('dayNumber'))
      date = moment("2016-#{m}-#{d}", "YYYY-MM-DD", true)
      return null unless date.isValid()
      {
        id: omissionDate.get('object.id')
        date: date.toISOString()
      }
    ).filter((item) ->
      item != null
    )


  getOmissionDayProperties: ->
    map = [
      'isSundaySelected', 'isMondaySelected', 'isTuesdaySelected',
      'isWednesdaySelected', 'isThursdaySelected', 'isFridaySelected',
      'isSaturdaySelected'
    ]

    [0..6].map( (n) =>
      if @get(map[n])
        omissionDay = @get('model.omissionDays').findBy('day', n)
        if omissionDay
          return omissionDay.getProperties('id', 'day')
        else
          return { day: n }
      else
        null
    ).filter((item) ->
      item != null
    )

  getOmissionTimeProperties: ->
    ot = @get('omissionTime')
    [
      {
        id: ot.get('id')
        start_time: ot.get('startTime')
        end_time: ot.get('endTime')
      }
    ]

  actions:
    save: ->
      @save(
        url: @get('saveUrl')
        params: {
          allow_destroy: true
          controller_omissions: {
            controller_omission_dates: @getOmissionDateProperties()
            controller_omission_days: @getOmissionDayProperties()
            controller_omission_times: @getOmissionTimeProperties()
          }
        }
      ).then =>
        @get('model').reload();
        @set('model.hasUnsentChanges', true)

})

`export default SmartlinkControllerSettingsEditOmitTimesController`
