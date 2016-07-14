`import Ember from 'ember'`
`import MetricFlowMixin from '../../../mixins/metric-flow'`
`import { module, test } from 'qunit'`

module 'MetricFlowMixin'

# Replace this with your real tests.
test 'it works', (assert) ->
  MetricFlowObject = Ember.Object.extend MetricFlowMixin
  subject = MetricFlowObject.create()
  assert.ok subject
