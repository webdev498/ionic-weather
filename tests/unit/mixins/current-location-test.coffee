`import Ember from 'ember'`
`import CurrentLocationMixin from '../../../mixins/current-location'`
`import { module, test } from 'qunit'`

module 'CurrentLocationMixin'

# Replace this with your real tests.
test 'it works', (assert) ->
  CurrentLocationObject = Ember.Object.extend CurrentLocationMixin
  subject = CurrentLocationObject.create()
  assert.ok subject
