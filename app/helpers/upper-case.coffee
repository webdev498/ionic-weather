`import Ember from 'ember'`

UpperCaseHelper = Ember.Helper.helper (params, options) ->
  return '' unless string = params[0]
  string.toUpperCase()

`export default UpperCaseHelper`
