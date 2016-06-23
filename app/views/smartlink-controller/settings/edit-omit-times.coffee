`import RatchetToggleView from '../../ratchet-toggle-view'`

SmartlinkControllerSettingsEditOmitTimesView = RatchetToggleView.extend(
  didInsertElement: ->
    this._super()
    @bindToggleProperty('#weathermatic-toggle-is-sunday-selected', 'controller.isSundaySelected')
    @bindToggleProperty('#weathermatic-toggle-is-monday-selected', 'controller.isMondaySelected')
    @bindToggleProperty('#weathermatic-toggle-is-tuesday-selected', 'controller.isTuesdaySelected')
    @bindToggleProperty('#weathermatic-toggle-is-wednesday-selected', 'controller.isWednesdaySelected')
    @bindToggleProperty('#weathermatic-toggle-is-thursday-selected', 'controller.isThursdaySelected')
    @bindToggleProperty('#weathermatic-toggle-is-friday-selected', 'controller.isFridaySelected')
    @bindToggleProperty('#weathermatic-toggle-is-saturday-selected', 'controller.isSaturdaySelected')

)

`export default SmartlinkControllerSettingsEditOmitTimesView`
