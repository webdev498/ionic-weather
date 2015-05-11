`import ApplicationAdapter from './application'`
`import URLQueryParamsMixin from '../mixins/url-query-params'`

SmartlinkControllerAdapter = ApplicationAdapter.extend URLQueryParamsMixin,
  pathForType: -> 'controllers'

  find: (store, type, id, snapshot) ->
    url = @buildURL(type.typeKey, id, snapshot)
    url = @addQueryParams(url, @customQueryParams)
    @ajax(url, 'GET')

  customQueryParams:
    embed_zones: 'true'
    embed_site: 'false'
    wrap_result: 'true'

`export default SmartlinkControllerAdapter`
