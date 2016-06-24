`import Ember from 'ember'`
# `import ProgramMixin from '../../mixins/program'`
# `import Base from 'simple-auth/authenticators/base'`
# `import AuthenticationMixin from '../../mixins/authentication'`
`import leftPad from '../../../util/strings/left-pad'`

formatTime = (type, value) ->
	if type is '12H'
		timeArr = value.split ':'
		hour = Number(timeArr[0])
		min = Number(timeArr[1])

		prepand = if hour >= 12 then ' PM ' else ' AM '
		hour = if hour > 12 then hour - 12 else hour
		hour = if hour == 0 then 12 else hour

		hour = leftPad(2, hour)
		min = leftPad(2, min)
		hour + ':' + min + prepand
	else
		timeArr = value.split ' '
		hourMinArr = timeArr[0].split ':'
		hour = Number(hourMinArr[0])
		min = Number(hourMinArr[1])

		if timeArr[1] is 'pm'
			if hour < 12
				hour = hour + 12
		else
			if hour is 12
				hour = 0

		hour = leftPad(2, hour)
		min = leftPad(2, min)
		hour + ':' + min

SmartlinkControllerProgramDetailController = Ember.Controller.extend
  needs: ['smartlinkController']

  smartlinkController: Ember.computed.alias 'controllers.smartlinkController.model'

  init: ->
    PROGRAM_TYPE_ENUM = {
      DAYS_OF_WEEK: 1,
      ODD_EVEN: 2,
      INTERVAL: 3
    }

    @set('PROGRAM_TYPE_ENUM', PROGRAM_TYPE_ENUM)

    programTypes = [
      {
        label: 'Day of Week'
        value: @get('PROGRAM_TYPE_ENUM').DAYS_OF_WEEK
      },
      {
        label: 'Odd/Even'
        value: @get('PROGRAM_TYPE_ENUM').ODD_EVEN
      },
      {
        label: 'Interval'
        value: @get('PROGRAM_TYPE_ENUM').INTERVAL
      }
    ]

    daysOfWeek = [
      {
        label: 'Sun',
        full: 'Sunday',
        value: 0,
        isOdd: true,
        checked: false,
        isException: false
      },
      {
        label: 'Mon',
        full: 'Monday',
        value: 1,
        isOdd: true,
        checked: false,
        isException: false
      },
      {
        label: 'Tue'
        full: 'Tuesday',
        value: 2,
        isOdd: true,
        checked: false,
        isException: false
      },
      {
        label: 'Wed'
        full: 'Wednesday',
        value: 3,
        isOdd: true,
        checked: false,
        isException: false
      },
      {
        label: 'Thu'
        full: 'Thursday',
        value: 4,
        isOdd: true,
        checked: false,
        isException: false
      },
      {
        label: 'Fri'
        full: 'Friday',
        value: 5,
        isOdd: true,
        checked: false,
        isException: false
      },
      {
        label: 'Sat'
        full: 'Saturday',
        value: 6,
        isOdd: true,
        checked: false,
        isException: false
      }
    ]

    @set('DaysOfWeek', daysOfWeek)

    oddEven = [
      {
        label: 'Run on Odd Days'
        value: 1
      },
      {
        label: 'Run on Even Days'
        value: 2
      }
    ]

    @set('OddEven', oddEven)

    timeSlots = [
      { id: 0, value: 'Off' },
      { id: 1, value: '12:00' },
      { id: 2, value: '12:10' },
      { id: 3, value: '12:20' },
      { id: 4, value: '12:30' },
      { id: 5, value: '12:40' },
      { id: 6, value: '12:50' },
      { id: 7, value: '01:00' },
      { id: 8, value: '01:10' },
      { id: 9, value: '01:20' },
      { id: 10, value: '01:30' },
      { id: 11, value: '01:40' },
      { id: 12, value: '01:50' },
      { id: 13, value: '02:00' },
      { id: 14, value: '02:10' },
      { id: 15, value: '02:20' },
      { id: 16, value: '02:30' },
      { id: 17, value: '02:40' },
      { id: 18, value: '02:50' },
      { id: 19, value: '03:00' },
      { id: 20, value: '03:10' },
      { id: 21, value: '03:20' },
      { id: 22, value: '03:30' },
      { id: 23, value: '03:40' },
      { id: 24, value: '03:50' },
      { id: 25, value: '04:00' },
      { id: 26, value: '04:10' },
      { id: 27, value: '04:20' },
      { id: 28, value: '04:30' },
      { id: 29, value: '04:40' },
      { id: 30, value: '04:50' },
      { id: 31, value: '05:00' },
      { id: 32, value: '05:10' },
      { id: 33, value: '05:20' },
      { id: 34, value: '05:30' },
      { id: 35, value: '05:40' },
      { id: 36, value: '05:50' },
      { id: 37, value: '06:00' },
      { id: 38, value: '06:10' },
      { id: 39, value: '06:20' },
      { id: 40, value: '06:30' },
      { id: 41, value: '06:40' },
      { id: 42, value: '06:50' },
      { id: 43, value: '07:00' },
      { id: 44, value: '07:10' },
      { id: 45, value: '07:20' },
      { id: 46, value: '07:30' },
      { id: 47, value: '07:40' },
      { id: 48, value: '07:50' },
      { id: 49, value: '08:00' },
      { id: 50, value: '08:10' },
      { id: 51, value: '08:20' },
      { id: 52, value: '08:30' },
      { id: 53, value: '08:40' },
      { id: 54, value: '08:50' },
      { id: 55, value: '09:00' },
      { id: 56, value: '09:10' },
      { id: 57, value: '09:20' },
      { id: 58, value: '09:30' },
      { id: 59, value: '09:40' },
      { id: 60, value: '09:50' },
      { id: 61, value: '10:00' },
      { id: 62, value: '10:10' },
      { id: 63, value: '10:20' },
      { id: 64, value: '10:30' },
      { id: 65, value: '10:40' },
      { id: 66, value: '10:50' },
      { id: 67, value: '11:00' },
      { id: 68, value: '11:10' },
      { id: 69, value: '11:20' },
      { id: 70, value: '11:30' },
      { id: 71, value: '11:40' },
      { id: 72, value: '11:50' }]

    @set('availableTimeSlots', timeSlots)

    amPM = ['am', 'pm']
    @set('availableAmPm', amPM)

    programInstance = {
      selectedProgramType: {},
      DaysOfWeek: []
      selectedDaysOfWeek: {
        value: [],
        label: 'Select Days of Week'
      },
      selectedOddEvenProgram: {},
      selectedIntervalProgram: {},
      programStartTimes: [],
      currentSelectedStartTime:{ id: 0 },
      currentSelectedAmPm:'am',
      currentSelectedTimeSlot:{ id: 0 },
    }

    @set('availableProgramTypes', programTypes)
    @set('programInstance', programInstance)

    isSetProgramTypeOpen: false
    isSetOddEvenOpen: false
    isSetIntervalOpen: false
    isSetStartTimeOpen: false

  setDefaults: ->
    self = this
    @set('programInstance.programStartTimes',@get('model.programStartTimes'))

    daysInterval = [1..30]
    @set('DaysInterval', daysInterval)

    type = @get('model.program_type')
    if type?
      progTypes = @get('availableProgramTypes')
      @set('programInstance.selectedProgramType', (progTypes.filter (p) -> p.value == type)[0])

    oddEven = @get('OddEven')
    @set('programInstance.selectedOddEvenProgram',(oddEven.filter (od) -> od.value == 1)[0])

    intervalProgram = {
      interval_start: 0,
      interval_start_label: 'Start on ' + @get('DaysOfWeek')[0].full
      days_interval: 1,
      days_interval_label: 'Run Every 1 day'
    }

    @set('programInstance.selectedIntervalProgram', intervalProgram)

    switch @get('programInstance.selectedProgramType').value
      when @get('PROGRAM_TYPE_ENUM').ODD_EVEN
        @set('programInstance.selectedOddEvenProgram',(oddEven.filter (od) -> od.value == self.get('model.oddeven'))[0])

      when @get('PROGRAM_TYPE_ENUM').INTERVAL
        intervalProgram = {
          interval_start: @get('model.interval_start'),
          interval_start_label: 'Start on ' + @get('DaysOfWeek')[@get('model.interval_start')].full
          days_interval: @get('model.days_interval'),
          days_interval_label: 'Run Every ' + @get('model.days_interval') + ' days'
        }

        @set('programInstance.selectedIntervalProgram', intervalProgram)

    @send('initProgram')

  actions:
    initProgram: ->
      self = this
      programDaysOfWeek = []
      selectedDaysOfWeek = []
      daysOfWeek = @get('DaysOfWeek').slice 0

      todayDate = new Date
      curr = new Date
      # get current date
      first = curr.getDate() - curr.getDay()
      # First day is the day of the month - the day of the week
      last = first + 6
      # last day is the first day + 6
      firstDate = new Date(curr.setDate(first))
      lastDate = new Date(curr.setDate(last))
      date = firstDate.getDate()
      day = firstDate.getDay()
      while firstDate <= lastDate
        if date == 31 || (firstDate.getMonth() == 1 &&  date == 29)
          daysOfWeek[day].isOdd = false
          daysOfWeek[day].isException = true

        if date % 2 == 0
          daysOfWeek[day].isOdd = false

        firstDate.setDate firstDate.getDate() + 1
        date = firstDate.getDate()
        day = firstDate.getDay()

      self.set('programInstance.DaysOfWeek', daysOfWeek)

      switch self.get('programInstance.selectedProgramType').value
        when self.get('PROGRAM_TYPE_ENUM').DAYS_OF_WEEK
          currentDaysOfWeekStr = self.get('model.days_of_week')
          currentDaysOfWeek = currentDaysOfWeekStr.split ","

          daysOfWeek.forEach (day, index, array) ->
            programDaysOfWeek.pushObject({ label: day.label, value: day.value, checked: day.checked})
            currentDaysOfWeek.forEach (value) ->
              if (''+ day.value) is value
                  programDaysOfWeek[index].checked = true
                  selectedDaysOfWeek.push value

          self.set('programInstance.selectedDaysOfWeek.value', selectedDaysOfWeek)

        when self.get('PROGRAM_TYPE_ENUM').ODD_EVEN
          daysOfWeek.forEach (day, index, array) ->
            programDaysOfWeek.pushObject({ label: day.label, value: day.value, checked: false})

            if (self.get('programInstance.selectedOddEvenProgram').value is 1)
              if (day.isOdd && !day.isException)
                programDaysOfWeek[index].checked = true
            else
              if (!day.isOdd && !day.isException)
                programDaysOfWeek[index].checked = true

        else
          interval_start = self.get('programInstance.selectedIntervalProgram').interval_start
          days_intreval = self.get('programInstance.selectedIntervalProgram').days_interval

          intervalDayIndex = interval_start

          daysOfWeek.forEach (day, index, array) ->
            programDaysOfWeek.pushObject({ label: day.label, value: day.value, checked: false})
            dayIndex = day.value

            if (intervalDayIndex is dayIndex)
              programDaysOfWeek[index].checked = true
              intervalDayIndex = intervalDayIndex + days_intreval

            if (intervalDayIndex >= 7)
              intervalDayIndex = intervalDayIndex % 7

      self.set('programInstance.DaysOfWeek', programDaysOfWeek)

    editProgram: ->
      self = this
      @get('loadingModal').send('open')

      progStartTimes = @get('programInstance.programStartTimes')

      program_start_times = new Array()
      progStartTimes.forEach (st, index, array) ->
        program_start_times.push { number: st.id, start_time: st.start_time }

      params = {
        id: Number(@get('model.id')),
        program: {
          description: if @get('model.description') then @get('model.description') else 'Program ' + @get('model.identifier'),
          program_type: @get('programInstance.selectedProgramType.value'),
          days_of_week: @get('programInstance.selectedDaysOfWeek.value').join(),
          oddeven:  @get('programInstance.selectedOddEvenProgram.value'),
          interval_start:  @get('programInstance.selectedIntervalProgram.interval_start'),
          days_interval:  @get('programInstance.selectedIntervalProgram.days_interval'),
          program_start_times: program_start_times
        }
      }

      @submitProgram(params).then (response) ->
        Ember.Logger.debug "Posted program #{self.get('model.id')} for controller: #{self.get('smartlinkController.id')}"
        self.get('smartlinkController').reload().finally ->
          self.send('loadingFinished')
      .catch (error) ->
        if error.type is 'Unprocessable Entity'
          Ember.Logger.debug 'Program Edit failed with unprocessable Entity'
          alert error.responseData.meta.message
        else
          Ember.Logger.error(error)
          alert error
        self.get('loadingModal').send('close')

    loadingFinished: ->
      Ember.run.later this, ->
        @get('loadingModal').send('close')
        @transitionToRoute('smartlink-controller.program-list')
      , 750

    loadingAbandoned: ->
      @get('loadingModal').send('close')
      @transitionToRoute('smartlink-controller.program-list')

    setProgramTypeOpen: ->
      @set('isSetProgramTypeOpen', true)

    closeSetProgramType: ->
      @set('isSetProgramTypeOpen', false)

    setProgramType: (programTypeIndex) ->
      progTypes = @get('availableProgramTypes')

      @set('programInstance.selectedProgramType',(progTypes.filter (p) -> p.value == programTypeIndex)[0])
      @send('initProgram')
      @send('closeSetProgramType')

    updateDaysOfWeek: ->
      selectedDays = []

      daysOfWeek = @get('programInstance.DaysOfWeek')
      daysOfWeek.forEach (day, index, array) ->
        if day.checked
          selectedDays.push day.value

      @set('programInstance.selectedDaysOfWeek.value', selectedDays)

    setOddEvenOpen: ->
      @set('isSetOddEvenOpen', true)

    closeSetOddEven: ->
      @set('isSetOddEvenOpen', false)

    setOddEven: (oddEvenIndex) ->
      oddEven = @get('OddEven')

      @set('programInstance.selectedOddEvenProgram',(oddEven.filter (od) -> od.value == oddEvenIndex)[0])
      @send('initProgram')
      @send('closeSetOddEven')

    setIntervalOpen: ->
      @set('isSetIntervalOpen', true)

    closeSetInterval: ->
      @set('isSetIntervalOpen', false)

    setInterval: ->
      @set('programInstance.selectedIntervalProgram.interval_start_label', 'Start on ' + @get('DaysOfWeek')[@get('programInstance.selectedIntervalProgram.interval_start')].full)
      @set('programInstance.selectedIntervalProgram.days_interval_label', 'Run Every ' + @get('programInstance.selectedIntervalProgram.days_interval') + ' days')

      @send('initProgram')
      @send('closeSetInterval')

    setStartTimeOpen: (index) ->
      progStartTimes = @get('programInstance.programStartTimes')
      progStartTime = (progStartTimes.filter (st) -> st.id == index)[0]

      @set('programInstance.currentSelectedTimeSlot.id', 0)
      @set('programInstance.currentSelectedStartTime.id', index)

      if progStartTime.start_time != null
        time = formatTime('12H', progStartTime.start_time)
        timeArr = time.split ' '
        availableTimeSlots = @get('availableTimeSlots')
        availableAmPm = @get('availableAmPm')
        timeSlot = (availableTimeSlots.filter (ts) -> ts.value == timeArr[0])[0]
        @set('programInstance.currentSelectedAmPm',  timeArr[1].toLowerCase())
        @set('programInstance.currentSelectedTimeSlot.id', timeSlot.id)


      @set('isSetStartTimeOpen', true)

    closeSetStartTime: ->
      @set('isSetStartTimeOpen', false)

    setStartTime: ->
      startTimeIndex = @get('programInstance.currentSelectedStartTime.id');
      selectTimeSlotId = @get('programInstance.currentSelectedTimeSlot.id')
      availableTimeSlots = @get('availableTimeSlots')
      selectedTimeSlot = (availableTimeSlots.filter (ts) -> ts.id == selectTimeSlotId)[0]
      selectedAmPm = @get('programInstance.currentSelectedAmPm')

      progStartTimes = @get('programInstance.programStartTimes')

      startTime = null
      if selectedTimeSlot.value != 'Off'
        startTime = selectedTimeSlot.value + ' ' + selectedAmPm
        startTime = formatTime('24H', startTime)

      neProgStartTimes = []
      progStartTimes.forEach (st, index, array) ->
        neProgStartTimes.pushObject({ id: st.id, start_time: st.start_time})
        if st.id == startTimeIndex
          neProgStartTimes[index].start_time = startTime

      @set('programInstance.programStartTimes', neProgStartTimes)

      @send('closeSetStartTime')

    toggleDay: (day) ->
      isChecked = !day.checked
      Ember.set(day, "checked", isChecked)
      @send('updateDaysOfWeek')

  programType: Ember.computed 'model.program_type', ->
    @get('model.program_type')

  cssClass: Ember.computed 'model.identifier', ->
    "weathermatic-btn-run-program-#{@get('model.identifier').toLowerCase()}"

  isDayOfWeekProgramTypeSelected: Ember.computed 'programInstance.selectedProgramType', ->
    @get('programInstance.selectedProgramType').value is @get('PROGRAM_TYPE_ENUM').DAYS_OF_WEEK

  isOddEvenProgramTypeSelected: Ember.computed 'programInstance.selectedProgramType', ->
    @get('programInstance.selectedProgramType').value is @get('PROGRAM_TYPE_ENUM').ODD_EVEN

  isIntervalProgramTypeSelected: Ember.computed 'programInstance.selectedProgramType', ->
    @get('programInstance.selectedProgramType').value is @get('PROGRAM_TYPE_ENUM').INTERVAL

`export default SmartlinkControllerProgramDetailController`