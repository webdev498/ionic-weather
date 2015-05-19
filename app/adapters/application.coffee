`import DS from 'ember-data'`
`import config from '../config/environment'`

# Pretender (mock API server) does not like it when the host is set
if config.useMockApi then host = '' else host = config.apiUrl

SLNAK = '7d56617d4d6febd91be7f87c03c1ee37'
SLNAS = '52834b76a803eb35706701fa71c7ac79'

ApplicationAdapter = DS.RESTAdapter.extend
  host: host
  namespace: 'api/v2'

  ajaxSuccess: (xhr, json) ->
    #
    # Weathermatic API responses are wrapped in an object called `result`, e.g.
    #
    # {
    #   "result": {
    #     "site": { ... }
    #   },
    #   "meta": { ... }
    # }
    #
    # We want something like this instead:
    # {
    #   "site": { ... },
    #   "meta": { ... }
    # }
    #
    json.result.meta = json.meta
    delete json.meta
    json.result

  ajaxOptions: (url, type, options) ->
    this._super(arguments...)
    hash = this._super(arguments...)
    @addTimestamp(hash)
    return hash

  addTimestamp: (options) ->
    Ember.merge(options.data, timestamp: new Date().getTime())


`export default ApplicationAdapter`
