import Ember from 'ember';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';

var ApplicationRoute;

ApplicationRoute = Ember.Route.extend(ApplicationRouteMixin, {

  sites: Ember.inject.service('sites'),

  actions: {

    openLink: function(url) {
      return window.open(url, '_system');
    },

    logOut: function() {
      this.get('session').invalidate();
      return this.get('sites').clearCache();
    },

    sessionInvalidationSucceeded: function() {
      Ember.Logger.debug('ApplicationRoute sessionInvalidationSucceeded, redirecting to login route');
      return this.transitionTo('login');

    },

    error: function(error, transition) {
      Ember.Logger.debug('ApplicationRoute error: ' + error + ', transition.targetName: ' + transition.targetName);

      if (transition.targetName === 'index' || transition.targetName === 'sites') {
        Ember.Logger.error('Unhandled routing error');
        throw new Error('Unhandled routing error', error, transition);
      } else {
        Ember.Logger.error('Unhandled routing error, redirecting to index', error, transition);
        return this.transitionTo('index');
      }
    }
  }
});

export default ApplicationRoute;
