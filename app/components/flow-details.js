import Ember from 'ember';
import MetricFlowMixin from '../mixins/metric-flow';
import Zone from '../models/zone';

const { Component, computed } = Ember;

const FlowDetailsComponent = Component.extend(MetricFlowMixin, {
  tagName: 'li',

  classNames: ['table-view-cell'],

  lowFlowLimit: computed('isMetricEnabled', 'zone.lowFlowLimit', function() {
    return this.flowInLocalUnits(this.get('zone.lowFlowLimit'));
  }),

  highFlowLimit: computed('isMetricEnabled', 'zone.highFlowLimit', function() {
    return this.flowInLocalUnits(this.get('zone.highFlowLimit'));
  }),

  isLowFlowLimitOff: computed('zone.lowFlowLimit', function() {
    return this.get('zone.lowFlowLimit') === 0;
  }),

  isHighFlowLimitOff: computed('zone.highFlowLimit', function() {
    return this.get('zone.highFlowLimit') === Zone.HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER;
  }),

  gpmInLocalUnits: computed('isMetricEnabled', function() {
    return this.flowInLocalUnits(this.get('zone.gpm'));
  }),

  valveSizeInLocalUnits: computed('zone.valveSize', 'isMetricEnabled', function() {
    return this.sizeInLocalUnits(this.get('zone.valveSize'));
  }),

  runningAvgFlowInLocalUnits: computed('isMetricEnabled', function() {
    return this.flowInLocalUnits(this.get('zone.runningAverageFlow'));
  }),

  currentAvgGPMInLocalUnits: computed('isMetricEnabled', function() {
    return this.flowInLocalUnits(this.get('zone.currentAverageGPM'))
  })
});

export default FlowDetailsComponent;
