`import ApplicationAdapter from './application'`

SitesAdapter = ApplicationAdapter.extend
  find: (store, type, id, snapshot) ->
    url = @buildURL(type.typeKey, id, snapshot)
    @ajax(url, 'GET', data: @customQueryParams)

  query: (store, type, query) ->
    query = query or {}
    Ember.merge(query, @customQueryParams)
    this._super(arguments...)

  ajaxOptions: (url, type, options) ->
    Ember.Logger.debug("SitesAdapter.ajaxOptions(), url, type, options", url, type, options)
    hash = this._super(arguments...) || { data: {} }
    Ember.merge(hash.data, this.customQueryParams)
    return hash

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
    include_faults_count: 'true'
    include_controllers_count: 'true'

`export default SitesAdapter`
