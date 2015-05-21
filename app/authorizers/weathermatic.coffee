`import Base from 'simple-auth/authorizers/base'`
`import AuthenticationMixin from '../mixins/authentication'`

WeathermaticAuthorizer = Base.extend AuthenticationMixin,
  authorize: (xhr, options) ->
    return unless @get('session').isAuthenticated
    email = @get('session.content.secure.email')
    password = @get('session.content.secure.password')
    @setupHttpBasicHeaders(xhr, email, password)
    @setupHmacHeaders(xhr, options)


`export default WeathermaticAuthorizer`
