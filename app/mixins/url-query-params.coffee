`import Ember from 'ember'`

CustomQueryParamsMixin = Ember.Mixin.create
  addQueryParams: (url, params) ->
    for name, value of params
      url = @addQueryParam(url, name, value)
    return url

  addQueryParam: (url, key, value) ->
    delimiter = if url.match /\?/ then '&' else '?'
    "#{url}#{delimiter}#{key}=#{value}"


`export default CustomQueryParamsMixin`
