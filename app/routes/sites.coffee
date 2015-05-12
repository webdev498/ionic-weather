`import Ember from 'ember'`

SitesRoute = Ember.Route.extend
  sites: Ember.inject.service('sites')

  model: (params) ->
    preCachedSitesList = window.SlnMobileEmber.get('cachedSites')
    return preCachedSitesList if Ember.get(preCachedSitesList, 'length')
    @get('sites').lookupSites()

`export default SitesRoute`
