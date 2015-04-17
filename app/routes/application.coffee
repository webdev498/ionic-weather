`import Ember from 'ember';`

ApplicationRoute = Ember.Route.extend
  actions:
    back: ->
      history.back()
    openLink: (url) ->
      window.open url, '_system'

`export default ApplicationRoute`
