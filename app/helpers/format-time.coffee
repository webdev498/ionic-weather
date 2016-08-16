`import Ember from 'ember'`
`import formatTimeFn from '../util/time-formatter'`

formatTime = (params, options) ->
  formatTimeFn(params[0], format: params[1])

FormatTimeHelper = Ember.HTMLBars.makeBoundHelper formatTime

`export { formatTime }`

`export default FormatTimeHelper`
