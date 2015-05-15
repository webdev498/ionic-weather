initialize = (_container, _app) ->
  return if typeof(window.cordova) is 'undefined'

  configureStatusBar = ->
    StatusBar.hide() unless typeof(StatusBar) is 'undefined'

  document.addEventListener('deviceready', configureStatusBar, false)


StatusBarInitializer =
  name: 'status-bar'
  initialize: initialize

`export {initialize}`
`export default StatusBarInitializer`
