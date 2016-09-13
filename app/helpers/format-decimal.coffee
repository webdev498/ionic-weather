`import Ember from 'ember'`

formatDecimal = (params, options) ->
  decimalPlaces = options.decimalPlaces || 2
  parseFloat(Math.round(params[0] * 100) / 100).toFixed(decimalPlaces)

FormatDecimalHelper = Ember.Helper.helper(formatDecimal)

`export { formatDecimal }`
`export default FormatDecimalHelper`
