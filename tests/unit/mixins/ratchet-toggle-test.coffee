`import Ember from 'ember'`
`import RatchetToggleMixin from '../../../mixins/ratchet-toggle'`
`import { module, test } from 'qunit'`

module 'RatchetToggleMixin'

# Replace this with your real tests.
test 'it works', (assert) ->
  RatchetToggleObject = Ember.Object.extend RatchetToggleMixin
  subject = RatchetToggleObject.create()
  assert.ok subject
