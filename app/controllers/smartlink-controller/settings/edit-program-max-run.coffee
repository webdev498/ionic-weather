`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

SmartlinkControllerSettingsEditProgramMaxRunController = Ember.Controller.extend(SmartlinkSaveMixin, {
  saveUrl: (program) ->
    "#{@get('baseUrl')}/api/v2/programs/#{program.get('id')}"

  actions: {
    save: -> (
      @saveAll([
          {
            url: @saveUrl(@get('model.programA'))
            params: {
              program: {
                max_run: @get('model.programA.maxRun')
                min_soak: @get('model.programA.minSoak')
              }
            }
          },
          {
            url: @saveUrl(@get('model.programB'))
            params: {
              program: {
                max_run: @get('model.programB.maxRun')
                min_soak: @get('model.programB.minSoak')
              }
            }
          },
          {
            url: @saveUrl(@get('model.programC'))
            params: {
              program: {
                max_run: @get('model.programC.maxRun')
                min_soak: @get('model.programC.minSoak')
              }
            }
          },
          {
            url: @saveUrl(@get('model.programD'))
            params: {
              program: {
                max_run: @get('model.programD.maxRun')
                min_soak: @get('model.programD.minSoak')
              }
            }
          }
      ])
    )
  }
})

`export default SmartlinkControllerSettingsEditProgramMaxRunController`
