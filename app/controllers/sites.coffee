`import Ember from 'ember'`

SitesController = Ember.Controller.extend
  config: Ember.computed -> @container.lookupFactory('config:environment')

  nextPageToLoad: 2

  # TODO: check if sites loaded >= total sites
  moreSitesAvailable: true

  actions:
    loadMoreSites: ->
      return if @get 'isLoading'

      controller = this
      @set 'isLoading', true

      @store.find 'site', page: @get('nextPageToLoad'), perPage: @get('config.sitesPageSize')
        .then (moreSites) ->
          controller.incrementProperty('nextPageToLoad')

          moreSites.forEach (site) ->
            controller.get('model').pushObject(site)
        .finally ->
          controller.set 'isLoading', false

`export default SitesController`
