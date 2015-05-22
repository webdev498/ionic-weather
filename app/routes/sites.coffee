`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SitesRoute = Ember.Route.extend AuthenticatedRouteMixin,
  sites: Ember.inject.service('sites')

  model: (params) ->
    preCachedSitesList = window.SlnMobileEmber.get('cachedSites')
    return preCachedSitesList if preCachedSitesList?
    @get('sites').lookupAndCacheSites()

`export default SitesRoute`
