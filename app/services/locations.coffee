`import Ember from 'ember'`

get = Ember.get

LocationsService = Ember.Service.extend
  getCurrentLocation: ->
    self = this
    new Ember.RSVP.Promise (resolve, reject) ->
      cachedCoords = self.getCachedLocation()
      return resolve(cachedCoords) if cachedCoords
      self.lookupCurrentLocation().then (coords) ->
        self.setCachedLocation(coords)
        resolve(coords)
      .catch (error) ->
        reject(error)

  lookupCurrentLocation: ->
    self = this
    new Ember.RSVP.Promise (resolve, reject) ->
      onGeoSuccess = (geoposition) ->
        resolve(geoposition.coords)

      onGeoFailure = (error) ->
        reject(new Error(
          "Geolocation lookup failed, error code: #{error.code}, message: #{error.message}"))

      doGetLocation = -> navigator.geolocation.getCurrentPosition(onGeoSuccess, onGeoFailure)

      if typeof(window.cordova) is 'undefined'
        doGetLocation()
      else
        document.addEventListener('deviceready', doGetLocation, false)

  cacheKeyLatitude: 'sln-mobile-geo-cache-lat'
  cacheKeyLongitude: 'sln-mobile-geo-cache-lon'
  cacheKeyTimestamp: 'sln-mobile-geo-cache-timestamp'

  getCachedLocation: ->
    lat = localStorage.getItem(@cacheKeyLatitude)
    lon = localStorage.getItem(@cacheKeyLongitude)
    return null unless lat? and lon?
    {
      latitude: lat,
      longitude: lon
    }

  setCachedLocation: (coords) ->
    localStorage.setItem(@cacheKeyLatitude, coords.latitude)
    localStorage.setItem(@cacheKeyLongitude, coords.longitude)
    localStorage.setItem(@cacheKeyTimestamp, new Date().getTime())

  milesAway: (latitude, longitude) ->
    self = this
    new Ember.RSVP.Promise (resolve, reject) ->
      self.getCurrentLocation().then (here) ->
        metersAway = self.calculateDistanceInMeters(
          get(here, 'latitude'), latitude,
          get(here, 'longitude'), longitude
        )
        milesAway = self.metersToMiles(metersAway)
        resolve(milesAway)

  calculateDistanceInMeters: (lat1, lat2, lon1, lon2) ->
    # Haversine method for calculating distance between coordinates
    # See: http://www.movable-type.co.uk/scripts/latlong.html

    earthRadiusMeters = 6371000

    φ1 = @degreesToRadians(lat1)
    φ2 = @degreesToRadians(lat2)
    Δφ = @degreesToRadians(lat2 - lat1)
    Δλ = @degreesToRadians(lon2 - lon1)

    a = Math.pow(Math.sin(Δφ / 2), 2) +
        Math.cos(φ1) * Math.cos(φ2) *
        Math.pow(Math.sin(Δλ / 2), 2)

    c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1 - a) )

    return earthRadiusMeters * c


  degreesToRadians: (degrees) -> degrees * (Math.PI / 180)

  metersToMiles: (meters) -> meters / 1609.34

`export default LocationsService`
