`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SitesRoute = Ember.Route.extend(AuthenticatedRouteMixin,
  settings: Ember.inject.service('application-settings')

  sites: Ember.inject.service('sites')

  model: (params) ->
    Ember.Logger.debug 'In SitesRoute model'
    self = this
    preCachedSitesList = window.SLN_MOBILE_CACHED_SITES
    return preCachedSitesList if preCachedSitesList?
    @get('sites').lookupAndCacheSites().then (sites) ->
      return Ember.Object.create({
        sites: sites.toArray(),
        meta: sites.get('meta'),
      });
    .catch (error) ->
      Ember.Logger.debug 'Sites lookup failed, trying again without geolocation'
      self.get('settings').changeSetting('sites-sort-method', 'alpha')
      self.set('geolocationUnavailable', true)
      self.get('sites').lookupAndCacheSites()

  setupController: (controller, model) ->
    Ember.Logger.debug 'In SitesRoute setupController'
    Ember.Logger.debug "geolocationUnavailable value: #{@get('geolocationUnavailable')}"
    controller.set('geolocationUnavailable', @get('geolocationUnavailable'))
    this._super(arguments...)
)

`export default SitesRoute`
