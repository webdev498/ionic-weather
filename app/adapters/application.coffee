`import DS from 'ember-data'`
`import config from '../config/environment'`
`import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin'`

SLNAK = '7d56617d4d6febd91be7f87c03c1ee37'
SLNAS = '52834b76a803eb35706701fa71c7ac79'

ApplicationAdapter = DS.RESTAdapter.extend DataAdapterMixin,
  host: config.apiUrl
  namespace: 'api/v2'

  authorizer: 'authorizer:weathermatic'

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
    options.headers = options.headers || {}
    Ember.merge(options.headers, {
      'X-Weathermatic-Mobile': 1
    })

  findHasManyWithExtraParams: (store, snapshot, url, relationship, extraParams) ->
    host = Ember.get(this, 'host')
    id   = snapshot.id
    type = snapshot.typeKey
    if host and url.charAt(0) is '/' and url.charAt(1) is not '/'
      url = "#{host}#{url}"
    @ajax(this.urlPrefix(url, this.buildURL(type, id)), 'GET', data: extraParams)


`export default ApplicationAdapter`
