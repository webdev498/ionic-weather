import Ember from 'ember';
import MetricFlowMixin from '../../../mixins/metric-flow';
import SmartlinkSaveMixin from '../../../mixins/smartlink-save';
import Zone from '../../../models/zone';

const { Controller, computed, observer } = Ember;

const SmartlinkControllerSettingsEditFlowController = Controller.extend(MetricFlowMixin, SmartlinkSaveMixin, {

  setupDefaults(model) {
    this.initAvailableValveSizes(model);
  },

  initAvailableValveSizes(model) {
    const sizes = [];
    [0.75, 1.0, 1.25, 1.5, 2.0, 2.5, 3.0].forEach( (size) => {
      sizes.push({
        label: this.sizeInLocalUnits(size),
        value: size,
      });
    });
    if (model.get('smartlinkController.isVirtualFlow')) {
      sizes.unshift({
        label: 'Not Set',
        value: 0.0,
      });
    }
    return this.set('availableValveSizes', sizes);
  },

  availableFlowValues: computed('isMetricEnabled', function() {
    var i, n;
    const opts = [];
    for (i = 1; i < 100; i++) {
      opts.push({
        label: this.flowInLocalUnits(i),
        value: i,
      });
    }
    for (i = 10; i <= 70; i++) {
      n = i * 10;
      if ((n * parseInt(this.get('model.ppg')) || 0) > Zone.HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER) {
        break;
      }
      opts.push({
        label: this.flowInLocalUnits(n),
        value: n,
      });
    }
    return opts;
  }),

  availableLowFlowValues: computed('availableFlowValues', function() {
    return [
      {
        label: 'Off',
        value: 0
      }
    ].concat(this.get('availableFlowValues'));
  }),

  availableHighFlowValues: computed('availableFlowValues', function() {
    return [
      {
        label: 'Off',
        value: Zone.HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER
      }
    ].concat(this.get('availableFlowValues'));
  }),

  saveUrl: computed('model.smartlinkController.id', function() {
    const controllerId = this.get('model.smartlinkController.id');
    const zoneId = this.get('model.id');
    return (this.get('baseUrl')) + "/api/v2/controllers/" + controllerId + "/zones/" + zoneId;
  }),

  timeoutThresholdMillis: 20000,

  gpmInLocalUnits: computed('model.gpm', 'isMetricEnabled', function() {
    return this.flowValueInLocalUnits(this.get('model.gpm'));
  }),

  gpmGallons: computed('gpmInLocalUnits', 'isMetricEnabled', function() {
    const value = this.get('gpmInLocalUnits');
    if (this.get('isMetricEnabled')) {
      return this.lpmToGpm(value);
    } else {
      return value;
    }
  }),

  valveSizeDidChange: observer('model.valveSize', function() {
    var gpm, valveSize;
    if (this.get('model.smartlinkController.isRealtimeFlow')) {
      return;
    }
    if (!this.get('__pageLoaded')) {
      return;
    }
    valveSize = this.get('model.valveSize');
    gpm = {
      0: 0,
      0.75: 10,
      1.0: 16,
      1.25: 26,
      1.5: 35,
      2.0: 35,
      2.5: 80,
      3.0: 120
    }[valveSize];
    if (gpm != null) {
      this.set('model.gpm', gpm);
    }
  }),

  flowLimitPulses(flowLimitGPM) {
    if ((flowLimitGPM === 0) || (flowLimitGPM === Zone.HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER)) {
      return flowLimitGPM;
    }
    const ppg = this.get('model.ppg') || 1;
    return Math.ceil(flowLimitGPM * ppg);
  },

  realTimeFlowEnabledDidChange: observer('model.realtimeFlowEnabled', function() {
    if (this.get('model.realtimeFlowEnabled')) {
      const prevLow = this.get('prevLowFlowLimit');
      const prevHigh = this.get('prevHighFlowLimit');
      if (prevLow != null) {
        this.set('model.lowFlowLimit', prevLow);
        this.set('prevLowFlowLimit', null);
      }
      if (prevHigh != null) {
        this.set('model.highFlowLimit', prevHigh);
        return this.set('prevHighFlowLimit', null);
      }
    } else {
      this.set('prevLowFlowLimit', parseInt(this.get('model.lowFlowLimit')));
      this.set('prevHighFlowLimit', parseInt(this.get('model.highFlowLimit')));
      this.set('model.lowFlowLimit', 0);
      this.set('model.highFlowLimit', Zone.HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER);
    }
  }),

  actions: {
    save() {
      return this.save({
        url: this.get('saveUrl'),
        params: {
          zone: {
            realtime_flow_enabled: this.get('model.realtimeFlowEnabled'),
            low_flow_limit:        this.flowLimitPulses(this.get('model.lowFlowLimit')),
            high_flow_limit:       this.flowLimitPulses(this.get('model.highFlowLimit')),
            valve_size:            this.get('model.valveSize'),
            ppg:                   this.get('model.ppg'),
            gpm:                   this.get('gpmGallons')
          }
        }
      }).then( () => {
        this.set('model.smartlinkController.hasUnsentChanges', true);
      });
    }
  }
});

export default SmartlinkControllerSettingsEditFlowController;
