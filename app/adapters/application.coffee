`import DS from 'ember-data'`
`import config from '../config/environment'`

# Pretender (mock API server) does not like it when the host is set
if config.useMockApi then host = '' else host = config.apiUrl

SLNAK = '7d56617d4d6febd91be7f87c03c1ee37'
SLNAS = '52834b76a803eb35706701fa71c7ac79'

ApplicationAdapter = DS.RESTAdapter.extend
  host: host
  namespace: 'api/v2'

  ajaxOptions: (url, type, options) ->
    options = options || {}
    options.data = options.data || {}

    extraQueryParams = {
      timestamp: new Date().getTime()
    }

    Ember.merge(options.data, extraQueryParams)
    this._super(url, type, options)

  ajaxSuccess: (xhr, json) ->
    # Weathermatic API responses are wrapped in an object called `result`
    # e.g. { "result": { "site": { ... } }
    json.result

`export default ApplicationAdapter`
