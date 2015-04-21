`import Ember from 'ember'`

UpperCaseHelper = Ember.HTMLBars.makeBoundHelper (params, options) ->
  return '' unless string = params[0]
  string.toUpperCase()

`export default UpperCaseHelper`
