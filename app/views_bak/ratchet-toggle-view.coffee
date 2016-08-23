`import Ember from 'ember'`
`import RatchetToggle from '../mixins/ratchet-toggle'`

RatchetToggleView = Ember.View.extend RatchetToggle,
  didInsertElement: ->
    @setupRatchetToggles()


`export default RatchetToggleView`
