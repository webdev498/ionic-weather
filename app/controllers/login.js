import Ember from 'ember'

const LoginController = Ember.Controller.extend({

  session: Ember.inject.service(),
  i18n: Ember.inject.service(),

  setDefaults() {
    this.setProperties({
      isLoading: false,
      hasErrored: false,
      isError: false,
      isSuccess: false,
      password: null
    })
  },

  loadLanguage: function(language){
    let globalLanguage = language.split("-")[0]
    this.set('i18n.locale', globalLanguage);
  },

  setLanguage: function(){
    let self = this;
    if(navigator.globalization){
        navigator.globalization.getPreferredLanguage(
            function (language) {
              self.loadLanguage(language.value);
            },
            function () {
              this.set('i18n.locale', 'en');
            }
        );
    }
    else if(navigator.language){
      self.loadLanguage(navigator.language);
    }
  },

  init: function () {
    this.setLanguage()
  },

  actions: {
    logIn(){
      Ember.Logger.debug('LoginController logIn action')
      self = this
      this.setProperties({isLoading: true, isError: false})
      this.get('session').authenticate('authenticator:weathermatic', {
        email:    this.get('email'),
        password: this.get('password')
      }).then(function(resp){
        Ember.Logger.debug('Login succeeded');
        self.set('isError', false);
        self.set('password', null);
        self.set('isSuccess', true);
      }).catch(function(error) {
        if(error.type === 'badCredentials'){
          Ember.Logger.debug('Login failed with bad creds')
          self.set('isError', true)
          self.set('hasErrored', true)
        }else{
          alert('There was a problem communicating with our servers.  Please try again later.')
          Ember.Logger.error(error)
        }
      }).finally(function(){
        self.set('isLoading', false)
      })
    },
    createAccount(){
      this.send('openLink', 'https://my.smartlinknetwork.com/users/sign_up')
    }

  }
})

export default LoginController
