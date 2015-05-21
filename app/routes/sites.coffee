`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SitesRoute = Ember.Route.extend AuthenticatedRouteMixin,
  sites: Ember.inject.service('sites')

  model: (params) ->
    preCachedSitesList = window.SlnMobileEmber.get('cachedSites')
    return preCachedSitesList if preCachedSitesList?
    @get('sites').lookupSites().then (sites) ->
      window.SlnMobileEmber.set('cachedSites', sites)
      return sites

`export default SitesRoute`
