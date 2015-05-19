`import ApplicationAdapter from './application'`

SitesAdapter = ApplicationAdapter.extend
  find: (store, type, id, snapshot) ->
    url = @buildURL(type.typeKey, id, snapshot)
    @ajax(url, 'GET', data: @customQueryParams)

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

    @ajax(this.urlPrefix(url, this.buildURL(type, id)), 'GET', data: extraParams)

  customQueryParams:
    embed_controllers: 'false'
    wrap_result: 'true'

`export default SitesAdapter`
