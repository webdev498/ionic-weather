`import Ember from 'ember'`
`import ManualRunMixin from '../../../mixins/manual-run'`
`import Base from 'ember-simple-auth/authenticators/base'`
`import AuthenticationMixin from '../../../mixins/authentication'`
`import AjaxMixin from '../../../mixins/ajax'`
`import config from '../../../config/environment'`

SmartlinkControllerWalkSiteZoneController = Ember.Controller.extend ManualRunMixin, AjaxMixin,

  session: Ember.inject.service()

  init: ->
    self = this

    $('body').change '#image-upload-input', (e) ->
      self.send('saveZoneImage')
      e.preventDefault();
      e.stopPropagation();
      return


    ############ SPRINKLER SETTINGS ################
    availSprinklers = [
      {
        label: 'Standard (non-ET)'
        value: 0
      },
      {
        label: 'Off'
        value: 1
      },
      {
        label: 'Spray (1.5")'
        value: 2
      },
      {
        label: 'Rotor (0.5")'
        value: 3
      },
      {
        label: 'Drip (1.1")'
        value: 4
      },
      {
        label: 'Bubbler (2.3")'
        value: 5
      }
    ]

    sprinklerIndex = 20
    while sprinklerIndex < 211
      if sprinklerIndex > 200
        remainder = sprinklerIndex - 200
        availSprinklers.push {
          label: ((200 + remainder * 10) * 0.01).toFixed(2).toString() + '"'
          value: 200 + remainder * 10
        }
      else
        availSprinklers.push {
          label: (sprinklerIndex * 0.01).toFixed(2).toString() + '"'
          value: sprinklerIndex
        }

      sprinklerIndex++

    @set('availableSprinklerTypes', availSprinklers)

    ############ SOIL SLOPE SETTINGS ################
    availSlopes = [0..25].map (num) ->
      {
        label: num + "°"
        value: num
      }

    @set('availableSoilSlopes', availSlopes)

    ############ SOIL TYPE SETTINGS ################
    availSoils = [{
        label: 'Sand'
        value: 0
      },
      {
        label: 'Loam'
        value: 1
      },
      {
        label: 'Clay'
        value: 2
      }]

    @set('availableSoilTypes', availSoils)

    ############ PLANT TYPE SETTINGS ################
    availPlants = [
      {
        label: 'CTURF'
        value: 0
      },
      {
        label: 'WTURF'
        value: 1
      },
      {
        label: 'Shrubs'
        value: 2
      },
      {
        label: 'Annuals'
        value: 3
      },
      {
        label: 'Trees'
        value: 4
      },
      {
        label: 'Native'
        value: 5
      }
    ]

    plantTypeIndex = 10
    while plantTypeIndex < 121
      if plantTypeIndex > 100
        remainder = plantTypeIndex - 100
        availPlants.push {
          label: 100 + remainder * 10 + "%"
          value: 100 + remainder * 10
        }
      else
        availPlants.push {
          label: plantTypeIndex + '%'
          value: plantTypeIndex
        }

      plantTypeIndex++

    @set('availablePlantTypes', availPlants)

    ############ MORE LESS SETTINGS ################
    availMoreLess = [0..75].map (num) ->
        {
          label: (num - 50) + '%'
          value: num - 50
        }

    @set('availableMoreLess', availMoreLess)

  isOptionsMenuOpen: false
  isAutoAdjustMenuOpen: false
  isZoneImageViewOpen: false

  activeZones: Ember.computed('model.smartlinkController.zones.@each.active', ->
    @get('model.smartlinkController.zones')
      .filterBy('active', true)
      .sortBy('number')
  )

  isPreviousZoneAvailable: Ember.computed 'model.number', ->
    !!@getPreviousZone()

  isNextZoneAvailable: Ember.computed 'model.number', ->
    !!@getNextZone()

  getNextZone: ->
    zones = @get('activeZones')
    thisZoneIndex = zones.indexOf(@get('model'))
    zones[thisZoneIndex + 1]

  getPreviousZone: ->
    zones = @get('activeZones')
    thisZoneIndex = zones.indexOf(@get('model'))
    zones[thisZoneIndex - 1]

  actions:
    saveZoneImage: ->
      self = this
      self.set('isLoading', true)

      zone = @get('model')
      zoneNumber = @get('model.number')
      controllerId = @get('model.smartlinkController.id')
      zoneId = @get('model.smartlinkController.zones').findBy('number', zoneNumber).id
      file = Ember.$('#image-upload-input').get(0).files[0]

      api_url = "#{config.apiUrl}/api/v2/controllers/#{controllerId}/zones/#{zoneId}/photo"

      formData = new FormData(document.querySelector("form"))

      uploadZoneImage = (url, form_data) ->
        new Promise((resolve, reject) ->
          xhr = new XMLHttpRequest
          handler = ->
            if @readyState == @DONE
              if @status == 201
                formData = null
                resolve @response
              else
                reject new Error('getJSON: `' + url + '` failed with status: [' + @status + ']')
            return
          xhr.open 'POST', api_url
          xhr.onreadystatechange = handler
          email = self.get('session.data.authenticated.email')
          password = self.get('session.data.authenticated.password')
          auth = btoa("#{email}:#{password}")
          xhr.setRequestHeader("Authorization", "Basic #{auth}")
          xhr.send(form_data)
          return
      )
      return unless !!Ember.$('#image-upload-input').val()

      uploadZoneImage(api_url, formData).then ->
        reader = new FileReader()
        self.set('_uploadedZoneImage', true)
        reader.onload = (e) ->
          if self.get('model.id') == zoneId
            self.set('model.photo', e.target.result)
            self.set('model.photoThumbnail', e.target.result)
            self.set('isZoneImageViewOpen', true)
            self.set('isLoading', false)
          else
            oldZone = self.get('model.smartlinkController.zones').findBy('number', zoneNumber)
            oldZone.set('photo', e.target.result)
            oldZone.set('photoThumbnail', e.target.result)
        reader.readAsDataURL(file)
        self.set('isLoading', false)

    openOptionsMenu: ->
      @set('isOptionsMenuOpen', true)

    closeOptionsMenu: ->
      @set('isOptionsMenuOpen', false)

    openAutoAdjustMenu: ->
      @set('isAutoAdjustMenuOpen', true)
      return false

    closeAutoAdjustMenu: ->
      @set('isAutoAdjustMenuOpen', false)

    openZoneImageView: ->
      @set('isZoneImageViewOpen', true)

    closeZoneImageView: ->
      if @get('_uploadedZoneImage')
        # bad hack :(
        # if we've just uploaded a new image, force a refresh
        # to make sure image orientation is correct.
        # See: http://stackoverflow.com/questions/19463126/how-to-draw-photo-with-correct-orientation-in-canvas-after-capture-photo-by-usin
        # for a more correct solution we can implement some day.
        window.location.reload()
      else
        @set('isZoneImageViewOpen', false)

    goToNextZone: ->
      @set('isLoading', false)
      @set('isAutoAdjustMenuOpen', false)
      @set('transition', 'toLeft')
      @transitionToRoute('smartlink-controller.walk-site.zone', this.getNextZone())

    goToPreviousZone: ->
      @set('isLoading', false)
      @set('isAutoAdjustMenuOpen', false)
      @set('transition', 'toRight')
      @transitionToRoute('smartlink-controller.walk-site.zone', this.getPreviousZone())

    start: ->
      self = this
      params = {
        run_action: 'next_zone'
        zone: @get('model.number')
      }
      @get('loadingModal').send('open')
      @submitManualRun(params).then (instruction) ->
        Ember.Logger.debug "Posted run-zone command for \
          controller #{self.get('model.smartlinkController.id')}, \
          zone number: #{self.get('model.number')}"
        self.get('loadingModal').send('loadInstruction', instruction)
      .catch (error) ->
        Ember.Logger.error(error)
        alert error
        self.get('loadingModal').send('close')

    stop: ->
      self = this
      params = {
        run_action: 'manual_stop_program'
      }
      @get('loadingModal').send('open')
      @submitManualRun(params).then (instruction) ->
        Ember.Logger.debug "Manual stop complete for controller #{self.get('model.smartlinkController.id')}"
        self.get('loadingModal').send('loadInstruction', instruction)
      .catch (error) ->
        Ember.Logger.error(error)
        alert error
        self.get('loadingModal').send('close')

    openAutoAdjust: ->
      this.set('isAutoAdjustMenuOpen', true)
      return false

    saveAutoAdjust: ->
      self = this

      zoneNumber = @get('model.number')
      controllerId = @get('model.smartlinkController.id')
      zoneId = @get('model.smartlinkController.zones').findBy('number', zoneNumber).id

      url = "#{config.apiUrl}/api/v2/controllers/#{controllerId}/zones/#{zoneId}"

      queryParams = {
        timestamp: new Date().getTime(),
        zone: {
          adjustment: self.get('model.adjustment'),
          description: self.get('model.description'),
          sprinkler_type: self.get('model.sprinklerType'),
          plant_type: self.get('model.plantType'),
          soil_type: self.get('model.soilType'),
          soil_slope: self.get('model.soilSlope')
        }
      }

      new Ember.RSVP.Promise (resolve, reject) ->
        self.ajax(url,
          type: 'PUT',
          data: queryParams
          success: (response) ->
            self.set('isAutoAdjustMenuOpen', false)
            self.set('isLoading', false)
          error: (xhr, status, error) ->
            self.set('isAutoAdjustMenuOpen', false)
            self.set('isLoading', false)
            Ember.Logger.debug status
            Ember.Logger.debug error
        )

    closeAutoAdjust: ->
      @set('isAutoAdjustMenuOpen', false)

    openCommLog: ->
      @get('commLog').send('open')

    commLogClosed: ->
      @send('closeOptionsMenu')

    loadingFinished: ->
      Ember.run.later this, ->
        @get('loadingModal').send('close')
      , 750

    loadingAbandoned: ->
      @get('loadingModal').send('close')

    openJumpToZone: ->
      @set('isJumpToZoneOpen', true)

    closeJumpToZone: ->
      @set('isJumpToZoneOpen', false)

    jumpToZone: (zone) ->
      @send('closeJumpToZone')
      # Delay to let the close modal animation finish
      Ember.run.later this, ->
        if @get('model.number') >= zone.get('number')
          @set('transition', 'toRight')
        else
          @set('transition', 'toLeft')
        @transitionToRoute('smartlink-controller.walk-site.zone', zone)
      , 250

`export default SmartlinkControllerWalkSiteZoneController`
