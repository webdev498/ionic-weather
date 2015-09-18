`import Ember from 'ember'`
`import promisedProperty from '../util/promised-property'`

SitesController = Ember.Controller.extend
  settings: Ember.inject.service('applicationSettings')

  sites: Ember.inject.service('sites')

  application: Ember.inject.controller('application')

  nextPageToLoad: 2

  isOptionsMenuOpen: false

  isSortOptionsOpen: false

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

    self = this
    callback = ->
      self.set('isSearchApplied', false)
    @send('refreshData', callback) if wasSearchDisabled

  appVersion: Ember.computed promisedProperty(null, ->
    if cordova?
      cordova.getAppVersion.getVersionCode()
    else
      Ember.RSVP.Promise.resolve(null)
  )

  init: ->
    defaultSortMethod = @get('settings').getSetting('sites-sort-method')
    @set('sortMethod', defaultSortMethod)

  actions:
    goToSite: (site) ->
      if site.get('controllersCount') is 1
        @transitionToRoute('loading')
        self = this
        site.get('smartlinkControllers').then (controllers) ->
          self.transitionToRoute('smartlink-controller', controllers.get('firstObject'))
      else
        @transitionToRoute('site.index', site)

    toggleSearch: ->
      @toggleProperty('isSearchEnabled')
      return false

    performSearch: ->
      @set('lastSearch', @get('search'))
      @set('isSearchApplied', true)
      @send('refreshData')

    refreshData: (callback) ->
      self = this
      @set 'isLoading', true

      @store.unloadAll('zone')
      @store.unloadAll('program')
      @store.unloadAll('fault')
      @store.unloadAll('smartlink-controller')
      @store.unloadAll('site')

      options = {}
      options.search = @get('search') if @get('isSearchEnabled')

      retries = 0
      maxRetries = 3

      doRefresh = ->
        self.get('sites').lookupAndCacheSites(options).then (sites) ->
          self.set('model', sites)

      doRefresh().catch (error) ->
        retries += 1
        Ember.Logger.debug 'Refresh sites failed, trying again without geolocation'
        self.get('settings').changeSetting('sites-sort-method', 'alpha')
        self.set('sortMethod', 'alpha')
        self.set('geolocationUnavailable', true)
        if retries <= maxRetries
          doRefresh()
        else
          throw new Error("Too many retries (#{retries}) for `refreshData` action, giving up")
      .finally ->
        self.set('isLoading', false)
        callback() if Ember.typeOf(callback) is 'function'

      @set('nextPageToLoad', 2)

    loadMoreSites: ->
      return if @get 'isLoading'

      self = this
      @set 'isLoading', true

      @get('sites').lookupSites(page: @get('nextPageToLoad'))
        .then (moreSites) ->
          self.incrementProperty('nextPageToLoad')

          moreSites.forEach (site) ->
            self.get('model').pushObject(site)
        .finally ->
          self.set 'isLoading', false

    openOptionsMenu: ->
      @set('isOptionsMenuOpen', true)

    logOut: ->
      @send('closeAllMenus')
      @get('application').send('logOut')

    syncSites: ->
      @send('closeAllMenus')
      @send('refreshData')

    closeOptionsMenu: ->
      @send('closeAllMenus')

    openSortOptions: ->
      if @get('geolocationUnavailable')
        Ember.Logger.debug 'Geolocation search is not available, not showing sort options'
      else
        @set('isSortOptionsOpen', true)

    closeSortOptions: ->
      @send('closeAllMenus')

    closeAllMenus: ->
      @set('isOptionsMenuOpen', false)
      @set('isSortOptionsOpen', false)

    setSortMethod: (sortMethod) ->
      @set('sortMethod', sortMethod)
      @send('closeSortOptions')

    sendFeedback: ->
      @send('openLink', 'mailto:feedback@smartlinknetwork.com?subject=Mobile App Feedback')

    launchFullSite: ->
      @send('openLink', 'http://my.smartlinknetwork.com/users/sign_in')

`export default SitesController`
