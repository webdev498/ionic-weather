import Ember from 'ember';
import MetricFlowMixin from '../../../mixins/metric-flow';
import SmartlinkSaveMixin from '../../../mixins/smartlink-save';

const { Controller, computed } = Ember;

const SmartlinkControllerSettingsEditAutoAdjustController = Controller.extend(MetricFlowMixin, SmartlinkSaveMixin, {

  init() {
    this.initAvailableSprinklerTypesImperial();
    this.initAvailableSprinklerTypesMetric();
    this.initAvailablePlantTypes();
    this.initAvailableSoilTypes();
    this.initSlopeValues();
    this.initMoreLessValues();
  },

  initAvailableSprinklerTypesImperial() {
    var i;
    const opts = [
      { label: "Standard (non-ET)", value: 0 },
      { label: "Off",               value: 1 },
      { label: "Spray (1.5\")",     value: 2 },
      { label: "Rotor (0.5\")",     value: 3 },
      { label: "Drip (1.1\")",      value: 4 },
      { label: "Bubbler (2.3\")",   value: 5 },
    ];

    for (i=20; i < 200; i++) {
      opts.push({
        label: `${(i/100).toFixed(2)}"`,
        value: i,
      });
    }

    for (i=20; i < 30; i++) {
      opts.push({
        label: `${(i/10).toFixed(2)}`,
        value: i*10,
      });
    }

    this.set('availableSprinklerTypesImperial', opts);
  },

  initAvailableSprinklerTypesMetric() {
    var i;
    const opts = [
      { label: "Standard (non-ET)", value: 0 },
      { label: "Off",               value: 1 },
      { label: "Spray (38.1 mm)",   value: 2 },
      { label: "Rotor (12.7 mm)",   value: 3 },
      { label: "Drip (27.9 mm)",    value: 4 },
      { label: "Bubbler (58.4 mm)", value: 5 }
    ];

    for (i=20; i < 200; i++) {
      opts.push({
        label: `${((i/100)*25.4).toFixed(2)} mm`,
        value: i,
      });
    }

    for (i=20; i < 30; i++) {
      opts.push({
        label: `${((i/10)*25.4).toFixed(2)} mm`,
        value: i*10,
      });
    }

    return this.set('availableSprinklerTypesMetric', opts);
  },

  initAvailablePlantTypes() {
    var i, n;
    const opts = [
      {
        label: "CTURF",
        value: 0,
      }, {
        label: "WTURF",
        value: 1,
      }, {
        label: "Shrubs",
        value: 2,
      }, {
        label: "Annuals",
        value: 3,
      }, {
        label: "Trees",
        value: 4,
      }, {
        label: "Native",
        value: 5,
      }
    ];

    for (i=10; i < 100; i++) {
      opts.push({
        label: `${i}%`,
        value: i,
      });
    }

    for (i=10; i <= 30; i++) {
      n = i * 10;
      opts.push({
        label: `${n}%`,
        value: n,
      });
    }

    return this.set('availablePlantTypes', opts);
  },

  initAvailableSoilTypes() {
    this.set('availableSoilTypes', [
      {
        label: "Sand",
        value: 0
      }, {
        label: "Loam",
        value: 1
      }, {
        label: "Clay",
        value: 2
      }
    ]);
  },

  initSlopeValues() {
    var i;
    const opts = [];
    for (i=0; i <= 25; i++) {
      opts.push({
        label: `${i}º`,
        value: i,
      })
    }
    this.set('slopeValues', opts);
  },

  initMoreLessValues() {
    var i;
    const opts = [];
    for (i=25; i >= -50; i--) {
      opts.push({
        label: `${i}%`,
        value: i,
      });
    }
    return this.set('moreLessValues', opts);
  },

  saveUrl: computed('model.smartlinkController.id', function() {
    var controllerId, zoneId;
    controllerId = this.get('model.smartlinkController.id');
    zoneId = this.get('model.id');
    return (this.get('baseUrl')) + "/api/v2/controllers/" + controllerId + "/zones/" + zoneId;
  }),

  timeoutThresholdMillis: 20000,

  actions: {
    save() {
      return this.save({
        url: this.get('saveUrl'),
        params: {
          zone: {
            sprinkler_type: this.get('model.sprinklerType'),
            plant_type:     this.get('model.plantType'),
            soil_type:      this.get('model.soilType'),
            soil_slope:     this.get('model.soilSlope'),
            adjustment:     this.get('model.adjustment')
          }
        }
      }).then( () => {
        return this.set('model.smartlinkController.hasUnsentChanges', true);
      });
    }
  }
});

export default SmartlinkControllerSettingsEditAutoAdjustController;
