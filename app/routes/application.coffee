`import Ember from 'ember';`

ApplicationRoute = Ember.Route.extend
  sites: Ember.inject.service('sites')

  model: ->
    sites = @get('sites').lookupSites()
    window.SlnMobileEmber.set('cachedSites', sites)
    return sites

  actions:
    openLink: (url) ->
      window.open url, '_system'

`export default ApplicationRoute`
