`import Ember from 'ember'`
`import SitesLookupMixin from '../../../mixins/sites-lookup'`
`import { module, test } from 'qunit'`

module 'SitesLookupMixin'

# Replace this with your real tests.
test 'it works', (assert) ->
  SitesLookupObject = Ember.Object.extend SitesLookupMixin
  subject = SitesLookupObject.create()
  assert.ok subject
