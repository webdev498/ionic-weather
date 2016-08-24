`import Ember from 'ember'`
`import StringsMixin from '../mixins/strings'`

shortener = Ember.Object.extend(StringsMixin).create()

# This function receives the params `params, hash`
shortText = (params, hash) ->
  shortener.shorten(params[0], hash.size)

ShortTextHelper = Ember.Helper.helper(shortText)

`export { shortText }`

`export default ShortTextHelper`
