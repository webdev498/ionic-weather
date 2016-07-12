`import Ember from 'ember'`
`import RatchetToggle from '../mixins/ratchet-toggle'`

EditZoneComponent = Ember.Component.extend(RatchetToggle,
  tagName: 'li'

  classNames: ['table-view-cell']

  toggleId: Ember.computed 'zone.id', ->
    "toggle-zone-#{@get('zone.id')}"

  isToggleActive: Ember.computed 'field', ->
    !!@get("zone.#{@get('field')}")

  didInsertElement: ->
    this._super()
    self = this
    @set('timesRun', @get('timesRun') + 1)
    @setupRatchetToggles()
    @bindToggleProperty("##{@get('toggleId')}", "zone.#{@get('field')}")

    toggle = Ember.$("##{@get('toggleId')}")
    toggle.get(0).addEventListener 'toggle', (event) ->
      self.sendAction 'save'
)

`export default EditZoneComponent`
