`import DS from 'ember-data'`
`import config from '../config/environment'`

SLNAK = '7d56617d4d6febd91be7f87c03c1ee37'
SLNAS = '52834b76a803eb35706701fa71c7ac79'

ApplicationAdapter = DS.RESTAdapter.extend
  host: config.apiUrl
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
    hash = this._super(arguments...) or {}
    @addStandardParams(hash)
    return hash

  addStandardParams: (options) ->
    options.data = options.data or {}
    Ember.merge(options.data, {
      timestamp: new Date().getTime()
      wrap_result: true
    })

  findHasManyWithExtraParams: (store, snapshot, url, relationship, extraParams) ->
    host = Ember.get(this, 'host')
    id   = snapshot.id
    type = snapshot.typeKey
    if host and url.charAt(0) is '/' and url.charAt(1) is not '/'
      url = "#{host}#{url}"
    @ajax(this.urlPrefix(url, this.buildURL(type, id)), 'GET', data: extraParams)


`export default ApplicationAdapter`
