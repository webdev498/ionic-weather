`import Ember from 'ember'`

SitesController = Ember.Controller.extend
  needs: ['application']

  config: Ember.computed -> @container.lookupFactory('config:environment')

  nextPageToLoad: 2

  moreSitesAvailable: Ember.computed 'totalSitesCount', 'model.length', ->
    @get('totalSitesCount') > @get('model.length')

  totalSitesCount: Ember.computed ->
    @store.metadataFor('site').found

  actions:
    refreshData: ->
      controller = this
      @set 'isLoading', true

      @store.unloadAll('zone')
      @store.unloadAll('program')
      @store.unloadAll('fault')
      @store.unloadAll('smartlink-controller')
      @store.unloadAll('site')

      pageSize = @get('config.sitesPageSize')
      @store.find('site', page: 1, perPage: pageSize)
        .then (sites) ->
          window.SlnMobileEmber.set('cachedSites', sites)
          controller.set('model', sites)
        .finally -> controller.set('isLoading', false)

      @set('nextPageToLoad', 2)

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
