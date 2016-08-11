`import Ember from 'ember'`
`import MetricFlowMixin from '../mixins/metric-flow'`
`import Zone from '../models/zone'`

FlowDetailsComponent = Ember.Component.extend(MetricFlowMixin,
  tagName: 'li'
  classNames: ['table-view-cell']

  lowFlowLimit: Ember.computed 'isMetricEnabled', 'zone.lowFlowLimit', ->
    @flowInLocalUnits(@get('zone.lowFlowLimit'))

  highFlowLimit: Ember.computed 'isMetricEnabled', 'zone.highFlowLimit', ->
    @flowInLocalUnits(@get('zone.highFlowLimit'))

  isLowFlowLimitOff: Ember.computed 'zone.lowFlowLimit', ->
    @get('zone.lowFlowLimit') == 0

  isHighFlowLimitOff: Ember.computed 'zone.highFlowLimit', ->
    @get('zone.highFlowLimit') == Zone.HIGH_FLOW_LIMIT_DISABLED_MAGIC_NUMBER

  gpmInLocalUnits: Ember.computed 'isMetricEnabled', ->
    @flowInLocalUnits(@get('zone.gpm'))

  valveSizeInLocalUnits: Ember.computed 'zone.valveSize', 'isMetricEnabled', ->
    @sizeInLocalUnits(@get('zone.valveSize'))

)

`export default FlowDetailsComponent`
