`import Base from 'simple-auth/authenticators/base'`
`import AuthenticationMixin from '../mixins/authentication'`

WeathermaticAuthenticator = Base.extend AuthenticationMixin,
  config: Ember.computed -> @container.lookupFactory('config:environment')

  restore: (data) ->
    creds = Ember.Object.create(data).getProperties('email', 'password')
    @checkCredentials(creds)

  authenticate: (options) ->
    @checkCredentials(options)

  invalidate: (data) ->
    Ember.RSVP.resolve ->
      Ember.Logger.debug('Weathermatic session invalidated')

  checkCredentials: (credentials) ->
    self = this
    queryParams = {
      timestamp: new Date().getTime()
    }
    url = "#{@get('config.apiUrl')}/api/v2/users/me.json"
    new Ember.RSVP.Promise (resolve, reject) ->
      Ember.$.ajax(url,
        type: 'GET',
        dataType: 'json'
        data: queryParams
        headers:
          'Authorization': self.buildHttpBasicHeader(credentials.email, credentials.password)
        beforeSend: (xhr, _) ->
          self.setupHmacHeaders(xhr, type: 'GET', data: queryParams)
        success: (response) ->
          resolve({
            email: credentials.email
            password: credentials.password
            userInfo: response
          })
        error: (xhr, status, error) ->
          if (xhr.status is 401) or (xhr.status is 403)
            reject({
              type: 'badCredentials'
              responseData: xhr.responseJSON
            })
          else
            reject(new Error("Unexpected response from server during authentication: #{xhr.status}, #{error}"))
      )

`export default WeathermaticAuthenticator`
