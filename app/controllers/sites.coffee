`import Ember from 'ember'`

SitesController = Ember.Controller.extend
  nextPageToLoad: 2

  # TODO: check if sites loaded >= total sites
  moreSitesAvailable: true

  actions:
    loadMore: ->
      controller = this
      @set 'isLoading', true

      @store.find 'site', page: @get('nextPageToLoad'), perPage: 20
        .then (moreSites) ->
          controller.incrementProperty('nextPageToLoad')

          moreSites.forEach (site) ->
            controller.get('model').pushObject(site)
        .finally ->
          controller.set 'isLoading', false

`export default SitesController`
