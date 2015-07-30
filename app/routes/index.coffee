`import Ember from 'ember'`

IndexRoute = Ember.Route.extend
  redirect: (model, transition) ->
    Ember.Logger.debug 'In IndexRoute, redirecting to sites'
    @transitionTo 'sites'

`export default IndexRoute`
