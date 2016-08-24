`import Ember from 'ember'`

addCommas = (number) ->
  parts = number.toString().split('.')
  parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',')
  parts.join('.')

formatNumber = (params, options) ->
  return '' unless params[0]?
  number = '' + params[0]
  number = Math.round(number) if options.round
  addCommas(number)

FormatNumberHelper = Ember.Helper.helper(formatNumber)

`export { formatNumber }`

`export default FormatNumberHelper`
