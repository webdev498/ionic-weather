`import Ember from 'ember'`
`import RatchetToggle from '../mixins/ratchet-toggle'`

EditZoneMasterValveComponent = Ember.Component.extend(RatchetToggle,
  tagName: 'li'

  classNames: ['table-view-cell']

  toggleId1: Ember.computed 'zone.id', ->
    "toggle-mv-1-zone-#{@get('zone.id')}"

  toggleId2: Ember.computed 'zone.id', ->
    "toggle-mv-2-zone-#{@get('zone.id')}"

  isToggle1Active: Ember.computed 'zone.mvEnabled', ->
    !!@get('zone.mvEnabled')

  isToggle2Active: Ember.computed 'zone.mv2Enabled', ->
    !!@get('zone.mv2Enabled')

  didInsertElement: ->
    this._super()
    self = this
    @setupRatchetToggles()
    @bindToggleProperty("##{@get('toggleId1')}", "zone.mvEnabled")
    @bindToggleProperty("##{@get('toggleId2')}", "zone.mv2Enabled")

    @$(".toggle-zone").each ->
      this.addEventListener 'toggle', (event) ->
        self.sendAction 'save'
)

`export default EditZoneMasterValveComponent`
