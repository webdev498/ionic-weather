`import Ember from 'ember'`
`import CurrentUserMixin from './current-user'`

VOLUME_MEASURE_LITERS = 1
LPM_PER_GPM = 3.78541178

formatDecimal = (n) -> parseFloat(Math.round(n * 100) / 100).toFixed(2)

MetricFlowMixin = Ember.Mixin.create(CurrentUserMixin,
  isMetricEnabled: Ember.computed 'currentUser', ->
    @get('currentUser.volume_measure') == VOLUME_MEASURE_LITERS

  flowUnits: Ember.computed 'isMetricEnabled', ->
    if @get('isMetricEnabled')
      'LPM'
    else
      'GPM'

  flowInLocalUnits: (flow) ->
    val = formatDecimal(@flowValueInLocalUnits(flow))
    "#{val} #{@get('flowUnits')}"

  flowValueInLocalUnits:  (flow) ->
    if @get('isMetricEnabled')
      flow = flow * LPM_PER_GPM
    flow = formatDecimal(flow)
    return flow

  lpmToGpm: (flow) ->
    flow / LPM_PER_GPM

  sizeUnits: Ember.computed 'isMetricEnabled', ->
    if @get('isMetricEnabled')
      'mm'
    else
      '"'

  sizeInLocalUnits:(size) ->
    if @get('isMetricEnabled')
      size = size * 25.4
    size = formatDecimal(size)
    "#{size} #{@get('sizeUnits')}"

)

`export default MetricFlowMixin`
