`import Ember from 'ember'`

initialize = (_container, _app) ->
  return unless console?

  return if (typeof(window.cordova) is 'undefined')

  Ember.Logger.log = ->
    console.log("[LOG] #{arguments[0]}")

  Ember.Logger.info = ->
    console.log("[INFO] #{arguments[0]}")

  Ember.Logger.debug = ->
    console.log("[DEBUG] #{arguments[0]}")

  Ember.Logger.warn = ->
    console.log("[WARN] #{arguments[0]}")

  Ember.Logger.error = ->
    console.log("[ERROR] #{arguments[0]}")

CordovaLoggingInitializer =
  name: 'cordova-logging'
  initialize: initialize

`export {initialize}`
`export default CordovaLoggingInitializer`
