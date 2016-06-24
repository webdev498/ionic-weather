`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`
`import { module, test } from 'qunit'`

module 'SmartlinkSaveMixin'

# Replace this with your real tests.
test 'it works', (assert) ->
  SmartlinkSaveObject = Ember.Object.extend SmartlinkSaveMixin
  subject = SmartlinkSaveObject.create()
  assert.ok subject
