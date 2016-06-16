`import Ember from 'ember'`

SmartlinkControllerSettingsEditAutoAdjustController = Ember.Controller.extend({
  init: ->
    @initAvailableSprinklerTypes()
    @initAvailablePlantTypes()
    @initAvailableSoilTypes()
    @initSlopeValues()
    @initMoreLessValues()

  initAvailableSprinklerTypes: ->
    opts = []

    [
      { label: "Standard (non-ET)", value: 0 },
      { label: "Off", value: 1 },
      { label: "Spray (1.5\")", value: 2 },
      { label: "Rotor (0.5\")", value: 3 },
      { label: "Drip (1.1\")", value: 4 },
      { label: "Bubbler (2.3\")", value: 5 }
    ].forEach( (sprinklerType) ->
      opts.push sprinklerType
    )
    [20..199].forEach( (n) ->
      lbl = (n/100).toFixed(2)
      opts.push {label: "#{lbl}\"", value: n}
    )
    [20..30].forEach( (n) ->
      lbl = (n/10).toFixed(2)
      val = n*10
      opts.push {label: "#{lbl}\"", value: val}
    )

    @set 'availableSprinklerTypes', opts

  initAvailablePlantTypes: ->
    opts = []
    [
      { label: "CTURF", value: 0 }
      { label: "WTURF", value: 1 }
      { label: "Shrubs", value: 2 }
      { label: "Annuals", value: 3 }
      { label: "Trees", value: 4 }
      { label: "Native", value: 5 }
    ].forEach( (plantType) ->
      opts.push plantType
    )
    [10..99].forEach((n) ->
      val = n
      opts.push {
        label: "#{val}%", value: val
      }
    )
    [10..30].forEach((n) ->
      val = n*10
      lbl = n*10
      opts.push {
        label: "#{lbl}%", value: val
      }
    )
    @set 'availablePlantTypes', opts

  initAvailableSoilTypes: ->
    @set 'availableSoilTypes', [
      {label: "Sand", value: 0}
      {label: "Loam", value: 1}
      {label: "Clay", value: 2}
    ]

  initSlopeValues: ->
    opts = []
    [0..25].forEach((n) ->
      opts.push {
        label: "#{n}º", value: n
      }
    )
    @set 'slopeValues', opts

  initMoreLessValues: ->
    opts = []
    [25..-50].forEach( (n) ->
      val = n
      opts.push {
        label: "#{val}%", value: val
      }
    )
    @set 'moreLessValues', opts

  config: Ember.computed ->
    @container.lookupFactory('config:environment')

  saveUrl: Ember.computed 'model.smartlinkController.id', ->
    controllerId = @get('model.smartlinkController.id')
    zoneId = @get('model.id')
    baseUrl = @get('config.apiUrl')
    "#{baseUrl}/api/v2/controllers/#{controllerId}/zones/#{zoneId}"

  timeoutThresholdMillis: 20000

  actions:
    save: ->
      @get('loadingModal').send('open')

      self = this
      url = @get('saveUrl')

      timeoutWatcher = null
      defaultErrorMessage = 'There was a problem communicating with our servers. Please try again later'

      allParams = {
        zone: {
          soil_type: @get('model.soilType')
        }
        timestamp: new Date().getTime()
      }

      savePromise = new Ember.RSVP.Promise (resolve, reject) ->

        timeoutWatcher = Ember.run.later(this, ->
          reject new Error(defaultErrorMessage)
        self.timeoutThresholdMillis)

        ajaxOptions = {
          type: 'PATCH'
          data: allParams
          success: (response) ->
            if Ember.get(response, 'meta.success')
              self.transitionToRoute('smartlink-controller.settings.auto-adjust',
                self.get('model.smartlinkController'))
            else
              message = Ember.get(response, 'result.instruction.exception')
              reject new Error(message)
          error: ->
            reject new Error(defaultErrorMessage)
        }

        Ember.$.ajax(url, ajaxOptions)

        savePromise
        .finally ->
          Ember.run.cancel(timeoutWatcher) if timeoutWatcher

    loadingFinished: ->
      Ember.run.later this, ->
        @transitionToRoute('smartlink-controller.index')
      , 750

    loadingAbandoned: ->
      @transitionToRoute('smartlink-controller.index')

})

`export default SmartlinkControllerSettingsEditAutoAdjustController`