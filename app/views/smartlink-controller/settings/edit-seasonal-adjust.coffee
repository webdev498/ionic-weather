`import Ember from 'ember'`

SmartlinkControllerSettingsEditSeasonalAdjustView = Ember.View.extend(
  didInsertElement: ->
    this.$('.weathermatic-select-program-row').on 'click', (event) ->
      return if $(event.target).hasClass('seasonal-adj-select')
      # http://stackoverflow.com/questions/249192/how-can-you-programmatically-tell-an-html-select-to-drop-down-for-example-due
      evt = document.createEvent('MouseEvents');
      evt.initMouseEvent('mousedown', true, true, window);
      Ember.$(this).find('select').get(0).dispatchEvent(evt);
)

`export default SmartlinkControllerSettingsEditSeasonalAdjustView`
