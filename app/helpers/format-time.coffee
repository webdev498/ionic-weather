`import Ember from 'ember'`
`import leftPad from '../util/strings/left-pad'`

formatTime = (params, options) ->
  time = params[0]
  format = params[1] || 'h:mm a'
  moment("1990-01-01T#{time}").format(format)

FormatTimeHelper = Ember.HTMLBars.makeBoundHelper formatTime

`export { formatTime }`

`export default FormatTimeHelper`
