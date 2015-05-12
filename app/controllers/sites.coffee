`import Ember from 'ember'`

SitesController = Ember.Controller.extend
  settings: Ember.inject.service('applicationSettings')

  sites: Ember.inject.service('sites')

  nextPageToLoad: 2

  openSortOptions: false

  isSortByProximity: Ember.computed 'sortMethod', ->
    @get('sortMethod') is 'proximity'

  isSortByAlpha: Ember.computed 'sortMethod', ->
    @get('sortMethod') is 'alpha'

  moreSitesAvailable: Ember.computed 'totalSitesCount', 'model.length', ->
    @get('totalSitesCount') > @get('model.length')

  totalSitesCount: Ember.computed ->
    @store.metadataFor('site').found

  sortMethodDidChange: Ember.observer 'sortMethod', ->
    newSortMethod = @get('sortMethod')
    @get('settings').changeSetting('sites-sort-method', newSortMethod)
    @send('refreshData')

  init: ->
    defaultSortMethod = @get('settings').getSetting('sites-sort-method')
    @set('sortMethod', defaultSortMethod)

  actions:
    refreshData: ->
      controller = this
      @set 'isLoading', true

      @store.unloadAll('zone')
      @store.unloadAll('program')
      @store.unloadAll('fault')
      @store.unloadAll('smartlink-controller')
      @store.unloadAll('site')

      @get('sites').lookupSites()
        .then (sites) ->
          window.SlnMobileEmber.set('cachedSites', sites)
          controller.set('model', sites)
        .finally -> controller.set('isLoading', false)

      @set('nextPageToLoad', 2)

    loadMoreSites: ->
      return if @get 'isLoading'

      controller = this
      @set 'isLoading', true

      @get('sites').lookupSites(page: @get('nextPageToLoad'))
        .then (moreSites) ->
          controller.incrementProperty('nextPageToLoad')

          moreSites.forEach (site) ->
            controller.get('model').pushObject(site)
        .finally ->
          controller.set 'isLoading', false

    openSortOptions: ->
      @set('openSortOptions', true)

    closeSortOptions: ->
      @set('openSortOptions', false)

    setSortMethod: (sortMethod) ->
      @set('sortMethod', sortMethod)
      @send('closeSortOptions')

`export default SitesController`
