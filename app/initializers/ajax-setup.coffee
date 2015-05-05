SLNAK = '7d56617d4d6febd91be7f87c03c1ee37'
SLNAS = '52834b76a803eb35706701fa71c7ac79'

initialize = (_container, _app) ->
  Ember.$.ajaxPrefilter (options, originalOptions, xhr) ->
    setupHTTPBasicHeaders(xhr)
    setupHMACHeaders(xhr, options)

setupHTTPBasicHeaders = (request) ->
  base64EncodedAuthToken = localStorage.getItem('sln-mobile-auth-token-base64')
  throw new Error('Auth token not found') unless base64EncodedAuthToken
  request.setRequestHeader('Authorization', "Basic #{base64EncodedAuthToken}")

setupHMACHeaders = (request, ajaxOptions) ->
  request.setRequestHeader('x-api-key', SLNAK)
  content = buildHMACContent(ajaxOptions)
  hmac = buildHMACSignature(content)
  request.setRequestHeader('x-api-hmac', hmac)

buildHMACSignature = (content) ->
  CryptoJS.HmacSHA256(content, SLNAS).toString(CryptoJS.enc.Base64)

buildHMACContent = (ajaxOptions) ->
  if typeof ajaxOptions.data is 'string'
    buildHMACContentFromQueryParams(ajaxOptions.data)
  else
    buildHMACContentFromFormData(ajaxOptions.data)

buildHMACContentFromQueryParams = (queryParams) ->
  data = parseQueryParams(queryParams)
  verifyTimestamp(data)
  return queryParams

buildHMACContentFromFormData = (formData) ->
  verifyTimestamp(formData)
  JSON.stringify(formData)

verifyTimestamp = (data) ->
  unless data.timestamp
    throw new Error('AJAX requests must include a `timestamp` query param')

parseQueryParams = (queryString) ->
  return {} unless queryString
  data = {}
  queryString.split('&').forEach (pair) ->
    [key, value] = pair.split('=')
    data[key] = value
  return data


AjaxSetupInitializer =
  name: 'ajax-setup'
  initialize: initialize

`export {initialize}`
`export default AjaxSetupInitializer`
