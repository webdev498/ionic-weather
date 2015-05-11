`import ApplicationAdapter from './application'`
`import URLQueryParamsMixin from '../mixins/url-query-params'`

SitesAdapter = ApplicationAdapter.extend URLQueryParamsMixin,
  find: (store, type, id, snapshot) ->
    url = @buildURL(type.typeKey, id, snapshot)
    url = @addQueryParams(url, @customQueryParams)
    @ajax(url, 'GET')

  findHasMany: (store, snapshot, url, relationship) ->
    switch relationship.key
      when 'smartlinkControllers'
        @findSmartlinkControllers(arguments...)
      else this._super(arguments...)

  findSmartlinkControllers: (store, snapshot, url, relationship) ->
    host = Ember.get(this, 'host')
    id   = snapshot.id
    type = snapshot.typeKey

    if host and url.charAt(0) is '/' and url.charAt(1) is not '/'
      url = "#{host}#{url}"

    extraParams = store.adapterFor('smartlink-controller').get('customQueryParams')

    url = @addQueryParams(url, extraParams)
    @ajax(this.urlPrefix(url, this.buildURL(type, id)), 'GET')

  customQueryParams:
    embed_controllers: 'false'

`export default SitesAdapter`
