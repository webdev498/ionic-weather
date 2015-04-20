`import Ember from 'ember'`

SiteRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'site', params.siteId

  serialize: (model) ->
    siteId: model.id

`export default SiteRoute`
