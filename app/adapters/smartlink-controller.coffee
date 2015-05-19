`import ApplicationAdapter from './application'`

SmartlinkControllerAdapter = ApplicationAdapter.extend
  pathForType: -> 'controllers'

  find: (store, type, id, snapshot) ->
    url = @buildURL(type.typeKey, id, snapshot)
    @ajax(url, 'GET', data: @customQueryParams)

  customQueryParams:
    embed_zones: 'true'
    embed_site: 'false'
    wrap_result: 'true'

`export default SmartlinkControllerAdapter`
