Transitions = ->
  @transition(
    @fromRoute 'sites'
    @toRoute 'site'
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute 'site.index'
    @toRoute 'smartlink-controller'
    @use 'toLeft'
    @reverse 'toRight'
  )

  @transition(
    @fromRoute 'smartlink-controller.index'
    @toRoute [
      'smartlink-controller.select-program'
      'smartlink-controller.select-zone'
      'smartlink-controller.select-valves'
      'smartlink-controller.walk-site'
      'smartlink-controller.stop-all'
      'smartlink-controller.clear-faults'
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

`export default Transitions`
