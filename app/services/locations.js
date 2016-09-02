import Ember from 'ember';

const { Logger: { debug }, get } = Ember;

const EARTH_RADIUS_METERS = 6371000;

const LocationsService = Ember.Service.extend({
  getCurrentLocation() {
    var self;
    debug("Location service getCurrentLocation, location requested, returning a promise");
    return new Ember.RSVP.Promise((resolve, reject) => {
      debug("Location service getCurrentLocation promise executing");
      const cachedCoords = this.getCachedLocation();
      if (cachedCoords) {
        debug("Location service getCurrentLocation returning cached coordinates");
      }
      if (cachedCoords) {
        return resolve(cachedCoords);
      }
      debug("Location service getCachedLocation fetching location");
      return this.lookupCurrentLocation().then((coords) => {
        debug("Location service getCachedLocation got response");
        this.setCachedLocation(coords);
        return resolve(coords);
      }).catch((error) => {
        debug('Location service getCachedLocation got error:', error);
        return reject(error);
      });
    });
  },

  lookupCurrentLocation() {
    return new Ember.RSVP.Promise((resolve, reject) => {
      const onGeoSuccess = function(geoposition) {
        return resolve(geoposition.coords);
      };
      const onGeoFailure = function(error) {
        return reject(new Error(`Geolocation lookup failed, error code: ${error.code}, message: ${error.message}`));
      };
      const doGetLocation = function() {
        return navigator.geolocation.getCurrentPosition(onGeoSuccess, onGeoFailure, {
          timeout: 10000
        });
      };
      if (typeof window.cordova === 'undefined') {
        return doGetLocation();
      } else {
        return document.addEventListener('deviceready', doGetLocation, false);
      }
    });
  },

  cacheKeyLatitude:  'sln-mobile-geo-cache-lat',
  cacheKeyLongitude: 'sln-mobile-geo-cache-lon',
  cacheKeyTimestamp: 'sln-mobile-geo-cache-timestamp',

  getCachedLocation() {
    const lat = localStorage.getItem(this.cacheKeyLatitude);
    const lon = localStorage.getItem(this.cacheKeyLongitude);
    if (lat === null || lon === null) {
      return null;
    }
    return {
      latitude:  lat,
      longitude: lon
    };
  },

  setCachedLocation(coords) {
    localStorage.setItem(this.cacheKeyLatitude, coords.latitude);
    localStorage.setItem(this.cacheKeyLongitude, coords.longitude);
    return localStorage.setItem(this.cacheKeyTimestamp, new Date().getTime());
  },

  milesAway(latitude, longitude) {
    return new Ember.RSVP.Promise((resolve, reject) => {
      return this.getCurrentLocation().then((here) => {
        const metersAway = this.calculateDistanceInMeters(
          get(here, 'latitude'), latitude,
          get(here, 'longitude'), longitude
        );
        const milesAway = this.metersToMiles(metersAway);
        return resolve(milesAway);
      });
    });
  },

  calculateDistanceInMeters(lat1, lat2, lon1, lon2) {
    const φ1 = this.degreesToRadians(lat1);
    const φ2 = this.degreesToRadians(lat2);
    const Δφ = this.degreesToRadians(lat2 - lat1);
    const Δλ = this.degreesToRadians(lon2 - lon1);
    const a = Math.pow(Math.sin(Δφ / 2), 2) + Math.cos(φ1) * Math.cos(φ2) * Math.pow(Math.sin(Δλ / 2), 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return EARTH_RADIUS_METERS * c;
  },

  degreesToRadians(degrees) {
    return degrees * (Math.PI / 180);
  },

  metersToMiles(meters) {
    return meters / 1609.34;
  },

  latitudeForPostalCode(postalCodeInput) {
    const postalCode = parseInt(postalCodeInput);
    if (1001 <= postalCode && postalCode <= 15000) {
      return 43;
    }
    if (15001 <= postalCode && postalCode <= 27005) {
      return 39;
    }
    if (27006 <= postalCode && postalCode <= 32109) {
      return 33;
    }
    if (32110 <= postalCode && postalCode <= 34999) {
      return 28;
    }
    if (35000 <= postalCode && postalCode <= 42999) {
      return 35;
    }
    if (43000 <= postalCode && postalCode <= 48000) {
      return 40;
    }
    if (48001 <= postalCode && postalCode <= 55599) {
      return 44;
    }
    if (55600 <= postalCode && postalCode <= 59999) {
      return 46;
    }
    if (60000 <= postalCode && postalCode <= 69999) {
      return 40;
    }
    if (70000 <= postalCode && postalCode <= 76999) {
      return 33;
    }
    if (77000 <= postalCode && postalCode <= 78999) {
      return 29;
    }
    if (79000 <= postalCode && postalCode <= 79999) {
      return 33;
    }
    if (80000 <= postalCode && postalCode <= 81999) {
      return 39;
    }
    if (82000 <= postalCode && postalCode <= 84499) {
      return 45;
    }
    if (84500 <= postalCode && postalCode <= 88999) {
      return 36;
    }
    if (89000 <= postalCode && postalCode <= 96699) {
      return 37;
    }
    if (96700 <= postalCode && postalCode <= 96999) {
      return 21;
    }
    if (97000 <= postalCode && postalCode <= 99499) {
      return 46;
    }
    if (99500 <= postalCode && postalCode <= 99699) {
      return 58;
    }
    if (99700 <= postalCode && postalCode <= 99799) {
      return 67;
    }
    if (99800 <= postalCode && postalCode <= 99999) {
      return 57;
    }
    return null;
  },

});

export default LocationsService;
