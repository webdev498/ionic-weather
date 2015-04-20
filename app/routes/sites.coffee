`import Ember from 'ember'`

SitesRoute = Ember.Route.extend
  model: (params) ->
     @store.find 'site'

`export default SitesRoute`
