import Ember from 'ember';
import Base from 'ember-simple-auth/authorizers/base';
import AuthenticationMixin from '../mixins/authentication';

const WeathermaticAuthorizer = Base.extend(AuthenticationMixin, {
  // session: Ember.inject.service(),

  authorize(sessionData, addHeader) {
    Ember.Logger.debug('WeathermaticAuthorizer#authorize called')

    const { email, password } = sessionData;
    addHeader('Authorization', this.buildHttpBasicHeader(email, password))
  }

  // authorize: (xhr, options) ->
  //   Ember.Logger.debug "WeathermaticAuthorizer#authorize called with arguments:", arguments

  //   return unless @get('session').isAuthenticated
  //   email = @get('session.content.secure.email')
  //   password = @get('session.content.secure.password')
  //   @setupHttpBasicHeaders(xhr, email, password)
  //   @setupHmacHeaders(xhr, options)

})

export default WeathermaticAuthorizer;
