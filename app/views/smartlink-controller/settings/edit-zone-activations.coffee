`import RatchetToggleView from '../../ratchet-toggle-view'`

SmartlinkControllerSettingsEditZoneActivationsView = RatchetToggleView.extend({
  didInsertElement: ->
    this._super()
    @setupRatchetToggles()

    view = this
    # TODO, make this a component for each zone probably,
    # for now need to make sure zones are loaded so we introduce
    # some delay
    setTimeout( ->
      Ember.Logger.debug 'Loaded EditZoneActivations view toggle listeners'
      Ember.$('.toggle-zone').each (index, el) ->
        id = Ember.$(el).data('id')
        el.addEventListener 'toggle', (event) ->
          zone = view.get('controller.model.zones').findBy('id', "#{id}")
          zone.set 'active', event.detail.isActive
    , 3000 )
})

`export default SmartlinkControllerSettingsEditZoneActivationsView;`
