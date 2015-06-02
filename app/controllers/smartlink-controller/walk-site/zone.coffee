`import Ember from 'ember'`
`import ManualRunMixin from '../../../mixins/manual-run'`

SmartlinkControllerWalkSiteZoneController = Ember.Controller.extend ManualRunMixin,
  isOptionsMenuOpen: false

  isPreviousZoneAvailable: Ember.computed 'model.number', ->
    "#{@get('model.number')}" != '1'

  isNextZoneAvailable: Ember.computed 'model.number', ->
    +@get('model.number') < @get('model').get('smartlinkController.zones.length')

  actions:
    openOptionsMenu: ->
      @set('isOptionsMenuOpen', true)

    closeOptionsMenu: ->
      @set('isOptionsMenuOpen', false)

    goToNextZone: ->
      nextZoneNumber = +@get('model.number') + 1
      nextZone = @get('model.smartlinkController.zones').findBy('number', nextZoneNumber)
      @set('transition', 'toLeft')
      @transitionToRoute('smartlink-controller.walk-site.zone', nextZone)

    goToPreviousZone: ->
      prevZoneNumber = +@get('model.number') - 1
      prevZone = @get('model.smartlinkController.zones').findBy('number', prevZoneNumber)
      @set('transition', 'toRight')
      @transitionToRoute('smartlink-controller.walk-site.zone', prevZone)

    start: ->
      self = this
      params = {
        run_action: 'next_zone'
        zone: @get('model.number')
      }
      @get('loadingModal').send('open')
      Ember.RSVP.all([
        @submitManualRun(params),
        self.get('smartlinkController.instructions').reload()
      ]).then (response) ->
        Ember.Logger.debug "Posted run-zone command for \
          controller #{self.get('model.smartlinkController.id')}, \
          zone number: #{self.get('model.number')}"
        self.get('loadingModal').send('loadInstruction', response[0])


    stop: ->
      self = this
      params = {
        run_action: 'manual_stop_program'
      }
      Ember.RSVP.all([
        @submitManualRun(params)
        self.get('smartlinkController.instructions').reload()
      ]).then (response) ->
        Ember.Logger.debug "Manual stop complete for controller #{self.get('model.smartlinkController.id')}"
        self.get('loadingModal').send('loadInstruction', response[0])

    openCommLog: ->
      @get('commLog').send('open')

    commLogClosed: ->
      @send('closeOptionsMenu')

    loadingFinished: ->
      Ember.run.later this, ->
        @get('loadingModal').send('close')
      , 500

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
