`import Ember from 'ember'`

SLNAK = '7d56617d4d6febd91be7f87c03c1ee37'
SLNAS = '52834b76a803eb35706701fa71c7ac79'

AuthenticationMixin = Ember.Mixin.create
  verifyTimestamp: (options) ->
    if options.contentType == 'application/json'
      if typeof(options.data) is 'string'
        data = JSON.parse(options.data)
      else
        data = options.data
    else
      if typeof(options.data) is 'string'
        data = @parseQueryParams(options.data)
      else
        data = options.data

    unless data.timestamp
      throw new Error('AJAX requests must include a `timestamp` query param')

  setupHttpBasicHeaders: (xhr, email, password) ->
    xhr.setRequestHeader('Authorization', @buildHttpBasicHeader(email, password))

  buildHttpBasicHeader: (email, password) ->
    base64EncodedAuthToken = btoa("#{email}:#{password}")
    "Basic #{base64EncodedAuthToken}"

  setupHmacHeaders: (xhr, options) ->
    xhr.setRequestHeader('x-api-key', SLNAK)
    xhr.setRequestHeader('x-api-hmac', @buildHmacSignature(options))

  buildHmacSignature: (options) ->
    @verifyTimestamp(options)
    content = @buildHmacContent(options)
    @signHmacContent(content)

  signHmacContent: (content) ->
    CryptoJS.HmacSHA256(content, SLNAS).toString(CryptoJS.enc.Base64)

  buildHmacContent: (options) ->
    return options.data if typeof(options.data) is 'string'
    if options.type is 'GET'
      Ember.$.param(options.data)
    else
      JSON.stringify(options.data)

  parseQueryParams: (queryString) ->
    return {} unless queryString
    data = {}
    queryString.split('&').forEach (pair) ->
      [key, value] = pair.split('=')
      data[key] = value
    return data

`export default AuthenticationMixin`
