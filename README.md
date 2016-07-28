# SLN Mobile App

This is a [Cordova](https://cordova.apache.org/) app that uses [Ember.js](http://emberjs.com/)

We use [ember-cli-cordova](https://github.com/poetic/ember-cli-cordova) to help with the ember/cordova integration.

## Dependencies

### Cordova

    npm install -g cordova


## Running locally

To initialize the cordova project, run:

    ember cordova:prepare




To run a local web server so you can view the pages in a browser, run:

    EMBER_CLI_CORDOVA=0 ember serve --environment=development
    
And visit `http://localhost:4200` in your browser


### To build for ios

Run:

    EMBER_ENV=staging bin/ios

This will create (or re-create) an XCode project from which you can create and deploy application archives.  To create an archive and send it to the app store, select "iOS Device" as the target device and run Product -> Archive and the publish to app store.  Be sure to bump up the app's version number first or the app store won't accept the build (e.g. 2.0.6 -> 2.0.7)


### To build for android

Run:

    EMBER_ENV=staging bin/android

That will produce `smartlink.apk` in the root project directory which you can upload to the google play store.


