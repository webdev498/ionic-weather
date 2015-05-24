`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SiteRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @store.find 'site', params.siteId

`export default SiteRoute`
