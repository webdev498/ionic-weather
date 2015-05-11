`import Ember from 'ember'`
`import CurrentLocationMixin from './current-location'`

SitesLookupMixin = Ember.Mixin.create CurrentLocationMixin,
  config: Ember.computed -> @container.lookupFactory('config:environment')

  lookupSites: (options = {}) ->
    page = options.page or 1
    perPage = options.perPage or @get('config.sitesPageSize')

    params = {
      page: page
      perPage: perPage
    }

    switch @get('sitesLookupSortMethod')
      when 'proximity'
        here = @getCurrentLocation()
        Ember.merge(params, lat: here.latitude, lng: here.longitude)

    @store.find('site', params)

  sitesLookupSortMethod: Ember.computed ->
    # TODO: Settings model backed by local storage
    'proximity'

`export default SitesLookupMixin`
