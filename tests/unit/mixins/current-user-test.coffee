`import Ember from 'ember'`
`import CurrentUserMixin from '../../../mixins/current-user'`
`import { module, test } from 'qunit'`

module 'CurrentUserMixin'

# Replace this with your real tests.
test 'it works', (assert) ->
  CurrentUserObject = Ember.Object.extend CurrentUserMixin
  subject = CurrentUserObject.create()
  assert.ok subject
