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
        action: 'next_zone'
        zone: @get('model.number')
      }
      Ember.RSVP.all([
        @submitManualRun(params),
        self.get('smartlinkController.instructions').reload()
      ]).then ->
        self.set('isLoading', false)
        self.send('openCommLog')

    stop: ->
      self = this
      params = {
        run_action: 'manual_stop_program'
      }
      Ember.RSVP.all([
        @submitManualRun(params)
        self.get('smartlinkController.instructions').reload()
      ]).then ->
        self.set('isLoading', false)
        self.send('openCommLog')

    openCommLog: ->
      @get('commLog').send('open')

    commLogClosed: ->
      @send('closeOptionsMenu')

`export default SmartlinkControllerWalkSiteZoneController`
