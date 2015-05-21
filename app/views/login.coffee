`import Ember from 'ember'`

LoginView = Ember.View.extend
  didInsertElement: ->
    @$('input:first').focus()

`export default LoginView`
