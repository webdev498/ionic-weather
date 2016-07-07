`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

SmartlinkControllerSettingsAutoAdjustController = Ember.Controller.extend(SmartlinkSaveMixin, {
  init: ->
    @initAvailableLatitudes()

  initAvailableLatitudes: ->
    opts = []

    [60..1].forEach( (n) ->
      lbl = n
      opts.push {label: "#{lbl}º N", value: n}
    )
    opts.push {label: "Equator", value: 0}
    [-1..-60].forEach( (n) ->
      lbl = -n
      opts.push {label: "#{lbl}º S", value: n}
    )

    @set 'availableLatitudes', opts

  saveUrl: Ember.computed 'model.id', 'baseUrl', ->
    "#{@get('baseUrl')}/api/v2/controllers/#{@get('model.id')}"

  computeLatForPostalCode: (val) ->
    if 1001 <= val <= 15000
      lat = 43
    else if 15001 <= val <= 27005
      lat = 39
    else if 27006 <= val <= 32109
      lat = 33
    else if 32110 <= val <= 34999
      lat = 28
    else if 35000 <= val <= 42999
      lat = 35
    else if 43000 <= val <= 48000
      lat = 40
    else if 48001 <= val <= 55599
      lat = 44
    else if 55600 <= val <= 59999
      lat = 46
    else if 60000 <= val <= 69999
      lat = 40
    else if 70000 <= val <= 76999
      lat = 33
    else if 77000 <= val <= 78999
      lat = 29
    else if 79000 <= val <= 79999
      lat = 33
    else if 80000 <= val <= 81999
      lat = 39
    else if 82000 <= val <= 84499
      lat = 45
    else if 84500 <= val <= 88999
      lat = 36
    else if 89000 <= val <= 96699
      lat = 37
    else if 96700 <= val <= 96999
      lat = 21
    else if 97000 <= val <= 99499
      lat = 46
    else if 99500 <= val <= 99699
      lat = 58
    else if 99700 <= val <= 99799
      lat = 67
    else if 99800 <= val <= 99999
      lat = 57

  postalElementChanged: Ember.observer 'model.postalCode', ->
    return unless @get('model')
    val = @get('model.postalCode')
    if val && val.length == 5
      @set('model.latitude', @computeLatForPostalCode(val))

  actions:
    save: -> (
      @save(
        url: @get('saveUrl')
        params: {
          control: {
            postal_code: @get('model.postalCode')
            latitude: @get('model.latitude')
          }
        }
      )
    )
})

`export default SmartlinkControllerSettingsAutoAdjustController`
