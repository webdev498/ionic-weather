`import Ember from 'ember';`

ApplicationRoute = Ember.Route.extend
  config: Ember.computed -> @container.lookupFactory('config:environment')

  model: ->
    @store.find 'site', page: 1, perPage: @get('config.sitesPageSize')

  actions:
    openLink: (url) ->
      window.open url, '_system'

`export default ApplicationRoute`
