`import Ember from 'ember'`

SitesService = Ember.Service.extend
  config: Ember.computed -> @container.lookupFactory('config:environment')

  locations: Ember.inject.service('locations')

  settings: Ember.inject.service('applicationSettings')

  store: Ember.inject.service('store')

  lookupAndCacheSites: (options) ->
    @lookupSites(options).then (sites) ->
      window.SlnMobileEmber.set('cachedSites', sites)
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
      self.get('store').find('site', params)

    promise = new Ember.RSVP.Promise (resolve, reject) ->
      switch self.get('settings').getSetting('sites-sort-method')
        when 'proximity'
          self.get('locations').getCurrentLocation().then (coords) ->
            Ember.merge(params, lat: coords.latitude, lng: coords.longitude)
            resolve(doLookup())
        else
          resolve(doLookup())

    return promise

`export default SitesService`
