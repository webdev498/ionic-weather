`import Ember from 'ember'`

SitesService = Ember.Service.extend
  config: Ember.computed -> @container.lookupFactory('config:environment')

  locations: Ember.inject.service('locations')

  settings: Ember.inject.service('applicationSettings')

  store: Ember.inject.service('store')

  lookupSites: (options = {}) ->
    page = options.page or 1
    perPage = options.perPage or @get('config.sitesPageSize')

    params = {
      page: page
      perPage: perPage
    }

    switch @get('settings').getSetting('sites-sort-method')
      when 'proximity'
        here = @get('locations').getCurrentLocation()
        Ember.merge(params, lat: here.latitude, lng: here.longitude)

    @get('store').find('site', params)

`export default SitesService`
