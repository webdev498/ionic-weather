`import Ember from 'ember';`
`import config from './config/environment';`

Router = Ember.Router.extend(location: config.locationType).map ->
  @route 'login'
  @resource 'sites'
  @resource 'site', path: 'sites/:siteId', ->
    @route 'index', path: 'controllers'
  @resource 'smartlink-controller', path: 'controllers/:controllerId', ->
    @route 'select-program'
    @route 'run-program', path: 'run-program/:programId'
    @route 'select-zone'
    @route 'run-zone', path: 'run-zone/:zoneId'
    @route 'select-valves'
    @route 'locate-valves', path: 'locate-valves/:zoneId'
    @route 'walk-site', ->
      @route 'zone', path: 'zone/:zoneId'
    @route 'settings', path: 'settings', ->
      @route 'programming'
      @route 'program-details'
      @route 'edit-program-details', path: 'program-details/:programId'
      @route 'flow'
      @route 'edit-flow', path: 'zone-flow/:zoneId'
      @route 'program-run-times'
      @route 'edit-program-run-time', path: 'program-run-time/:zoneId'
      @route 'seasonal-adjust'
      @route 'edit-seasonal-adjust', path: 'edit-seasonal-adjust/:monthIndex'
      @route 'edit-omit-times'
      @route 'auto-adjust'
      @route 'edit-auto-adjust', path: 'edit-auto-adjust/:zoneId'
      @route 'edit-controller-basic'
      @route 'edit-controller-advanced'
      @route 'edit-zone-activations'
      @route 'edit-zone-rain-sensor'
      @route 'edit-zone-freeze-sensor'
      @route 'edit-zone-sensor'
      @route 'edit-zone-master-valve'
      @route 'edit-program-max-run'
    @route 'stop-all'
    @route 'clear-faults'
    @route 'command-success'

`export default Router`
