`import Ember from 'ember';`

ApplicationRoute = Ember.Route.extend
  model: ->
    @store.find 'site'

  actions:
    openLink: (url) ->
      window.open url, '_system'

`export default ApplicationRoute`
