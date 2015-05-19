SLNAK = '7d56617d4d6febd91be7f87c03c1ee37'
SLNAS = '52834b76a803eb35706701fa71c7ac79'

initialize = (_container, _app) ->
  Ember.$.ajaxPrefilter (options, originalOptions, xhr) ->
    verifyTimestamp(options.data)
    setupHeaders(xhr, options)

verifyTimestamp = (data) ->
  if typeof(data) is 'string'
    data = parseQueryParams(data)
  unless data.timestamp
    throw new Error('AJAX requests must include a `timestamp` query param')

setupHeaders = (xhr, options) ->
  xhr.setRequestHeader('Authorization', buildAuthorizationHeader())
  xhr.setRequestHeader('x-api-key', SLNAK)
  xhr.setRequestHeader('x-api-hmac', buildHMACSignature(options))

buildAuthorizationHeader = ->
  base64EncodedAuthToken = localStorage.getItem('sln-mobile-auth-token-base64')
  throw new Error('Auth token not found') unless base64EncodedAuthToken
  "Basic #{base64EncodedAuthToken}"

buildHMACSignature = (options) ->
  content = buildHMACContent(options)
  signHMACContent(content)

buildHMACContent = (options) ->
  if options.type is 'GET'
    return options.data if typeof(options.data) is 'string'
    Ember.$.param(options.data)
  else
    JSON.stringify(options.data)

signHMACContent = (content) ->
  CryptoJS.HmacSHA256(content, SLNAS).toString(CryptoJS.enc.Base64)

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
