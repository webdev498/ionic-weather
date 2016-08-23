`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsEditOmitTimesRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    @modelFor('smartlink-controller')
})

`export default SmartlinkControllerSettingsEditOmitTimesRoute`
