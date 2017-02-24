import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({ location: config.locationType }).map(function() {
  this.route('login');
  this.route('sites', { resetNamespace: true });

  this.route('site', { resetNamespace: true, path: 'sites/:siteId' }, function() {
    this.route('index', {
      path: 'controllers'
    });
  });

  this.route('smartlink-controller', { resetNamespace: true, path: 'controllers/:controllerId' }, function() {
    this.route('select-program');
    this.route('run-program', { path: 'run-program/:programId' });
    this.route('select-zone');
    this.route('run-zone', { path: 'run-zone/:zoneId' });
    this.route('select-valves');
    this.route('locate-valves', { path: 'locate-valves/:zoneId' });
    //Inspection Route
    this.route('inspections');
    this.route('edit-inspection', { path: 'inspections/edit'});

    this.route('walk-site', function() {
      this.route('zone', { path: 'zone/:zoneId' });

    });
    this.route('settings', { path: 'settings' }, function() {
      this.route('programming');
      this.route('program-details');
      this.route('edit-program-details', { path: 'program-details/:programId' });
      this.route('flow');
      this.route('edit-flow', { path: 'zone-flow/:zoneId' });
      this.route('program-run-times');
      this.route('edit-program-run-time', { path: 'program-run-time/:zoneId' });
      this.route('seasonal-adjust');
      this.route('edit-seasonal-adjust', { path: 'edit-seasonal-adjust/:monthIndex' });
      this.route('edit-omit-times');
      this.route('auto-adjust');
      this.route('edit-auto-adjust', { path: 'edit-auto-adjust/:zoneId' });
      this.route('edit-controller-basic');
      this.route('edit-controller-advanced');
      this.route('edit-labels');
      this.route('edit-zone-activations');
      this.route('edit-zone-rain-sensor');
      this.route('edit-zone-freeze-sensor');
      this.route('edit-zone-sensor');
      this.route('edit-zone-master-valve');

      this.route('edit-program-max-run');
    });

    this.route('stop-all');
    this.route('clear-faults');
    this.route('command-success');
  });

});

export default Router;