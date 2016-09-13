import Ember from 'ember';

const { Logger: { debug } }  = Ember;

const initialize = function(appInstance) {
  const locations = appInstance.lookup('service:locations');

  const updateGeolocation = function() {
    return locations.lookupCurrentLocation().then(function(coords) {
      locations.setCachedLocation(coords);
      return debug(`Updated geolocation to: ${coords.latitude} ${coords.longitude}`);
    });
  };

  const startUpdateLoop = function() {
    setInterval(updateGeolocation, 1000 * 60 * 5);
    return updateGeolocation();
  };

  if (typeof window.cordova === 'undefined') {
    startUpdateLoop();
  } else {
    document.addEventListener('deviceready', startUpdateLoop, false);
    document.addEventListener('resume', updateGeolocation, false);
  }
};

const UpdateGeolocationInitializer = {
  name: 'update-geolocation',
  initialize,
};

export {initialize};

export default UpdateGeolocationInitializer;
