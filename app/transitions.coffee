Transitions = ->
  @transition(
    @fromRoute 'sites'
    @toRoute 'site'
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute 'loading'
    @use 'toUp'
  )

  @transition(
    @fromRoute ['smartlink-controller', 'smartlink-controller.index'],
    @toRoute 'sites'
    @use 'toRight'
  )

  @transition(
    @fromRoute ['sites', 'site']
    @toRoute 'smartlink-controller'
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute ['smartlink-controller.index', 'smartlink-controller.comm-log'],
    @toRoute [
      'smartlink-controller.select-program'
      'smartlink-controller.select-zone'
      'smartlink-controller.select-valves'
      'smartlink-controller.walk-site'
      'smartlink-controller.stop-all'
      'smartlink-controller.clear-faults'
      'smartlink-controller.comm-log'
    ]
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute 'smartlink-controller.select-program'
    @toRoute 'smartlink-controller.run-program'
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute 'smartlink-controller.select-zone'
    @toRoute 'smartlink-controller.run-zone'
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute 'smartlink-controller.select-valves'
    @toRoute 'smartlink-controller.locate-valves'
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute [
      'smartlink-controller.run-program'
      'smartlink-controller.run-zone'
      'smartlink-controller.locate-valves'
    ]
    @toRoute 'smartlink-controller.index'
    @use 'toRight'
  )

  @transition(
    @fromRoute 'smartlink-controller.command-success'
    @toRoute 'smartlink-controller.index'
    @use 'toRight'
  )

  @transition(
    @fromRoute 'smartlink-controller.settings.index'
    @toRoute [
      'smartlink-controller.settings.programming'
      'smartlink-controller.settings.flow'
      'smartlink-controller.settings.edit-controller-basic'
      'smartlink-controller.settings.edit-controller-advanced'
    ]
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute 'smartlink-controller.settings.programming'
    @toRoute [
      'smartlink-controller.settings.program-details'
      'smartlink-controller.settings.program-run-times'
      'smartlink-controller.settings.auto-adjust'
      'smartlink-controller.settings.edit-omit-times'
      'smartlink-controller.settings.seasonal-adjust'
    ]
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute 'smartlink-controller.settings.program-details'
    @toRoute 'smartlink-controller.settings.edit-program-details'
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute 'smartlink-controller.settings.flow'
    @toRoute 'smartlink-controller.settings.edit-flow'
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute 'smartlink-controller.settings.program-run-times'
    @toRoute 'smartlink-controller.settings.edit-program-run-time'
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute 'smartlink-controller.settings.seasonal-adjust'
    @toRoute 'smartlink-controller.settings.edit-seasonal-adjust'
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute 'smartlink-controller.settings.auto-adjust'
    @toRoute 'smartlink-controller.settings.edit-auto-adjust'
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute 'smartlink-controller.settings.edit-controller-advanced'
    @toRoute [
      'smartlink-controller.settings.edit-zone-activations'
      'smartlink-controller.settings.edit-zone-rain-sensor'
      'smartlink-controller.settings.edit-zone-freeze-sensor'
      'smartlink-controller.settings.edit-zone-sensor'
      'smartlink-controller.settings.edit-zone-master-valve'
      'smartlink-controller.settings.edit-program-max-run'
    ]
    @use 'toLeft'
    @reverse 'toRight'
  )

`export default Transitions`
