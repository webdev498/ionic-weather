`import Ember from 'ember'`
`import SmartlinkSaveMixin from '../../../mixins/smartlink-save'`

SmartlinkControllerSettingsEditProgramMaxRunController = Ember.Controller.extend(SmartlinkSaveMixin, {
  saveUrl: (program) ->
    "#{@get('baseUrl')}/api/v2/programs/#{program.get('id')}"

  getMinSoakValue: (programIdent) ->
    maxRun = @get("model.program#{programIdent}.maxRun")
    if maxRun == 0
      return 0
    else
      return @get("model.program#{programIdent}.minSoak")

  actions: {
    save: -> (
      @saveAll([
          {
            url: @saveUrl(@get('model.programA'))
            params: {
              program: {
                max_run: @get('model.programA.maxRun')
                min_soak: @getMinSoakValue('A')
              }
            }
          },
          {
            url: @saveUrl(@get('model.programB'))
            params: {
              program: {
                max_run: @get('model.programB.maxRun')
                min_soak: @getMinSoakValue('B')
              }
            }
          },
          {
            url: @saveUrl(@get('model.programC'))
            params: {
              program: {
                max_run: @get('model.programC.maxRun')
                min_soak: @getMinSoakValue('C')
              }
            }
          },
          {
            url: @saveUrl(@get('model.programD'))
            params: {
              program: {
                max_run: @get('model.programD.maxRun')
                min_soak: @getMinSoakValue('D')
              }
            }
          }
      ]).then =>
        @set('model.smartlinkController.hasUnsentChanges', true)
    )
  }
})

`export default SmartlinkControllerSettingsEditProgramMaxRunController`
