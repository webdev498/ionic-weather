`import Ember from 'ember'`
`import TransmitMixin from '../../../mixins/transmit'`
`import { module, test } from 'qunit'`

module 'TransmitMixin'

# Replace this with your real tests.
test 'it works', (assert) ->
  TransmitObject = Ember.Object.extend TransmitMixin
  subject = TransmitObject.create()
  assert.ok subject
