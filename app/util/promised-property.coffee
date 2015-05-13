`import Ember from 'ember'`

#
# Lets you use a promise as a computed property.
#
# Usage:
#
#   Foo = DS.Model.extend
#     bar: promisedProperty('loading...', ->
#       new Promise (resolve) ->
#         bar = calculateBarSomehow()
#         resolve(bar)
#     ).property()
#
# Background: http://discuss.emberjs.com/t/promises-and-computed-properties/3333/22
#

promisedProperty = (initialValue, func) ->
  flightKey = '_promisedInFlight' + Ember.guidFor({})
  (k,v) ->
    return v if arguments.length > 1
    this[flightKey] ?= 0
    this[flightKey] += 1
    myNumber = this[flightKey]
    func.apply(this, [k,v]).then((result) =>
      if this[flightKey] <= myNumber
        @set(k, result)
      this[flightKey] -= 1
    )
    initialValue

`export default promisedProperty`
