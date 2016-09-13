import Ember from 'ember';
import Base from 'ember-simple-auth/authenticators/base';
import AuthenticationMixin from '../mixins/authentication';
import config from '../config/environment';

const { RSVP, Logger: { debug }, $: { ajax }, getProperties, isEmpty } = Ember;;

const WeathermaticAuthenticator = Base.extend(AuthenticationMixin, {

  restore(data) {
    debug('WeathermaticAuthenticator#restore called');
    const { email, password } = getProperties(data, 'email', 'password');
    if (!isEmpty(email) && !isEmpty(password)) {
      return RSVP.Promise.resolve(data);
    } else {
      return RSVP.Promise.reject();
    }
  },

  authenticate(options) {
    debug('WeathermaticAuthenticator#authenticated called with options:', options);
    return this.checkCredentials(options);
  },

  invalidate(data) {
    debug('WeathermaticAuthenticator#invalidate called');
    return RSVP.resolve( () => {
      return debug('Weathermatic session invalidated');
    });
  },

  checkCredentials(credentials) {
    debug('WeathermaticAuthenticator#checkCredentials called');
    const url = config.apiUrl + "/api/v2/users/me.json";
    return new RSVP.Promise( (resolve, reject) => {
      return ajax(url, {
        type: 'GET',
        dataType: 'json',
        headers: {
          'Authorization': this.buildHttpBasicHeader(credentials.email, credentials.password)
        },
        success(response) {
          return resolve({
            email: credentials.email,
            password: credentials.password,
            userInfo: response,
            test: 'foobar',
          });
        },
        error(xhr, status, error) {
          if ((xhr.status === 401) || (xhr.status === 403)) {
            return reject({
              type: 'badCredentials',
              responseData: xhr.responseJSON
            });
          } else {
            return reject(new Error(`Unexpected response from server during authentication: ${xhr.status}, ${error}`));
          }
        }
      });
    });
  }

});

export default WeathermaticAuthenticator;
