`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsEditSeasonalAdjust = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    id = @paramsFor('smartlink-controller').controllerId
    @store.find('smartlink-controller', id).then (ctrl) ->
      months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November'
      ]
      Ember.Object.create({
        index:               params.monthIndex
        name:                months[params.monthIndex]
        smartlinkController: ctrl
      })
})

`export default SmartlinkControllerSettingsEditSeasonalAdjust`
