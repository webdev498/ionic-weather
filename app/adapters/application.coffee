`import DS from 'ember-data'`
`import config from '../config/environment'`

# ApplicationAdapter = DS.ActiveModelAdapter.extend
#   host: config.apiUrl

ApplicationAdapter = DS.FixtureAdapter

`export default ApplicationAdapter`
