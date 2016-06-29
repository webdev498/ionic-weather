`import Ember from 'ember'`
`import leftPad from '../util/strings/left-pad'`

formatTime = (params, options) ->
	time = params[0]
	type = params[1]

	if type is '12H'
		timeArr = time.split ':'
		hour = Number(timeArr[0])
		min = Number(timeArr[1])

		prepand = if hour >= 12 then ' PM ' else ' AM '
		prepand = if hour == 0 then ' AM ' else prepand

		hour = if hour > 12 then hour - 12 else hour
		hour = leftPad(2, hour)
		min = leftPad(2, min)
		hour + ':' + min + prepand

FormatTimeHelper = Ember.HTMLBars.makeBoundHelper formatTime

`export { formatTime }`

`export default FormatTimeHelper`
