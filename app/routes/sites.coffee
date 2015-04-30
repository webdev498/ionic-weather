`import Ember from 'ember'`

SitesRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('application')

`export default SitesRoute`
