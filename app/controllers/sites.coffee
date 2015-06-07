`import Ember from 'ember'`

SitesController = Ember.Controller.extend
  settings: Ember.inject.service('applicationSettings')

  sites: Ember.inject.service('sites')

  application: Ember.inject.controller('application')

  nextPageToLoad: 2

  openOptionsMenu: false

  openSortOptions: false

  isGeolocationRestricted: false

  searchIcon: Ember.computed 'isSearchEnabled', ->
    if @get('isSearchEnabled')
      'icon-close'
    else
      'icon-search'

  isSortByProximity: Ember.computed 'sortMethod', ->
    @get('sortMethod') is 'proximity'

  isSortByAlpha: Ember.computed 'sortMethod', ->
    @get('sortMethod') is 'alpha'

  moreSitesAvailable: Ember.computed 'model.length', ->
    totalSitesCount = @store.metadataFor('site').found
    totalSitesCount > @get('model.length')

  shouldShowLoading: Ember.computed 'moreSitesAvailable', 'isLoading', 'isSearchApplied', ->
    isReloadingAfterSearch = (@get('isSearchApplied') and @get('isLoading'))
    @get('moreSitesAvailable') or isReloadingAfterSearch


  sortMethodDidChange: Ember.observer 'sortMethod', ->
    newSortMethod = @get('sortMethod')
    @get('settings').changeSetting('sites-sort-method', newSortMethod)
    @send('refreshData')

  isSearchApplied: false

  isSearchEmpty: Ember.computed 'search.length', ->
    not @get('search.length')

  isSearchEnabledDidChange: Ember.observer 'isSearchEnabled', ->
    # when closing the search, refresh the data
    # if there was anything in the search field

    return unless @get('isSearchApplied')
    wasSearchDisabled = not @get('isSearchEnabled')

    controller = this
    callback = ->
      controller.set('isSearchApplied', false)
    @send('refreshData', callback) if wasSearchDisabled

  init: ->
    defaultSortMethod = @get('settings').getSetting('sites-sort-method')
    @set('sortMethod', defaultSortMethod)

  actions:
    toggleSearch: ->
      @toggleProperty('isSearchEnabled')
      return false

    performSearch: ->
      @set('lastSearch', @get('search'))
      @set('isSearchApplied', true)
      @send('refreshData')

    refreshData: (callback) ->
      controller = this
      @set 'isLoading', true

      @store.unloadAll('zone')
      @store.unloadAll('program')
      @store.unloadAll('fault')
      @store.unloadAll('smartlink-controller')
      @store.unloadAll('site')

      options = {}
      options.search = @get('search') if @get('isSearchEnabled')

      @get('sites').lookupAndCacheSites(options)
        .then (sites) ->
          controller.set('model', sites)
        .finally ->
          controller.set('isLoading', false)
          callback() if Ember.typeOf(callback) is 'function'

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

    openOptionsMenu: ->
      @set('openOptionsMenu', true)

    logOut: ->
      @send('closeAllMenus')
      @get('application').send('logOut')

    syncSites: ->
      @send('closeAllMenus')
      @send('refreshData')

    closeOptionsMenu: ->
      @send('closeAllMenus')

    openSortOptions: ->
      if @get('isGeolocationRestricted')
        Ember.Logger.debug 'Geolocation search restricted, not showing sort options'
      else
        @set('openSortOptions', true)

    closeSortOptions: ->
      @send('closeAllMenus')

    closeAllMenus: ->
      @set('openOptionsMenu', false)
      @set('openSortOptions', false)

    setSortMethod: (sortMethod) ->
      @set('sortMethod', sortMethod)
      @send('closeSortOptions')

`export default SitesController`
