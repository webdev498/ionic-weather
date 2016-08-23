initialize = (_container, _app) ->
  return if typeof(window.cordova) is 'undefined'

  configureStatusBar = ->
    if typeof(StatusBar) is 'undefined'
      Ember.Logger.error 'Cannot configure status bar, missing StatusBar global (cordova status bar plugin installed?)'
      return

    StatusBar.styleBlackOpaque()
    StatusBar.backgroundColorByHexString('000000')

  document.addEventListener('deviceready', configureStatusBar, false)


StatusBarInitializer =
  name: 'status-bar'
  initialize: initialize

`export {initialize}`
`export default StatusBarInitializer`
