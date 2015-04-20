`import Ember from 'ember'`

IndexRoute = Ember.Route.extend
  redirect: (model, transition) ->
    @transitionTo 'sites'

`export default IndexRoute`
