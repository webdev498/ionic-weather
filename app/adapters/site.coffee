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
    extraParams = store.adapterFor('smartlink-controller').get('customQueryParams')
    @findHasManyWithExtraParams(store, snapshot, url, relationship, extraParams)

  customQueryParams:
    embed_controllers: 'false'

`export default SitesAdapter`
