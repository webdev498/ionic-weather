`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

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

getSeasonalAdjust = (programs, identifier, monthIndex) ->
  programs.findBy('identifier', identifier).get('programSeasonalAdjustments').findBy('month', parseInt(monthIndex)+1)

SmartlinkControllerSettingsEditSeasonalAdjust = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    id = @paramsFor('smartlink-controller').controllerId
    @store.find('smartlink-controller', id).then( (ctrl) ->
      ctrl.get('programs').then( (programs) ->
        {
          index:                  params.monthIndex
          name:                   months[params.monthIndex]
          smartlinkController:    ctrl
          programASeasonalAdjust: getSeasonalAdjust(programs, 'A', params.monthIndex)
          programBSeasonalAdjust: getSeasonalAdjust(programs, 'B', params.monthIndex)
          programCSeasonalAdjust: getSeasonalAdjust(programs, 'C', params.monthIndex)
          programDSeasonalAdjust: getSeasonalAdjust(programs, 'D', params.monthIndex)
        }
      )
    )
})

`export default SmartlinkControllerSettingsEditSeasonalAdjust`
