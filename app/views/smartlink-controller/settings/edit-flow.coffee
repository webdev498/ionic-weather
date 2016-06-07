`import RatchetToggleView from '../../ratchet-toggle-view'`


SmartlinkControllerSettingsEditFlowView = RatchetToggleView.extend
  didInsertElement: ->
    this._super()
    @bindToggleProperty('#weathermatic-toggle-realtime-flow-enabled', 'controller.model.realtimeFlowEnabled')
    @bindToggleProperty('#weathermatic-toggle-low-flow',              'controller.isLowFlowLimitEnabled')
    @bindToggleProperty('#weathermatic-toggle-high-flow',             'controller.isHighFlowLimitEnabled')

`export default SmartlinkControllerSettingsEditFlowView`
