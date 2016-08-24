`import Ember from 'ember'`
`import {singularize, pluralize} from 'ember-inflector'`

countText = (params, options) ->
  text = params[0]
  count = params[1]
  if count
    return "1 #{singularize(text)}" if count is 1
    "#{count} #{pluralize(text)}"
  else
    "no #{pluralize(text)}"


CountTextHelper = Ember.Helper.helper(countText)

`export { countText }`

`export default CountTextHelper`
