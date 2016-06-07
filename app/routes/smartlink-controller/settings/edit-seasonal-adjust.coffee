`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsEditSeasonalAdjust = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
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

    {
      index: params.monthIndex
      name: months[params.monthIndex]
      smartlinkController: @modelFor('smartlink-controller.index')
    }
})

`export default SmartlinkControllerSettingsEditSeasonalAdjust`
