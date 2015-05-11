`import Ember from 'ember'`
`import SitesLookupMixin from '../mixins/sites-lookup'`

SitesController = Ember.Controller.extend SitesLookupMixin,
  needs: ['application']

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

      @lookupSites()
        .then (sites) ->
          window.SlnMobileEmber.set('cachedSites', sites)
          controller.set('model', sites)
        .finally -> controller.set('isLoading', false)

      @set('nextPageToLoad', 2)

    loadMoreSites: ->
      return if @get 'isLoading'

      controller = this
      @set 'isLoading', true

      @lookupSites(page: @get('nextPageToLoad'))
        .then (moreSites) ->
          controller.incrementProperty('nextPageToLoad')

          moreSites.forEach (site) ->
            controller.get('model').pushObject(site)
        .finally ->
          controller.set 'isLoading', false

`export default SitesController`
