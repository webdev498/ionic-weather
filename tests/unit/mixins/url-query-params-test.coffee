`import Ember from 'ember'`
`import URLQueryParamsMixin from '../../../mixins/url-query-params'`
`import { module, test } from 'qunit'`

module 'URLQueryParamsMixin'

# Replace this with your real tests.
test 'it works', (assert) ->
  URLQueryParamsObject = Ember.Object.extend URLQueryParamsMixin
  subject = URLQueryParamsObject.create()
  assert.ok subject
