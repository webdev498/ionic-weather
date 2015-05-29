`import Ember from 'ember';`
`import config from './config/environment';`

Router = Ember.Router.extend(location: config.locationType).map ->
  @route 'login'
  @resource 'sites'
  @resource 'site', path: 'sites/:siteId', ->
    @resource 'smartlink-controller', path: 'controllers/:controllerId', ->
      @route 'select-program'
      @route 'run-program', path: 'run-program/:programId'
      @route 'select-zone'
      @route 'run-zone', path: 'run-zone/:zoneId'
      @route 'select-valves'
      @route 'locate-valves', path: 'locate-valves/:zoneId'
      @route 'walk-site', ->
        @route 'zone', path: 'zone/:zoneId'
      @route 'stop-all'
      @route 'clear-faults'
      @route 'command-success'

`export default Router`
