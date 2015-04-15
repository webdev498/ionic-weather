import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

export default Router.map(function() {
  this.resource('sites');
  this.resource('site', { path: 'sites/:siteId' }, function() {
    this.resource('smartlink-controller', { path: 'controllers/:controllerId' }, function() {
      this.route('select-program');
      this.route('run-program', { path: 'run-program/:programId' });
    });
  });
});
