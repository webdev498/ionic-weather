`import Ember from 'ember'`

SitesRoute = Ember.Route.extend
  config: Ember.computed -> @container.lookupFactory('config:environment')

  model: (params) ->
    preCachedSitesList = window.SlnMobileEmber.get('cachedSites')
    return preCachedSitesList if Ember.get(preCachedSitesList, 'length')
    @store.find 'site', page: 1, perPage: @get('config.sitesPageSize')

`export default SitesRoute`
