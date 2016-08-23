`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

SiteIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('site').get('smartlinkControllers')

`export default SiteIndexRoute`
