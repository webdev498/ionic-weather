`import Ember from 'ember'`
`import StringsMixin from '../../../mixins/strings'`
`import { module, test } from 'qunit'`

module 'StringsMixin'

# Replace this with your real tests.
test 'it works', (assert) ->
  StringsObject = Ember.Object.extend StringsMixin
  subject = StringsObject.create()
  assert.ok subject
