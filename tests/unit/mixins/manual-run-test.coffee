`import Ember from 'ember'`
`import ManualRunMixin from '../../../mixins/manual-run'`
`import { module, test } from 'qunit'`

module 'ManualRunMixin'

# Replace this with your real tests.
test 'it works', (assert) ->
  ManualRunObject = Ember.Object.extend ManualRunMixin
  subject = ManualRunObject.create()
  assert.ok subject
