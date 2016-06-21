`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SmartlinkControllerSettingsEditProgramMaxRun = Ember.Route.extend(AuthenticatedRouteMixin, {
  model: (params) ->
    id = @paramsFor('smartlink-controller').controllerId
    @store.find('smartlink-controller', id).then (c) ->
      c.get('programs').then (p) ->
        Ember.Object.create({
          smartlinkController: c
          programA: p.findBy('identifier', 'A')
          programB: p.findBy('identifier', 'B')
          programC: p.findBy('identifier', 'C')
          programD: p.findBy('identifier', 'D')
        })
})

`export default SmartlinkControllerSettingsEditProgramMaxRun`
