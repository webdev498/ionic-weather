`import Ember from 'ember'`

SiteIndexController = Ember.Controller.extend
  # XXX: instead of this weirdness we could make site/controllers a nested route with built-in loading substates
  smartlinkControllersLoading: Ember.computed 'model.smartlinkControllers.length', ->
    @get('model.controllersCount') > @get('model.smartlinkControllers.length')


`export default SiteIndexController`
