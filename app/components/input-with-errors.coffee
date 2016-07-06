`import Ember from 'ember'`

InputWithErrorsComponent = Ember.Component.extend(
  init: ->
    @setDefaultType()
    this._super()

  setDefaultType: ->
    @set 'type', 'text' unless @get('type')?

  value: Ember.computed 'model', 'field', ->
    @get("model.#{@get('field')}")

  valueDidChange: Ember.observer 'value', ->
    @set("model.#{@get('field')}", @get('value'))

  hasError: Ember.computed 'model', 'field', 'errors.@each', ->
    Ember.keys(@get('errors')).length > 0
)

`export default InputWithErrorsComponent`
