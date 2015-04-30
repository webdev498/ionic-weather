`import Ember from 'ember'`

SiteRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'site', params.siteId

`export default SiteRoute`
