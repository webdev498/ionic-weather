initialize = (container, _app) ->
  locations = container.lookup('service:locations')

  updateGeolocation = ->
    locations.lookupCurrentLocation().then (coords) ->
      locations.setCachedLocation(coords)
      Ember.Logger.debug("Updated geolocation to: #{coords.latitude}, #{coords.longitude}")

  startUpdateLoop = ->
    setInterval(updateGeolocation, 1000 * 60 * 5)
    updateGeolocation()

  if typeof(window.cordova) is 'undefined'
    startUpdateLoop()
  else
    document.addEventListener('deviceready', startUpdateLoop, false)
    document.addEventListener('resume', updateGeolocation, false)

UpdateGeolocationInitializer =
  name: 'update-geolocation'
  initialize: initialize

`export {initialize}`
`export default UpdateGeolocationInitializer`
