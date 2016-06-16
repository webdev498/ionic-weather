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
      @route 'flow'
      @route 'edit-flow', path: 'zone-flow/:zoneId'
      @route 'program-run-times'
      @route 'edit-program-run-time', path: 'program-run-time/:zoneId'
      @route 'seasonal-adjust'
      @route 'edit-seasonal-adjust', path: 'edit-seasonal-adjust/:monthIndex'
      @route 'edit-controller-basic'
      @route 'edit-controller-advanced'
      @route 'edit-zone-activations'
      @route 'edit-zone-rain-sensor'
    @route 'stop-all'
    @route 'clear-faults'
    @route 'command-success'

`export default Router`
