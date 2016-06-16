`import Ember from 'ember';`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmarltinkControllerSettingsFlowRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    @modelFor('smartlink-controller.index').get('zones')
})

`export default SmarltinkControllerSettingsFlowRoute`