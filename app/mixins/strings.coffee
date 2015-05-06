`import Ember from 'ember'`

StringsMixin = Ember.Mixin.create
  shorten: (text, size = 30) ->
    return '' unless text?.length
    if @strip(text).length >= size
      "#{@strip(text).substring(0, size)}..."
    else
      text

  strip: (text) ->
    text?.replace(/^\s+|\s+$/g, '')

`export default StringsMixin`
