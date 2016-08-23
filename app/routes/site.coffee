`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SiteRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @store.find 'site', params.siteId

  serialize: (model) ->
    { siteId: model.get('id') }

`export default SiteRoute`
