`import Ember from 'ember'`

SitesService = Ember.Service.extend
  config: Ember.computed -> @container.lookupFactory('config:environment')

  locations: Ember.inject.service('locations')

  settings: Ember.inject.service('applicationSettings')

  store: Ember.inject.service('store')

  clearCache: ->
    window.SLN_MOBILE_CACHED_SITES = null

  lookupAndCacheSites: (options) ->
    Ember.Logger.debug "SitesService lookupAndCacheSites called, returning promise"
    @lookupSites(options).then (sites) ->
      Ember.Logger.debug "SitesService lookupAndCacheSites lookupSites returned, sites count: #{sites?.length}"
      window.SLN_MOBILE_CACHED_SITES = sites
      return sites

  lookupSites: (options = {}) ->
    page = options.page or 1
    perPage = options.perPage or @get('config.sitesPageSize')

    params = {
      page: page
      perPage: perPage
    }

    params.q = options.search if options.search?

    self = this

    doLookup = ->
      self.get('store').query('site', params)

    promise = new Ember.RSVP.Promise (resolve, reject) ->
      switch self.get('settings').getSetting('sites-sort-method')
        when 'proximity'
          self.get('locations').getCurrentLocation().then (coords) ->
            Ember.merge(params, lat: coords.latitude, lng: coords.longitude)
            resolve(doLookup())
          .catch (error) ->
            Ember.Logger.error 'Proximity-based sites lookup failed due to geolocation error', error
            reject(error)
        else
          resolve(doLookup())

    return promise

`export default SitesService`
