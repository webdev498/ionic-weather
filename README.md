# SLN Mobile App

This is a [Cordova](https://cordova.apache.org/) app that uses [Ember.js](http://emberjs.com/)

We use [ember-cli-cordova](https://github.com/poetic/ember-cli-cordova) to help with the ember/cordova integration.

## Dependencies

Download Node.js with NPM. 

https://nodejs.org/en/

Make sure the correct version of Ember is installed onto your machine. In our case, we're using 2.7.1:

    npm install -g ember-cli@2.7

### Install Cordova

    npm install -g cordova
    
### Install Bower

    npm install -g bower
    
### Installing Remaining Dependencies

    npm install

## Running locally

To initialize the cordova project, run:

    ember cordova:prepare

To run a local web server so you can view the pages in a browser, run:

    EMBER_CLI_CORDOVA=0 ember serve -p 4200 --environment=staging

or 

    EMBER_CLI_CORDOVA=0 ember serve -p 4200 --environment=production

And visit `http://localhost:4200` in your browser.

### Login to E&C Weathermatic Account:

    elon.mitchell@weathermatic.com / Ec1986m$

### Troubleshooting: We use cordova-icon's to populate icons. Install it to your system by doing the following:

    npm install cordova-icon -g

here is the docs: https://www.npmjs.com/package/cordova-icon

### To build for ios

Run:

    EMBER_ENV=staging bin/ios
 
or 

    EMBER_ENV=production bin/ios

This will create (or re-create) an XCode project from which you can create and deploy application archives.  To create an archive and send it to the app store, select "iOS Device" as the target device and run Product -> Archive and the publish to app store.  Be sure to bump up the app's version number first or the app store won't accept the build (e.g. 2.0.6 -> 2.0.7)


### To run in emulator:

Navigate to the cordova folder in the root directory and run:

    corodova run ios or cordova run android

### To build for android

Run:

    EMBER_ENV=staging bin/android

You may need to accept all license agreements. If so do this by entering in the following code in your terminal:

    echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license"

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


#API Calls

###Inspections:

### All Inspections:  
**GET** - https://staging.smartlinknetwork.com/api/v2/controllers/:controller_id/inspections/

### Inspection General:  
**GET** - https://staging.smartlinknetwork.com/api/v2/controllers/:controller_id/inspections/:id

### Inspection Programs:     
**GET** - https://my.smartlinknetwork.com/api/v2/controllers/:controller_id/inspections/:id/snapshot

### Inspection Seasonal:   
**GET** - https://my.smartlinknetwork.com/api/v2/controllers/:controller_id/inspections/:id/snapshot

### Inspection Omit:   
**GET** - https://my.smartlinknetwork.com/api/v2/controllers/:controller_id/inspections/:id/snapshot

### Create Inspection:   
**POST** - https://my.smartlinknetwork.com/api/v2/controllers/:controller_id/inspections/:id

### Save Inspection:    
**POST** - https://staging.smartlinknetwork.com/controls/:controller_id/inspections/:id?publish=true

### Basic Edit Inspection:   
**POST** - https://staging.smartlinknetwork.com/controls/:controller_id/inspections/:id/edit