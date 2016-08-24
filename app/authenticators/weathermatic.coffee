`import Ember from 'ember'`
`import Base from 'ember-simple-auth/authenticators/base'`
`import AuthenticationMixin from '../mixins/authentication'`
`import config from '../config/environment'`

WeathermaticAuthenticator = Base.extend AuthenticationMixin,

  restore: (data) ->
    Ember.Logger.debug 'WeathermaticAuthenticator#restore called'

    creds = Ember.Object.create(data).getProperties('email', 'password')
    @checkCredentials(creds)

  authenticate: (options) ->
    Ember.Logger.debug 'WeathermaticAuthenticator#authenticated called with options:', options
    @checkCredentials(options)

  invalidate: (data) ->
    Ember.Logger.debug 'WeathermaticAuthenticator#invalidate called'

    Ember.RSVP.resolve ->
      Ember.Logger.debug('Weathermatic session invalidated')

  checkCredentials: (credentials) ->
    Ember.Logger.debug 'WeathermaticAuthenticator#checkCredentials called'

    self = this
    queryParams = {
      timestamp: new Date().getTime()
    }
    url = "#{config.apiUrl}/api/v2/users/me.json"
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
