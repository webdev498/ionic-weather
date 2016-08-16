formatTime = (time, options = {}) ->
  format = options.format || 'h:mm a'
  moment("1990-01-01T#{time}").format(format)

`export default formatTime`
