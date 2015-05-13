initialize = (container, _app) ->
  locations = container.lookup('service:locations')

  updateGeolocation = ->
    locations.lookupCurrentLocation().then (coords) ->
      locations.setCachedLocation(coords)
      Ember.Logger.debug("Updated geolocation to: #{coords.latitude}, #{coords.longitude}")

  updateGeolocation()
  setInterval(updateGeolocation, 1000 * 60 * 5)

UpdateGeolocationInitializer =
  name: 'update-geolocation'
  initialize: initialize

`export {initialize}`
`export default UpdateGeolocationInitializer`
