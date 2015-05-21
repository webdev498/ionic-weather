`import Ember from 'ember'`

LoginController = Ember.Controller.extend
  setDefaults: ->
    @setProperties(
      isLoading: false
      hasErrored: false
      isError: false
      isSuccess: false
      password: null
    )

  actions:
    logIn: ->
      self = this
      @setProperties(isLoading: true, isError: false)
      @get('session').authenticate('authenticator:weathermatic', {
        email:    @get('email')
        password: @get('password')
      })
      .then( (resp) ->
        self.set('isError', false)
        self.set('password', null)
        self.set('isSuccess', true)
      )
      .catch ->
        self.set('isError', true)
        self.set('hasErrored', true)
      .finally ->
        self.set('isLoading', false)

`export default LoginController`
