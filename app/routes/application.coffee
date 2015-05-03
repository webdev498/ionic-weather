`import Ember from 'ember';`

ApplicationRoute = Ember.Route.extend
  model: ->
    @store.find 'site', page: 1, perPage: 20

  actions:
    openLink: (url) ->
      window.open url, '_system'

`export default ApplicationRoute`
