`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SitesRoute = Ember.Route.extend AuthenticatedRouteMixin,
  settings: Ember.inject.service('application-settings')

  sites: Ember.inject.service('sites')

  model: (params) ->
    self = this
    preCachedSitesList = window.SlnMobileEmber.get('cachedSites')
    return preCachedSitesList if preCachedSitesList?
    @get('sites').lookupAndCacheSites().then (sites) ->
      return sites
    .catch (error) ->
      Ember.Logger.debug 'Sites lookup failed, trying again without geolocation'
      self.get('settings').changeSetting('sites-sort-method', 'alpha')
      self.set('geolocationUnavailable', true)
      self.get('sites').lookupAndCacheSites()

  setupController: (controller, model) ->
    this._super(arguments...)
    controller.set('geolocationUnavailable', @get('geolocationUnavailable'))

`export default SitesRoute`
