`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @store.find 'smartlink-controller', params.controllerId

  serialize: (model) ->
    if model.get
      { controllerId: model.get('id') }
    else
      model

`export default SmartlinkControllerRoute`
