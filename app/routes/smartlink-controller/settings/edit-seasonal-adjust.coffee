`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

getSeasonalAdjust = (ctrl, identifier, monthIndex) ->
  debugger
  ctrl.get('programs').findBy('identifier', identifier).get('programSeasonAdjustments').findBy('month', monthIndex)

months = [
  'January'
  'February'
  'March'
  'April'
  'May'
  'June'
  'July'
  'August'
  'September'
  'October'
  'November'
  'December'
]

SmartlinkControllerSettingsEditSeasonalAdjust = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    id = @paramsFor('smartlink-controller').controllerId
    @store.find('smartlink-controller', id).then (ctrl) ->
      Ember.Object.create({
        index:               params.monthIndex
        name:                months[params.monthIndex]
        smartlinkController: ctrl
        programASeasonalAdjust: getSeasonalAdjust(ctrl, 'A', params.monthIndex)
        programBSeasonalAdjust: getSeasonalAdjust(ctrl, 'B', params.monthIndex)
        programCSeasonalAdjust: getSeasonalAdjust(ctrl, 'C', params.monthIndex)
        programDSeasonalAdjust: getSeasonalAdjust(ctrl, 'D', params.monthIndex)
      })
})

`export default SmartlinkControllerSettingsEditSeasonalAdjust`
