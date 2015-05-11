`import Ember from 'ember'`
`import SitesLookupMixin from '../mixins/sites-lookup'`

SitesRoute = Ember.Route.extend SitesLookupMixin,
  model: (params) ->
    preCachedSitesList = window.SlnMobileEmber.get('cachedSites')
    return preCachedSitesList if Ember.get(preCachedSitesList, 'length')
    @lookupSites()

`export default SitesRoute`
