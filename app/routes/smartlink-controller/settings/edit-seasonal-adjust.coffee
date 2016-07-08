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

SmartlinkControllerSettingsEditSeasonalAdjust = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    id = @paramsFor('smartlink-controller').controllerId
    @store.find('smartlink-controller', id).then( (ctrl) ->
      ctrl.get('programs').then( (programs) ->
        {
          index:                  params.monthIndex
          name:                   months[params.monthIndex]
          smartlinkController:    ctrl
          programASeasonalAdjust: programs.findBy('identifier', 'A').get('programSeasonalAdjustments').findBy('month', parseInt(params.monthIndex)+1)
          programBSeasonalAdjust: programs.findBy('identifier', 'B').get('programSeasonalAdjustments').findBy('month', parseInt(params.monthIndex)+1)
          programCSeasonalAdjust: programs.findBy('identifier', 'C').get('programSeasonalAdjustments').findBy('month', parseInt(params.monthIndex)+1)
          programDSeasonalAdjust: programs.findBy('identifier', 'D').get('programSeasonalAdjustments').findBy('month', parseInt(params.monthIndex)+1)
        }
      )
    )
})

`export default SmartlinkControllerSettingsEditSeasonalAdjust`
