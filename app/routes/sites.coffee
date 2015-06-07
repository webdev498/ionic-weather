`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SitesRoute = Ember.Route.extend AuthenticatedRouteMixin,
  settings: Ember.inject.service('application-settings')

  sites: Ember.inject.service('sites')

  model: (params) ->
    preCachedSitesList = window.SlnMobileEmber.get('cachedSites')
    return preCachedSitesList if preCachedSitesList?
    @get('sites').lookupAndCacheSites()

  setupController: (controller, model) ->
    this._super(arguments...)
    isGeolocationRestricted = @get('settings').getSetting('geolocation-restricted') is 'true'
    controller.set('isGeolocationRestricted', isGeolocationRestricted)

`export default SitesRoute`
