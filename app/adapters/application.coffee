`import DS from 'ember-data'`
`import config from '../config/environment'`

# Pretender (mock API server) does not like it when the host is set
if config.useMockApi then host = '' else host = config.apiUrl

ApplicationAdapter = DS.RESTAdapter.extend
  host: host
  namespace: 'api/v2'
  headers:
    'Authorization': 'Basic dHJveS5uaWNob2xzQHdlYXRoZXJtYXRpYy5jb206dGVzdHBhc3M='

  ajaxSuccess: (xhr, json) ->
    # Weathermatic API responses are wrapped in an object called `result`
    # e.g. { "result": { "site": { ... } }
    json.result

`export default ApplicationAdapter`
