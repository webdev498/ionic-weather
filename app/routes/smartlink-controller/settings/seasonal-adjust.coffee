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

SmartlinkControllerSettingsSeasonalAdjustRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    id = @paramsFor('smartlink-controller').controllerId
    @store.find('smartlink-controller', id).then (ctrl) ->
      ctrl.get('programs').then (programs) ->
        {
          smartlinkController: ctrl
          months: months.map (monthName, monthIndex) ->
            {
              name: monthName
              index: monthIndex
              programASeasonalAdjust: getSeasonalAdjust(programs, 'A', monthIndex)
              programBSeasonalAdjust: getSeasonalAdjust(programs, 'B', monthIndex)
              programCSeasonalAdjust: getSeasonalAdjust(programs, 'C', monthIndex)
              programDSeasonalAdjust: getSeasonalAdjust(programs, 'D', monthIndex)
            }
        }

})

`export default SmartlinkControllerSettingsSeasonalAdjustRoute`
