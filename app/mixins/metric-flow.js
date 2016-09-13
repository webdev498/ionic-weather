import Ember from 'ember';
import CurrentUserMixin from './current-user';

const VOLUME_MEASURE_LITERS = 1;

const LPM_PER_GPM = 3.78541178;

const formatDecimal = function(n) {
  return parseFloat(Math.round(n * 100) / 100).toFixed(2);
};

const MetricFlowMixin = Ember.Mixin.create(CurrentUserMixin, {

  isMetricEnabled: Ember.computed('currentUser', function() {
    return this.get('currentUser.volume_measure') === VOLUME_MEASURE_LITERS;
  }),

  flowUnits: Ember.computed('isMetricEnabled', function() {
    if (this.get('isMetricEnabled')) {
      return 'LPM';
    } else {
      return 'GPM';
    }
  }),

  flowInLocalUnits(flow) {
    const val = formatDecimal(this.flowValueInLocalUnits(flow));
    return `${val} ${this.get('flowUnits')}`
  },

  flowValueInLocalUnits(flow) {
    if (this.get('isMetricEnabled')) {
      flow = flow * LPM_PER_GPM;
    }
    return formatDecimal(flow);
  },

  lpmToGpm(flow) {
    return flow / LPM_PER_GPM;
  },

  sizeUnits: Ember.computed('isMetricEnabled', function() {
    if (this.get('isMetricEnabled')) {
      return 'mm';
    } else {
      return '"';
    }
  }),

  sizeInLocalUnits(size) {
    if (this.get('isMetricEnabled')) {
      size = size * 25.4;
    }
    size = formatDecimal(size);
    return size + " " + (this.get('sizeUnits'));
  }
});

export default MetricFlowMixin;
