leftPad = (padLength, value, padCharacter = 0) ->
  padCharacter  = "#{padCharacter}"
  value         = "#{value}"

  return value if value.length >= padLength
  new Array(padLength - value.length + 1).join(padCharacter) + value

`export default leftPad`
