import Ember from 'ember';
import Base from 'ember-simple-auth/authorizers/base';
import AuthenticationMixin from '../mixins/authentication';

const { Logger: { debug }} = Ember;

const WeathermaticAuthorizer = Base.extend(AuthenticationMixin, {
  authorize(sessionData, addHeader) {
    debug('WeathermaticAuthorizer#authorize called');

    const { email, password } = sessionData;
    addHeader('Authorization', this.buildHttpBasicHeader(email, password));
  }
});

export default WeathermaticAuthorizer;
