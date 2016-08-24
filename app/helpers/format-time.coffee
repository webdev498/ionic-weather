`import Ember from 'ember'`
`import formatTimeFn from '../util/time-formatter'`

formatTime = (params, options) ->
  formatTimeFn(params[0], format: params[1])

FormatTimeHelper = Ember.Helper.helper(formatTime)

`export { formatTime }`

`export default FormatTimeHelper`
