import Ember from 'ember';
import SmartlinkSaveMixin from '../../../mixins/smartlink-save';
import SmartlinkController from '../../../models/smartlink-controller';

const { computed } = Ember;

const {
  RUN_STATUS_OFF,
  RUN_STATUS_RUN,
  RUN_STATUS_REMOTE_OFF,
  RUN_STATUS_RAIN_DELAY,
} = SmartlinkController;

const SmartlinkControllerSettingsEditControllerBasicController = Ember.Controller.extend(SmartlinkSaveMixin, {
  init: function() {
    this.initAvailableHours();
    this.initAvailableMinutes();
    this.initAvailalbleAmPm();
    this.initAvailableTimezones();
    this.initAvailableWateringModes();
    return this.initAvailableRainFreeze();
  },
  saveUrl: Ember.computed('model.id', function() {
    return (this.get('baseUrl')) + "/api/v2/controllers/" + (this.get('model.id')) + "/update_basic_settings";
  }),
  deviceTimeHours: Ember.computed('model.currentDeviceTime', function() {
    return moment(this.get('model.deviceTime')).utc().format('hh');
  }),
  deviceTimeMinutes: Ember.computed('model.currentDeviceTime', function() {
    return moment(this.get('model.deviceTime')).utc().format('mm');
  }),
  deviceTimeAmPm: Ember.computed('model.currentDeviceTime', function() {
    return moment(this.get('model.deviceTime')).utc().format('a');
  }),
  deviceTimeDate: Ember.computed('model.currentDeviceTime', function() {
    return moment(this.get('model.deviceTime')).utc().format('YYYY-MM-DD');
  }),
  actions: {
    save: function() {
      var date;
      date = moment(this.get('deviceTimeDate')).utc();
      return this.save({
        url: this.get('saveUrl'),
        params: {
          'date-month': date.format('M'),
          'date-day': date.format('D'),
          'date-year': date.format('Y'),
          'date-hour': this.get('deviceTimeHours'),
          'date-minute': this.get('deviceTimeMinutes'),
          'date-ampm': this.get('deviceTimeAmPm'),
          'tz': this.get('model.timezone'),
          'control': {
            run_status: this.get('model.runStatus'),
            mode: this.get('model.wateringMode'),
            sensor_mode: this.get('model.rainFreezeSensorMode')
          }
        }
      }).then((function(_this) {
        return function() {
          return _this.set('model.hasUnsentChanges', true);
        };
      })(this));
    }
  },
  initAvailableHours: function() {
    var opts;
    opts = [
      {
        label: '',
        value: null
      }
    ];
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].forEach(function(n) {
      n = "" + n;
      if (n < 10) {
        n = "0" + n;
      }
      return opts.push({
        label: n,
        value: n
      });
    });
    return this.set('availableHours', opts);
  },
  initAvailableMinutes: function() {
    var i, opts, results;
    opts = [
      {
        label: 'MM',
        value: null
      }
    ];
    (function() {
      results = [];
      for (i = 1; i <= 59; i++){ results.push(i); }
      return results;
    }).apply(this).forEach(function(n) {
      n = "" + n;
      if (n < 10) {
        n = "0" + n;
      }
      return opts.push({
        label: n,
        value: n
      });
    });
    return this.set('availableMinutes', opts);
  },
  initAvailalbleAmPm: function() {
    return this.set('availableAmPm', [
      {
        label: 'am',
        value: 'am'
      }, {
        label: 'pm',
        value: 'pm'
      }
    ]);
  },
  initAvailableWateringModes: function() {
    return this.set('availableWateringModes', [
      {
        label: 'Basic (Standard)',
        value: 0
      }, {
        label: 'Smart (Auto-Adjust)',
        value: 1
      }
    ]);
  },
  initAvailableRainFreeze: function() {
    return this.set('availableRainFreeze', [
      {
        label: 'Active',
        value: 0
      }, {
        label: 'Bypass',
        value: 1
      }
    ]);
  },
  initAvailableTimezones: function() {
    var timezones;
    timezones = ["Eastern Time (US & Canada)", "Central Time (US & Canada)", "Mountain Time (US & Canada)", "Pacific Time (US & Canada)", "American Samoa", "International Date Line West", "Midway Island", "Hawaii", "Alaska", "Tijuana", "Arizona", "Chihuahua", "Mazatlan", "Central America", "Guadalajara", "Mexico City", "Monterrey", "Saskatchewan", "Bogota", "Indiana (East)", "Lima", "Quito", "Atlantic Time (Canada)", "Caracas", "Georgetown", "La Paz", "Santiago", "Newfoundland", "Brasilia", "Buenos Aires", "Greenland", "Montevideo", "Mid-Atlantic", "Azores", "Cape Verde Is.", "Casablanca", "Dublin", "Edinburgh", "Lisbon", "London", "Monrovia", "UTC", "Amsterdam", "Belgrade", "Berlin", "Bern", "Bratislava", "Brussels", "Budapest", "Copenhagen", "Ljubljana", "Madrid", "Paris", "Prague", "Rome", "Sarajevo", "Skopje", "Stockholm", "Vienna", "Warsaw", "West Central Africa", "Zagreb", "Athens", "Bucharest", "Cairo", "Harare", "Helsinki", "Istanbul", "Jerusalem", "Kaliningrad", "Kyiv", "Pretoria", "Riga", "Sofia", "Tallinn", "Vilnius", "Baghdad", "Kuwait", "Minsk", "Moscow", "Nairobi", "Riyadh", "St. Petersburg", "Volgograd", "Tehran", "Abu Dhabi", "Baku", "Muscat", "Samara", "Tbilisi", "Yerevan", "Kabul", "Ekaterinburg", "Islamabad", "Karachi", "Tashkent", "Chennai", "Kolkata", "Mumbai", "New Delhi", "Sri Jayawardenepura", "Kathmandu", "Almaty", "Astana", "Dhaka", "Novosibirsk", "Urumqi", "Rangoon", "Bangkok", "Hanoi", "Jakarta", "Krasnoyarsk", "Beijing", "Chongqing", "Hong Kong", "Irkutsk", "Kuala Lumpur", "Perth", "Singapore", "Taipei", "Ulaanbaatar", "Osaka", "Sapporo", "Seoul", "Tokyo", "Yakutsk", "Adelaide", "Darwin", "Brisbane", "Canberra", "Guam", "Hobart", "Melbourne", "Port Moresby", "Sydney", "Vladivostok", "Magadan", "New Caledonia", "Solomon Is.", "Srednekolymsk", "Auckland", "Fiji", "Kamchatka", "Marshall Is.", "Wellington", "Chatham Is.", "Nuku'alofa", "Samoa", "Tokelau Is."];
    return this.set('availableTimezones', timezones.map(function(tz) {
      return {
        label: tz.replace("&", "&amp;"),
        value: tz
      };
    }));
  },

  availableRunStatuses: computed('model.runStatus', function() {
    const statuses = [];
    const status = parseInt(this.get('model.runStatus'))

    if (this.get('model.isRunStatusOff')) {
      return [{
        label: 'System Off',
        value: RUN_STATUS_OFF,
        disabled: true,
      }];
    }

    if (status === RUN_STATUS_RUN || status === RUN_STATUS_REMOTE_OFF) {
      return [{
        label: 'Run',
        value: RUN_STATUS_RUN,
      }, {
        label: 'Remote Off',
        value: RUN_STATUS_REMOTE_OFF,
      }];
    }

    return [{
      label: 'Run',
      value: RUN_STATUS_RUN,
    }, {
      label: 'Remote Off',
      value: RUN_STATUS_REMOTE_OFF,
    }, {
      label: 'Rain Delay',
      value: RUN_STATUS_RAIN_DELAY,
    }];
  }),
});

export default SmartlinkControllerSettingsEditControllerBasicController;
