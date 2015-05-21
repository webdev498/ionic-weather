`import Ember from 'ember'`
`import AuthenticationMixin from '../../../mixins/authentication'`
`import { module, test } from 'qunit'`

module 'AuthenticationMixin'

# Replace this with your real tests.
test 'it works', (assert) ->
  AuthenticationObject = Ember.Object.extend AuthenticationMixin
  subject = AuthenticationObject.create()
  assert.ok subject
