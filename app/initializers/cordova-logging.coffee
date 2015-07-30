`import Ember from 'ember'`
`import CurrentUserMixin from '../mixins/current-user'`
`import config from '../config/environment'`

LOGGING = null

Logging = Ember.Object.extend CurrentUserMixin,
  defaultLogLevel: 'INFO',

  logPushIntervalSeconds: 10

  logQueue: [],

  pushLogs: ->
    q = LOGGING.get('logQueue')
    if q.length
      url = LOGGING.get('config.remoteLogging.url')
      Ember.$.ajax(url, {
        contentType: 'application/json',
        type: 'POST',
        data: JSON.stringify({ logs: q  }),
        beforeSend: (xhr) ->
          username = LOGGING.get('config.remoteLogging.username')
          password = LOGGING.get('config.remoteLogging.password')
          auth = btoa("#{username}:#{password}")
          xhr.setRequestHeader('Authorization', "Basic #{auth}")
      }).done ->
        q.clear()
    else
      console.log('No logs, nothing to push')

  logRemote: (level, message) ->
    @logQueue.push({
      lvl: level.toUpperCase(),
      msg: message,
      mdl: window.device? && window.device.model,
      pltfrm: window.device? && window.device.platform,
      uuid: window.device? && window.device.uuid,
      vers: window.device? && window.device.version,
      dev: window.device? && window.device.name,
      u: LOGGING.get('session.secure.userInfo.result.user.email'),
      t: moment.utc().unix()
    })

  startLogPusher: ->
    seconds = @get('logPushIntervalSeconds')
    console.log("Starting log pusher, will run every #{seconds} seconds")
    setInterval(@pushLogs, 1000 * seconds)

  setupCordovaLogging: ->
    defaultLogLevel = LOGGING.get('defaultLogLevel')

    Ember.Logger.log = (msg) ->
      LOGGING.logRemote(defaultLogLevel, msg)
      console.log("[#{defaultLogLevel}] #{msg}")

    Ember.Logger.info = (msg) ->
      LOGGING.logRemote('INFO', msg)
      console.log("[INFO] #{msg}")

    Ember.Logger.debug = (msg) ->
      LOGGING.logRemote('DEBUG', msg)
      console.log("[DEBUG] #{msg}")

    Ember.Logger.warn = (msg) ->
      LOGGING.logRemote('WARN', msg)
      console.log("[WARN] #{msg}")

    Ember.Logger.error = (msg) ->
      LOGGING.logRemote('ERROR', msg)
      console.log("[ERROR] #{msg}")

    @startLogPusher() if config.remoteLogging

initialize = (container, _app) ->
  return unless console?

  return if (typeof(window.cordova) is 'undefined')

  LOGGING = Logging.create({
    container: container,
    config: config
  })
  LOGGING.setupCordovaLogging()

CordovaLoggingInitializer =
  name: 'cordova-logging'
  initialize: initialize

`export {initialize}`
`export default CordovaLoggingInitializer`
