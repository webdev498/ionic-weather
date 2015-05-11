`import Ember from 'ember';`
`import SitesLookupMixin from '../mixins/sites-lookup'`

ApplicationRoute = Ember.Route.extend SitesLookupMixin,
  model: ->
    sites = @lookupSites()
    window.SlnMobileEmber.set('cachedSites', sites)
    return sites

  actions:
    openLink: (url) ->
      window.open url, '_system'

`export default ApplicationRoute`
