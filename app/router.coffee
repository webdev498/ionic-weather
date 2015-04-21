`import Ember from 'ember';`
`import config from './config/environment';`

Router = Ember.Router.extend(location: config.locationType).map ->
  @resource 'sites'
  @resource 'site', path: 'sites/:siteId', ->
    @resource 'smartlink-controller', path: 'controllers/:controllerId', ->
      @route 'select-program'
      @route 'run-program', path: 'run-program/:programId'
      @route 'select-zone'
      @route 'run-zone', path: 'run-zone/:zoneId'
      @route 'select-valves'
      @route 'locate-valves'
      @route 'walk-site'

  @route 'smartlink-controller/run-program'
  @route 'smartlink-controller/select-program'
  @route 'smartlink-controller/select-zone'
  @route 'smartlink-controller/run-zone'
  @route 'smartlink-controller/select-valves'

`export default Router`
