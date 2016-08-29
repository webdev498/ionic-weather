import Ember from 'ember';
import SmartlinkSaveMixin from '../../../mixins/smartlink-save';
import MetricFlowMixin from '../../../mixins/metric-flow';

const SmartlinkControllerSettingsEditControllerAdvancedController = Ember.Controller.extend(SmartlinkSaveMixin, MetricFlowMixin, {
  init() {
    this.initNumberOfStarts();
    this.initAvailableSlwDelayHours();
    this.initAvailableRainDelays();
    this.initAvailableZoneToZoneDelay();
    this.initAvailableMasterValveZoneOnDelay();
    this.initAvailableMasterValveZoneOffDelay();
    this.initAvailableMinDeficit();
    this.initNumberOfStarts();
    this.initAvailableDaysOfWeek();
    this.initAvailableWeeksOfMonth();
    this.initAvailableMonths();
    this.initAvailableCommErrorIntervals();
    this.initAvailableMaxConcurrentPrograms();
  },

  initNumberOfStarts() {
    this.set('availableNumberOfStarts', [1, 2, 3, 4, 5, 6, 7, 8]);
  },

  initAvailableSlwDelayHours() {
    var i;
    const opts = [];

    for (i = 0; i <= 99; i++) {
      opts.push({
        label: `${i} hr`,
        value: i,
      });
    }

    this.set('availableSlwDelayHours', opts);
  },

  initAvailableRainDelays() {
    var i;
    const opts = [];
    for (i = 0; i <= 14; i++) {
      opts.push({
        label: `${i} days`,
        value: i,
      });
    }
    this.set('availableRainDelayDays', opts);
  },

  initAvailableZoneToZoneDelay() {
    var i, opts, results;
    opts = [];
    (function() {
      results = [];
      for (i = 0; i <= 30; i++){ results.push(i); }
      return results;
    }).apply(this).forEach(function(n) {
      return opts.push({
        label: n + " min",
        value: n
      });
    });
    [31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45].forEach(function(n) {
      var hours, lbl, minutes;
      minutes = ((n - 30) * 10) + 30;
      hours = Math.floor(minutes / 60);
      minutes = minutes % 60;
      if (minutes < 10) {
        minutes = "0" + minutes;
      }
      lbl = "0" + hours + ":" + minutes;
      return opts.push({
        label: lbl,
        value: n
      });
    });
    return this.set('availableZoneToZoneDelay', opts);
  },

  initAvailableMasterValveZoneOnDelay() {
    var i, results;
    return this.set('availableMasterValveZoneOnDelay', (function() {
      results = [];
      for (i = 0; i <= 60; i++){ results.push(i); }
      return results;
    }).apply(this).map(function(n) {
      return {
        label: n + " sec",
        value: n
      };
    }));
  },

  initAvailableMasterValveZoneOffDelay() {
    var i, results;
    return this.set('availableMasterValveZoneOffDelay', (function() {
      results = [];
      for (i = 0; i <= 180; i++){ results.push(i); }
      return results;
    }).apply(this).map(function(n) {
      var hr, min;
      hr = Math.floor(n / 60);
      min = n % 60;
      if (min < 10) {
        min = "0" + min;
      }
      return {
        label: "0" + hr + ":" + min,
        value: n
      };
    }));
  },

  initAvailableMinDeficit() {
    return this.set('availableMinDeficit', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((function(_this) {
      return function(n) {
        var val;
        val = n * 0.05;
        return {
          label: _this.sizeInLocalUnits(val),
          value: n
        };
      };
    })(this)));
  },

  initAvailableDaysOfWeek() {
    return this.set('availableDaysOfWeek', [
      {
        label: 'Sun',
        value: 0
      }, {
        label: 'Mon',
        value: 1
      }, {
        label: 'Tue',
        value: 2
      }, {
        label: 'Wed',
        value: 3
      }, {
        label: 'Thu',
        value: 4
      }, {
        label: 'Fri',
        value: 5
      }, {
        label: 'Sat',
        value: 6
      }
    ]);
  },

  initAvailableWeeksOfMonth() {
    return this.set('availableWeeksOfMonth', [
      {
        label: '1st wk',
        value: 0
      }, {
        label: '2nd wk',
        value: 1
      }, {
        label: '3rd wk',
        value: 2
      }, {
        label: '4th wk',
        value: 3
      }
    ]);
  },

  initAvailableMonths() {
    return this.set('availableMonths', [
      {
        label: 'Jan',
        value: 0
      }, {
        label: 'Feb',
        value: 1
      }, {
        label: 'Mar',
        value: 2
      }, {
        label: 'Apr',
        value: 3
      }, {
        label: 'May',
        value: 4
      }, {
        label: 'Jun',
        value: 5
      }, {
        label: 'Jul',
        value: 6
      }, {
        label: 'Aug',
        value: 7
      }, {
        label: 'Sep',
        value: 8
      }, {
        label: 'Oct',
        value: 9
      }, {
        label: 'Nov',
        value: 10
      }, {
        label: 'Dec',
        value: 11
      }
    ]);
  },

  initAvailableCommErrorIntervals() {
    return this.set('availableCommErrorIntervals', [
      {
        label: '24 hr',
        value: 24
      }, {
        label: '48 hr',
        value: 48
      }, {
        label: '72 hr',
        value: 72
      }
    ]);
  },

  initAvailableMaxConcurrentPrograms() {
    return this.set('availableMaxConcurrentProgramgs', [1, 2, 3, 4]);
  },

  saveUrl: Ember.computed('model.id', function() {
    return (this.get('baseUrl')) + "/api/v2/controllers/" + (this.get('model.id')) + "/update_advanced_settings";
  }),

  actions: {
    save: function() {
      var saveMessage;
      if (this.get('model').needsTransmit()) {
        saveMessage = null;
      } else {
        saveMessage = 'Successfully saved settings';
      }
      return this.save({
        url: this.get('saveUrl'),
        saveMessage: saveMessage,
        params: {
          auto_set_time: this.get('model.autoSetTime') ? 'on' : null,
          dst_enabled: this.get('model.dstEnabled') ? 'on' : null,
          winterized: this.get('model.winterized') ? 'on' : null,
          control: {
            num_starts:              this.get('model.numStarts'),
            slw_delay:               this.get('model.slwDelay'),
            rain_delay:              this.get('model.rainDelay'),
            interzone_delay:         this.get('model.interzoneDelay'),
            mv_zone_on_delay:        this.get('model.mvZoneOnDelay'),
            mv_zone_off_delay:       this.get('model.mvZoneOffDelay'),
            mv2_zone_on_delay:       this.get('model.mv2ZoneOnDelay'),
            mv2_zone_off_delay:      this.get('model.mv2ZoneOffDelay'),
            min_deficit:             this.get('model.minDeficit'),
            dst_start_day:           this.get('model.dstStartDay'),
            dst_start_week:          this.get('model.dstStartWeek'),
            dst_start_month:         this.get('model.dstStartMonth'),
            dst_stop_day:            this.get('model.dstStopDay'),
            dst_stop_week:           this.get('model.dstStopWeek'),
            dst_stop_month:          this.get('model.dstStopMonth'),
            comm_error_interval:     this.get('model.commErrorInterval'),
            max_concurrent_programs: this.get('model.maxConcurrentPrograms')
          }
        }
      }).then((function(_this) {
        return function() {
          if (_this.get('model').needsTransmit()) {
            _this.set('model.hasUnsentChanges', true);
          }
          return _this.get('model').clearChangedAttributes();
        };
      })(this));
    }
  }
});

export default SmartlinkControllerSettingsEditControllerAdvancedController;
