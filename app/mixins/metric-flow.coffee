`import Ember from 'ember'`
`import CurrentUserMixin from './current-user'`

VOLUME_MEASURE_LITERS = 1

MetricFlowMixin = Ember.Mixin.create(CurrentUserMixin,
  isMetricEnabled: Ember.computed 'currentUser', ->
    @get('currentUser.volume_measure') == VOLUME_MEASURE_LITERS

  flowUnits: Ember.computed 'isMetricEnabled', ->
    if @get('isMetricEnabled')
      'LPM'
    else
      'GPM'

  flowInLocalUnits: (flow) ->
    if @get('isMetricEnabled')
      flow = Math.round(flow * 3.78541178 * 100) / 100
    "#{flow} #{@get('flowUnits')}"


)

`export default MetricFlowMixin`
