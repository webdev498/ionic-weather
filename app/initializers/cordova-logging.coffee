`import Ember from 'ember'`

isCordova = ->
  not (typeof Cordova is 'undefined')

initialize = (_container, _app) ->
  return unless console?

  origLog = Ember.Logger.log
  origInfo = Ember.Logger.info
  origDebug = Ember.Logger.debug
  origWarn = Ember.Logger.warn
  origError = Ember.Logger.error

  Ember.Logger.log = ->
    if isCordova()
      console.log("[LOG] #{arguments[0]}")
    else
      origLog(arguments...)

  Ember.Logger.info = ->
    if isCordova()
      console.log("[LOG] #{arguments[0]}")
    else
      origInfo(arguments...)

  Ember.Logger.debug = ->
    if isCordova()
      console.log("[DEBUG] #{arguments[0]}")
    else
      origDebug(arguments...)

  Ember.Logger.warn = ->
    if isCordova()
      console.log("[WARN] #{arguments[0]}")
    else
      origWarn(arguments...)

  Ember.Logger.error = ->
    if isCordova()
      console.log("[ERROR] #{arguments[0]}")
    else
      origError(arguments...)

CordovaLoggingInitializer =
  name: 'cordova-logging'
  initialize: initialize

`export {initialize}`
`export default CordovaLoggingInitializer`
