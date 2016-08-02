`import RatchetToggleView from '../../ratchet-toggle-view'`

SmartlinkControllerSettingsEditControllerAdvancedView = RatchetToggleView.extend({
  didInsertElement: ->
    this._super()
    @bindToggleProperty('#weathermatic-toggle-automatically-set-time', 'controller.model.autoSetTime')
    @bindToggleProperty('#weathermatic-toggle-dst-enabled', 'controller.model.dstEnabled')
    @bindToggleProperty('#weathermatic-toggle-winterized', 'controller.model.winterized')
})

`export default SmartlinkControllerSettingsEditControllerAdvancedView`
