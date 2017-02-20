`import Ember from 'ember'`
`import ManualRunMixin from '../../../mixins/manual-run'`
`import Base from 'ember-simple-auth/authenticators/base'`
`import AuthenticationMixin from '../../../mixins/authentication'`
`import AjaxMixin from '../../../mixins/ajax'`
`import config from '../../../config/environment'`

SmartlinkControllerEditZoneController = Ember.Controller.extend ManualRunMixin, AjaxMixin,
  $scope = this
  session: Ember.inject.service()

  init: ->
    self = this

    $('body').change '#image-upload-inputs', (e) ->
      self.send('uploadZoneImages')
      e.preventDefault();
      e.stopPropagation();
      return

  active: (zones,zoneId) ->
    zones.toArray().find((zone) -> zone.id == zoneId)

  isAutoAdjustMenuOpen: false

  actions:
    openZoneImageView: ->
      @set('showZoneImage', true)
    closeZoneImageView: ->
      @set('showZoneImage', false)
    uploadZoneImages: ->
      self = this
      reader = new FileReader()
      file = Ember.$('#image-upload-inputs').get(0).files[0]
      reader.onload = (e) ->
        currentZone = self.get('model.zones').findBy('number', $scope.zone.number)
        if currentZone.id == $scope.zone.id
          self.set('model.photo', e.target.result)
          self.set('model.photoThumbnail', e.target.result)
          self.set('isLoading', false)
        else
          oldZone = self.get('model.zones').findBy('number', $scope.zone.number)
          oldZone.set('photo', e.target.result)
          oldZone.set('photoThumbnail', e.target.result)
      reader.readAsDataURL(file)
      self.set('isLoading', false)
      StatusBar.overlaysWebView(true)
      StatusBar.overlaysWebView(false)

    saveZoneImages: ->
      self = this
      self.set('isLoading', true)
      controllerId = @get('model.smartlinkController.id')

      $scope.api_url = "#{config.apiUrl}/api/v2/controllers/#{controllerId}/zones/#{$scope.zone.id}/photo"
      $scope.formData = new FormData(document.querySelector("form"))

      uploadZonesImage = (url, form_data) ->
        new Promise((resolve, reject) ->
          xhr = new XMLHttpRequest
          handler = ->
            if @readyState == @DONE
              if @status == 201
                $scope.formData = null
                resolve @response
              else
                reject new Error('getJSON: `' + url + '` failed with status: [' + @status + ']')
            return
          xhr.open 'POST', $scope.api_url
          xhr.onreadystatechange = handler
          email = self.get('session.data.authenticated.email')
          password = self.get('session.data.authenticated.password')
          auth = btoa("#{email}:#{password}")
          activeModel = self.get("model.zones").objectAt($scope.zone.number - 1);
          Ember.set(activeModel,"photo", self.get("model.photo"));
          Ember.set(activeModel,"photoThumbnail", self.get("model.photoThumbnail"));

          xhr.setRequestHeader("Authorization", "Basic #{auth}")
          xhr.send($scope.formData)
          return
      )
      return unless !!Ember.$('#image-upload-inputs').val()

      uploadZonesImage($scope.api_url, $scope.formData)

    closeAutoAdjustMenu: ->
      @set('isAutoAdjustMenuOpen', false)

    openAutoAdjust: (zone, number, id, photo, photoThumb) ->
      $scope.zone = {}
      $scope.zone.id = id
      $scope.zone.name = zone
      $scope.zone.number = number
      $scope.zone.active = this.active(@get('model.zones'),id)
      this.set('activeNumber', number)
      this.set('activeZone', zone)
      this.set('isAutoAdjustMenuOpen', true)
      this.set('model.photo', photo)
      this.set('model.photoThumbnail', photoThumb)
      return false

    saveAutoAdjust: (zone) ->
      self = this
      controllerId = @get('model.smartlinkController.id')
      url = "#{config.apiUrl}/api/v2/controllers/#{controllerId}/zones/#{$scope.zone.id}"
      queryParams = {
        timestamp: new Date().getTime(),
        zone: {
          description: zone
        }
      }

      self.send('saveZoneImages')

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
            activeModel = self.get("model.zones").objectAt($scope.zone.number - 1);
            Ember.set(activeModel, "description", zone);
      )

    closeAutoAdjust: ->
      @set('isAutoAdjustMenuOpen', false)

    loadingFinished: ->
      Ember.run.later this, ->
        @get('loadingModal').send('close')
      , 750

    loadingAbandoned: ->
      @get('loadingModal').send('close')


`export default SmartlinkControllerEditZoneController`
