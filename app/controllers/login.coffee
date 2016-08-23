`import Ember from 'ember'`

LoginController = Ember.Controller.extend

  session: Ember.inject.service()

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
      Ember.Logger.debug 'LoginController logIn action'
      self = this
      @setProperties(isLoading: true, isError: false)
      @get('session').authenticate('authenticator:weathermatic', {
        email:    @get('email')
        password: @get('password')
      })
      .then (resp) ->
        Ember.Logger.debug 'Login succeeded'
        self.set('isError', false)
        self.set('password', null)
        self.set('isSuccess', true)
      .catch (error) ->
        if error.type is 'badCredentials'
          Ember.Logger.debug 'Login failed with bad creds'
          self.set('isError', true)
          self.set('hasErrored', true)
        else
          alert 'There was a problem communicating with our servers.  Please try again later.'
          Ember.Logger.error(error)
      .finally ->
        self.set('isLoading', false)

    createAccount: ->
      @send 'openLink', 'https://my.smartlinknetwork.com/users/sign_up'

`export default LoginController`
