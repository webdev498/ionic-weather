import Ember from 'ember';
import leftPad from '../../../util/strings/left-pad';
import SmartlinkSaveMixin from '../../../mixins/smartlink-save';
import formatTime from '../../../util/time-formatter';
import config from '../../../config/environment';

const { Logger: { debug }, Controller, computed, get, set } = Ember;

const SmartlinkControllerProgramDetailController = Controller.extend(SmartlinkSaveMixin, {

  intervalStartAsInt: computed('programInstance.selectedIntervalProgram.interval_start', function() {
    return parseInt(this.get('programInstance.selectedIntervalProgram.interval_start'));
  }),

  isDayOmitted: function(dayNum) {
    var omitted;
    omitted = false;
    this.get('model.smartlinkController.omissionDays').forEach(function(omissionDay) {
      if (omissionDay.get('day') === dayNum) {
        omitted = true;
      }
    });
    this.get('model.smartlinkController.omissionDates').forEach(function(omissionDate) {
      const date = moment().startOf('week').add(dayNum, 'days').format('YYYY-MM-DD');
      if (omissionDate.get('date') === date) {
        omitted = true;
      }
    });
    return omitted;
  },

  init: function() {
    var PROGRAM_TYPE_ENUM, amPM, daysOfWeek, oddEven, programInstance, programTypes, timeSlots;
    PROGRAM_TYPE_ENUM = {
      DAYS_OF_WEEK: 1,
      ODD_EVEN: 2,
      INTERVAL: 3
    };
    this.set('PROGRAM_TYPE_ENUM', PROGRAM_TYPE_ENUM);
    programTypes = [
      {
        label: 'Day of Week',
        value: this.get('PROGRAM_TYPE_ENUM').DAYS_OF_WEEK
      }, {
        label: 'Odd/Even',
        value: this.get('PROGRAM_TYPE_ENUM').ODD_EVEN
      }, {
        label: 'Interval',
        value: this.get('PROGRAM_TYPE_ENUM').INTERVAL
      }
    ];
    daysOfWeek = [
      {
        label: 'Sun',
        full: 'Sunday',
        value: 0,
        isOdd: true,
        checked: false,
        isException: false
      }, {
        label: 'Mon',
        full: 'Monday',
        value: 1,
        isOdd: true,
        checked: false,
        isException: false
      }, {
        label: 'Tue',
        full: 'Tuesday',
        value: 2,
        isOdd: true,
        checked: false,
        isException: false
      }, {
        label: 'Wed',
        full: 'Wednesday',
        value: 3,
        isOdd: true,
        checked: false,
        isException: false
      }, {
        label: 'Thu',
        full: 'Thursday',
        value: 4,
        isOdd: true,
        checked: false,
        isException: false
      }, {
        label: 'Fri',
        full: 'Friday',
        value: 5,
        isOdd: true,
        checked: false,
        isException: false
      }, {
        label: 'Sat',
        full: 'Saturday',
        value: 6,
        isOdd: true,
        checked: false,
        isException: false
      }
    ];
    this.set('DaysOfWeek', daysOfWeek);
    oddEven = [
      {
        label: 'Run on Odd Days',
        value: 1
      }, {
        label: 'Run on Even Days',
        value: 0
      }
    ];
    this.set('OddEven', oddEven);
    timeSlots = [
      {
        id: 0,
        value: 'Off'
      }, {
        id: 1,
        value: '12:00'
      }, {
        id: 2,
        value: '12:10'
      }, {
        id: 3,
        value: '12:20'
      }, {
        id: 4,
        value: '12:30'
      }, {
        id: 5,
        value: '12:40'
      }, {
        id: 6,
        value: '12:50'
      }, {
        id: 7,
        value: '01:00'
      }, {
        id: 8,
        value: '01:10'
      }, {
        id: 9,
        value: '01:20'
      }, {
        id: 10,
        value: '01:30'
      }, {
        id: 11,
        value: '01:40'
      }, {
        id: 12,
        value: '01:50'
      }, {
        id: 13,
        value: '02:00'
      }, {
        id: 14,
        value: '02:10'
      }, {
        id: 15,
        value: '02:20'
      }, {
        id: 16,
        value: '02:30'
      }, {
        id: 17,
        value: '02:40'
      }, {
        id: 18,
        value: '02:50'
      }, {
        id: 19,
        value: '03:00'
      }, {
        id: 20,
        value: '03:10'
      }, {
        id: 21,
        value: '03:20'
      }, {
        id: 22,
        value: '03:30'
      }, {
        id: 23,
        value: '03:40'
      }, {
        id: 24,
        value: '03:50'
      }, {
        id: 25,
        value: '04:00'
      }, {
        id: 26,
        value: '04:10'
      }, {
        id: 27,
        value: '04:20'
      }, {
        id: 28,
        value: '04:30'
      }, {
        id: 29,
        value: '04:40'
      }, {
        id: 30,
        value: '04:50'
      }, {
        id: 31,
        value: '05:00'
      }, {
        id: 32,
        value: '05:10'
      }, {
        id: 33,
        value: '05:20'
      }, {
        id: 34,
        value: '05:30'
      }, {
        id: 35,
        value: '05:40'
      }, {
        id: 36,
        value: '05:50'
      }, {
        id: 37,
        value: '06:00'
      }, {
        id: 38,
        value: '06:10'
      }, {
        id: 39,
        value: '06:20'
      }, {
        id: 40,
        value: '06:30'
      }, {
        id: 41,
        value: '06:40'
      }, {
        id: 42,
        value: '06:50'
      }, {
        id: 43,
        value: '07:00'
      }, {
        id: 44,
        value: '07:10'
      }, {
        id: 45,
        value: '07:20'
      }, {
        id: 46,
        value: '07:30'
      }, {
        id: 47,
        value: '07:40'
      }, {
        id: 48,
        value: '07:50'
      }, {
        id: 49,
        value: '08:00'
      }, {
        id: 50,
        value: '08:10'
      }, {
        id: 51,
        value: '08:20'
      }, {
        id: 52,
        value: '08:30'
      }, {
        id: 53,
        value: '08:40'
      }, {
        id: 54,
        value: '08:50'
      }, {
        id: 55,
        value: '09:00'
      }, {
        id: 56,
        value: '09:10'
      }, {
        id: 57,
        value: '09:20'
      }, {
        id: 58,
        value: '09:30'
      }, {
        id: 59,
        value: '09:40'
      }, {
        id: 60,
        value: '09:50'
      }, {
        id: 61,
        value: '10:00'
      }, {
        id: 62,
        value: '10:10'
      }, {
        id: 63,
        value: '10:20'
      }, {
        id: 64,
        value: '10:30'
      }, {
        id: 65,
        value: '10:40'
      }, {
        id: 66,
        value: '10:50'
      }, {
        id: 67,
        value: '11:00'
      }, {
        id: 68,
        value: '11:10'
      }, {
        id: 69,
        value: '11:20'
      }, {
        id: 70,
        value: '11:30'
      }, {
        id: 71,
        value: '11:40'
      }, {
        id: 72,
        value: '11:50'
      }
    ];
    this.set('availableTimeSlots', timeSlots);
    amPM = ['am', 'pm'];
    this.set('availableAmPm', amPM);
    programInstance = {
      selectedProgramType: {},
      DaysOfWeek: [],
      selectedDaysOfWeek: {
        value: [],
        label: 'Select Days of Week'
      },
      selectedOddEvenProgram: {},
      selectedIntervalProgram: {},
      programStartTimes: [],
      currentSelectedStartTime: {
        id: 0
      },
      currentSelectedAmPm: 'am',
      currentSelectedTimeSlot: {
        id: 0
      }
    };
    this.set('availableProgramTypes', programTypes);
    this.set('programInstance', programInstance);
    return {
      isSetProgramTypeOpen: false,
      isSetOddEvenOpen: false,
      isSetIntervalOpen: false,
      isSetStartTimeOpen: false
    };
  },

  setDefaults: function() {
    var daysInterval, i, intervalProgram, oddEven, progTypes, results, self, type;
    self = this;
    this.set('programInstance.programStartTimes', this.get('model.programStartTimes'));
    daysInterval = (function() {
      results = [];
      for (i = 1; i <= 30; i++){ results.push(i); }
      return results;
    }).apply(this);
    this.set('DaysInterval', daysInterval);
    type = this.get('model.program_type');
    if (type != null) {
      progTypes = this.get('availableProgramTypes');
      this.set('programInstance.selectedProgramType', (progTypes.filter(function(p) {
        return p.value === type;
      }))[0]);
    }
    oddEven = this.get('OddEven');
    this.set('programInstance.selectedOddEvenProgram', oddEven.find(function(od) {
      return od.value === 1;
    }));
    intervalProgram = {
      interval_start: 0,
      interval_start_label: 'Start on ' + this.get('DaysOfWeek')[0].full,
      days_interval: 1,
      days_interval_label: 'Run Every 1 day'
    };
    this.set('programInstance.selectedIntervalProgram', intervalProgram);
    switch (this.get('programInstance.selectedProgramType').value) {
      case this.get('PROGRAM_TYPE_ENUM').ODD_EVEN:
        this.set('programInstance.selectedOddEvenProgram', oddEven.find(function(od) {
          return od.value === (self.get('model.oddeven') % 2);
        }));
        break;
      case this.get('PROGRAM_TYPE_ENUM').INTERVAL:
        intervalProgram = {
          interval_start: this.get('model.interval_start'),
          interval_start_label: 'Start on ' + this.get('DaysOfWeek')[this.get('model.interval_start')].full,
          days_interval: this.get('model.days_interval'),
          days_interval_label: 'Run Every ' + this.get('model.days_interval') + ' days'
        };
        this.set('programInstance.selectedIntervalProgram', intervalProgram);
    }
    return this.send('initProgram');
  },

  programType: computed('model.program_type', function() {
    return this.get('model.program_type');
  }),

  cssClass: computed('model.identifier', function() {
    return "weathermatic-btn-run-program-" + (this.get('model.identifier').toLowerCase());
  }),

  isDayOfWeekProgramTypeSelected: computed('programInstance.selectedProgramType', function() {
    return this.get('programInstance.selectedProgramType').value === this.get('PROGRAM_TYPE_ENUM').DAYS_OF_WEEK;
  }),

  isOddEvenProgramTypeSelected: computed('programInstance.selectedProgramType', function() {
    return this.get('programInstance.selectedProgramType').value === this.get('PROGRAM_TYPE_ENUM').ODD_EVEN;
  }),

  isIntervalProgramTypeSelected: computed('programInstance.selectedProgramType', function() {
    return this.get('programInstance.selectedProgramType').value === this.get('PROGRAM_TYPE_ENUM').INTERVAL;
  }),

  saveUrl: computed('model.id', function() {
    return config.apiUrl + "/api/v2/programs/" + (this.get('model.id'));
  }),

  daysOfWeek: function() {
    var daysInterval, dows, type, val;
    type = this.get('programInstance.selectedProgramType.value');
    if (type === this.get('PROGRAM_TYPE_ENUM.INTERVAL')) {
      daysInterval = parseInt(this.get('programInstance.selectedIntervalProgram.days_interval'));
      val = parseInt(this.get('programInstance.selectedIntervalProgram.interval_start'));
      dows = [];
      while (val <= 6) {
        dows.push(val);
        val = val + daysInterval;
      }
      return dows.join(',');
    } else {
      return this.get('programInstance.selectedDaysOfWeek.value').join(',');
    }
  },

  // SM-125 make sure we're sending the right days_of_week param for odd/even
  getDaysOfWeekSaveValue: function() {
    const type = parseInt(this.get('programInstance.selectedProgramType.value'));
    const orig = this.daysOfWeek();
    const oddOrEvenSelection = this.get('programInstance.selectedOddEvenProgram.value');
    // if it's an odd number, we're doing odd
    const isOdd = (oddOrEvenSelection % 2 !== 0);

    if (type === this.get('PROGRAM_TYPE_ENUM').ODD_EVEN) {

      if (isOdd) {
        // odd days in zero-indexed format
        return '0,2,4,6';
      } else {
        // even days in zero-indexed format
        return '1,3,5,7';
      }
    } else {
      return orig;
    }
  },

  getOddEvenSaveValue: function () {
    const orig = parseInt(this.get('programInstance.selectedOddEvenProgram.value'));
    if (orig === 1) {
      return 3;
    }
    if (orig === 0) {
      return 2;
    }
    return orig;
  },

  actions: {
    initProgram: function() {
      var curr, currentDaysOfWeek, currentDaysOfWeekStr, date, day, daysOfWeek, days_intreval, first, firstDate, intervalDayIndex, interval_start, last, lastDate, programDaysOfWeek, selectedDaysOfWeek, self, todayDate;
      debug("SmartlinkControllerProgramDetailController initProgram action called");
      self = this;
      programDaysOfWeek = [];
      selectedDaysOfWeek = [];
      daysOfWeek = this.get('DaysOfWeek').slice(0);
      todayDate = new Date;
      curr = new Date;
      first = curr.getDate() - curr.getDay();
      last = first + 6;
      firstDate = new Date(curr.setDate(first));
      lastDate = new Date(curr.setDate(last));
      date = firstDate.getDate();
      day = firstDate.getDay();
      while (firstDate <= lastDate) {
        if (date === 31 || (firstDate.getMonth() === 1 && date === 29)) {
          daysOfWeek[day].isOdd = false;
          daysOfWeek[day].isException = true;
        }
        if (date % 2 === 0) {
          daysOfWeek[day].isOdd = false;
        }
        firstDate.setDate(firstDate.getDate() + 1);
        date = firstDate.getDate();
        day = firstDate.getDay();
      }
      self.set('programInstance.DaysOfWeek', daysOfWeek);
      switch (self.get('programInstance.selectedProgramType').value) {
        case self.get('PROGRAM_TYPE_ENUM').DAYS_OF_WEEK:
          currentDaysOfWeekStr = self.get('model.days_of_week');
          currentDaysOfWeek = currentDaysOfWeekStr.split(",");
          daysOfWeek.forEach(function(day, index, array) {
            programDaysOfWeek.pushObject({
              label: day.label,
              value: day.value,
              checked: day.checked,
              isOmitted: self.isDayOmitted(day.value)
            });
            return currentDaysOfWeek.forEach(function(value) {
              if (('' + day.value) === value) {
                programDaysOfWeek[index].checked = true;
                return selectedDaysOfWeek.push(value);
              }
            });
          });
          self.set('programInstance.selectedDaysOfWeek.value', selectedDaysOfWeek);
          break;
        case self.get('PROGRAM_TYPE_ENUM').ODD_EVEN:
          daysOfWeek.forEach(function(day, index, array) {
            programDaysOfWeek.pushObject({
              label: day.label,
              value: day.value,
              checked: false,
              isOmitted: self.isDayOmitted(day.value)
            });
            if (self.get('programInstance.selectedOddEvenProgram').value === 1) {
              if (day.isOdd && !day.isException) {
                return programDaysOfWeek[index].checked = true;
              }
            } else {
              if (!day.isOdd && !day.isException) {
                return programDaysOfWeek[index].checked = true;
              }
            }
          });
          break;
        default:
          interval_start = parseInt(self.get('programInstance.selectedIntervalProgram').interval_start);
          days_intreval = parseInt(self.get('programInstance.selectedIntervalProgram').days_interval);
          intervalDayIndex = interval_start;
          daysOfWeek.forEach(function(day, index, array) {
            var dayIndex;
            programDaysOfWeek.pushObject({
              label: day.label,
              value: day.value,
              checked: false,
              isOmitted: self.isDayOmitted(day.value)
            });
            dayIndex = day.value;
            if (intervalDayIndex === dayIndex) {
              programDaysOfWeek[index].checked = true;
              intervalDayIndex = intervalDayIndex + days_intreval;
            }
            if (intervalDayIndex >= 7) {
              return intervalDayIndex = intervalDayIndex % 7;
            }
          });
      }
      return self.set('programInstance.DaysOfWeek', programDaysOfWeek);
    },

    save: function() {
      var self;
      self = this;
      return this.save({
        url: this.get('saveUrl'),
        params: {
          id: this.get('model.id'),
          program: {
            description:         this.get('model.description') ? this.get('model.description') : '',
            program_type:        this.get('programInstance.selectedProgramType.value'),
            days_of_week:        this.getDaysOfWeekSaveValue(),
            oddeven:             this.getOddEvenSaveValue(),
            interval_start:      this.get('programInstance.selectedIntervalProgram.interval_start'),
            days_interval:       this.get('programInstance.selectedIntervalProgram.days_interval'),
            program_start_times: this.get('programInstance.programStartTimes').map(function(st, index, array) {
              var startTimeModel;
              startTimeModel = self.get('model.programStartTimes').findBy('id', get(st, 'id'));
              return {
                number: startTimeModel.get('number'),
                start_time: get(st, 'start_time')
              };
            })
          }
        }
      }).then( () => {
        this.get('model').reload();
        this.set('model.smartlinkController.hasUnsentChanges', true);
      });
    },

    setProgramTypeOpen: function() {
      return this.set('isSetProgramTypeOpen', true);
    },

    closeSetProgramType: function() {
      return this.set('isSetProgramTypeOpen', false);
    },

    setProgramType: function(programTypeIndex) {
      var progTypes;
      progTypes = this.get('availableProgramTypes');
      this.set('programInstance.selectedProgramType', (progTypes.filter(function(p) {
        return p.value === programTypeIndex;
      }))[0]);
      this.send('initProgram');
      return this.send('closeSetProgramType');
    },

    updateDaysOfWeek: function() {
      var daysOfWeek, selectedDays;
      selectedDays = [];
      daysOfWeek = this.get('programInstance.DaysOfWeek');
      daysOfWeek.forEach(function(day, index, array) {
        if (day.checked) {
          return selectedDays.push(day.value);
        }
      });
      return this.set('programInstance.selectedDaysOfWeek.value', selectedDays);
    },

    setOddEvenOpen: function() {
      return this.set('isSetOddEvenOpen', true);
    },

    closeSetOddEven: function() {
      return this.set('isSetOddEvenOpen', false);
    },

    setOddEven: function(oddEvenIndex) {
      var oddEven;
      oddEven = this.get('OddEven');
      this.set('programInstance.selectedOddEvenProgram', (oddEven.filter(function(od) {
        return od.value === oddEvenIndex;
      }))[0]);
      this.send('initProgram');
      return this.send('closeSetOddEven');
    },

    setIntervalOpen: function() {
      this.set('isSetIntervalOpen', true);
      return false;
    },

    closeSetInterval: function() {
      return this.set('isSetIntervalOpen', false);
    },

    setInterval: function() {
      this.set('programInstance.selectedIntervalProgram.interval_start_label', 'Start on ' + this.get('DaysOfWeek')[this.get('programInstance.selectedIntervalProgram.interval_start')].full);
      this.set('programInstance.selectedIntervalProgram.days_interval_label', 'Run Every ' + this.get('programInstance.selectedIntervalProgram.days_interval') + ' days');
      this.send('initProgram');
      return this.send('closeSetInterval');
    },

    setStartTimeOpen: function(id) {
      var availableAmPm, availableTimeSlots, progStartTime, progStartTimes, t, time, timeArr, timeSlot;
      progStartTimes = this.get('programInstance.programStartTimes');
      progStartTime = (progStartTimes.filter(function(st) {
        return st.id === id;
      }))[0];
      this.set('programInstance.currentSelectedTimeSlot.id', 0);
      this.set('programInstance.currentSelectedStartTime.id', id);
      if (get(progStartTime, 'start_time')) {
        t = get(progStartTime, 'start_time') || '';
        time = formatTime(t, {
          format: 'hh:mm a'
        });
        timeArr = time.split(' ');
        availableTimeSlots = this.get('availableTimeSlots');
        availableAmPm = this.get('availableAmPm');
        timeSlot = (availableTimeSlots.filter(function(ts) {
          return ts.value === timeArr[0];
        }))[0];
        this.set('programInstance.currentSelectedAmPm', timeArr[1].toLowerCase());
        this.set('programInstance.currentSelectedTimeSlot.id', timeSlot.id);
      }
      return this.set('isSetStartTimeOpen', true);
    },

    closeSetStartTime: function() {
      return this.set('isSetStartTimeOpen', false);
    },

    setStartTime: function() {
      var availableTimeSlots, selectTimeSlotId, selectedAmPm, selectedTimeSlot, startTimeId, time12hr, time24hr, troyStartTime;
      startTimeId = this.get('programInstance.currentSelectedStartTime.id');
      selectTimeSlotId = this.get('programInstance.currentSelectedTimeSlot.id');
      availableTimeSlots = this.get('availableTimeSlots');
      selectedTimeSlot = availableTimeSlots.find(function(ts) {
        return parseInt(ts.id) === parseInt(selectTimeSlotId);
      });
      selectedAmPm = this.get('programInstance.currentSelectedAmPm');
      troyStartTime = this.get('programInstance.programStartTimes').find(function(pst) {
        return get(pst, 'id') === startTimeId;
      });
      if (selectedTimeSlot.value === 'Off') {
        troyStartTime.set('start_time', null);
      } else {
        time12hr = selectedTimeSlot.value + " " + selectedAmPm;
        time24hr = moment(time12hr, ["hh:mm a"]).format("HH:mm");
        troyStartTime.set('start_time', time24hr);
      }
      return this.send('closeSetStartTime');
    },

    toggleDay: function(day) {
      var isChecked;
      isChecked = !day.checked;
      set(day, "checked", isChecked);
      return this.send('updateDaysOfWeek');
    }
  }

});

export default SmartlinkControllerProgramDetailController;
