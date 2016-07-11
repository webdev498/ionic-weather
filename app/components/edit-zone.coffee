`import Ember from 'ember'`
`import RatchetToggle from '../mixins/ratchet-toggle'`

EditZoneComponent = Ember.Component.extend(RatchetToggle,
  tagName: 'li'

  classNames: ['table-view-cell']

  toggleId: Ember.computed 'zone.id', ->
    "toggle-zone-#{@get('zone.id')}"

  isToggleActive: Ember.computed 'field', ->
    @get("zone.#{@get('field')}")

  didInsertElement: ->
    this._super()
    @setupRatchetToggles()
    @bindToggleProperty("##{@get('toggleId')}", "zone.#{@get('field')}")
)

`export default EditZoneComponent`
