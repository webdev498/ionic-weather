var EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function(defaults) {

  var supportedMobilePlatforms = ['android', 'ios'];
  var mobilePlatform = process.env.MOBILE_PLATFORM;

  var options = defaults;

  if (mobilePlatform) {
    if (supportedMobilePlatforms.indexOf(mobilePlatform) < 0) {
      console.warn('Unknown mobile platform: ' + mobilePlatform);
    } else {
      options['ember-cli-ratchet'] = {
        'theme': mobilePlatform.toLowerCase()
      };
    }
  }

  var app = new EmberApp(options);

  // Use `app.import` to add additional libraries to the generated
  // output files.
  //
  // If you need to use different assets in different
  // environments, specify an object as the first parameter. That
  // object's keys should be the environment name and the values
  // should be the asset to use in that environment.
  //
  // If the library that you are including contains AMD or ES6
  // modules that you would like to import into your application
  // please specify an object with the list of modules as keys
  // along with the exports of each module as its value.

  app.import('vendor/crypto-js/hmac-sha256.js')
  app.import('vendor/crypto-js/enc-base64.js')

  app.import('bower_components/xpull/xpull.js')

  return app.toTree();
};

