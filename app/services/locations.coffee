`import Ember from 'ember'`

get = Ember.get

LocationsService = Ember.Service.extend
  getCurrentLocation: ->
    # TODO: really ask the device where it's at
    # maybe fall back to ip gelocation?
    {
      latitude: '38.4495690',
      longitude: '-78.8689160'
    }

  milesAway: (latitude, longitude) ->
    here = @getCurrentLocation()
    metersAway = @calculateDistanceInMeters(
      get(here, 'latitude'), latitude,
      get(here, 'longitude'), longitude
    )
    metersAway
    @metersToMiles(metersAway)

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
