`import Ember from 'ember'`

Ember.Route.extend
  redirect: (model, transition) ->
    @transitionTo 'sites'

`export default IndexRoute`
