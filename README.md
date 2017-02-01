# SLN Mobile App

This is a [Cordova](https://cordova.apache.org/) app that uses [Ember.js](http://emberjs.com/)

We use [ember-cli-cordova](https://github.com/poetic/ember-cli-cordova) to help with the ember/cordova integration.

## Dependencies

Download Node.js with NPM. 

https://nodejs.org/en/

Make sure the correct version of Ember is installed onto your machine. In our case, we're using 2.7.1:

    npm install -g ember-cli@2.7

### Cordova

    npm install -g cordova

## Running locally

To initialize the cordova project, run:

    ember cordova:prepare

To run a local web server so you can view the pages in a browser, run:

    EMBER_CLI_CORDOVA=0 ember serve -p 4200 --environment=staging

And visit `http://localhost:4200` in your browser.


### To build for ios

Run:

    EMBER_ENV=staging bin/ios

This will create (or re-create) an XCode project from which you can create and deploy application archives.  To create an archive and send it to the app store, select "iOS Device" as the target device and run Product -> Archive and the publish to app store.  Be sure to bump up the app's version number first or the app store won't accept the build (e.g. 2.0.6 -> 2.0.7)


### To build for android

Run:

    EMBER_ENV=staging bin/android

You may need to accept all license agreements. If so do this by entering in the following code in your terminal:

    echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" >             "$ANDROID_HOME/licenses/android-sdk-license"

That will produce `smartlink.apk` in the root project directory which you can upload to the google play store.

### Versioning

Whenever a build is run for android or ios, the build script automatically increments the version number appropriately for the specific platform. See these files:

    cordova/ios-last-build-version
    cordova/android-last-build-version


### i18n

We use [ember-i18n](https://github.com/jamesarosen/ember-i18n). See the file `app/locales/en/translations.js`

    common: {
      search: "Search"
    },
    sites: {
      yourSites: "Your Sites hi"
    },
    smartlinkController: {
      clearFaults: "Clear Faults"
    },
    // ...

When adding translations, try to organize the top-level keys roughly one for each page in the app. Use the key `common` for miscellaneous strings that are shared throughout the app, or any that don't make sense anywhere else.