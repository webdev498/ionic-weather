/* jshint node: true */

var os     = require('os');
var ifaces = os.networkInterfaces();

var addresses = [];
for (var dev in ifaces) {
  ifaces[dev].forEach(function(details){
    if(details.family === 'IPv4' && details.address !== '127.0.0.1') {
      addresses.push(details.address);
    }
  });
}

addresses[0] = addresses[0] || '127.0.0.1';

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'sln-mobile-ember',
    environment: environment,
    rootURL: '/',
    defaultLocationType: 'auto',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    },

    cordova: {
      rebuildOnChange: false,
      emulate: false,
      emberUrl: 'http://' + addresses[0] + ':4200',
      liveReload: {
        enabled: false,
        platform: 'ios'
      }
    },

    contentSecurityPolicy: {
      'style-src': "'self' 'unsafe-inline'"
    },

    sitesPageSize: 20
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;

    ENV.apiUrl   = 'http://' + addresses[0] + ':3000';
    ENV.development = true;

    ENV.contentSecurityPolicy['connect-src'] = "'self' " + ENV.apiUrl;
    ENV.contentSecurityPolicy['img-src'] = "'self' data:"
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.rootURL = '/';
    ENV.locationType = 'auto';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'staging') {
    ENV.apiUrl = 'https://staging.smartlinknetwork.com';
    ENV.staging = true;
  }

  if (environment === 'beta') {
    ENV.apiUrl = 'https://my.smartlinknetwork.com';
    ENV.production = true;

    ENV.remoteLogging = {
      url: 'http://sln-mobile-logs.smartlinknetwork.com/logs',
      username: 'logsuser',
      password: 'trustno1hunter2'
    };
  }

  if (environment === 'production') {
    ENV.apiUrl = 'https://my.smartlinknetwork.com';
    ENV.production = true;
  }

  // ENV['ember-simple-auth'] = {};

  return ENV;
};
