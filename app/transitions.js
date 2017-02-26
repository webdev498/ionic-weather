const Transitions = function() {
  this.transition(
    this.fromRoute('sites'),
    this.toRoute('site'),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute( (route) => {
      return route.match(/.*loading/);
    }),
    this.use('toUp'),
  );

  this.transition(
    this.fromRoute(['smartlink-controller', 'smartlink-controller.index']),
    this.toRoute('sites'),
    this.use('toRight'),
  );

  this.transition(
    this.fromRoute(['sites', 'site']),
    this.toRoute(['smartlink-controller', 'smartlink-controller.index']),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute(['smartlink-controller.index', 'smartlink-controller.comm-log']),
    this.toRoute([
     'smartlink-controller.select-program',
     'smartlink-controller.select-zone',
     'smartlink-controller.select-valves',
     'smartlink-controller.walk-site',
     'smartlink-controller.stop-all',
     'smartlink-controller.clear-faults',
     'smartlink-controller.comm-log',
     'smartlink-controller.inspections',
    ]),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  // this.transition(
  //   this.fromRoute('smartlink-controller.walk-site.zone'),
  //   this.toRoute('smartlink-controller.walk-site.zone'),
  //   this.use('toLeft'),
  //   this.debug(),
  // );

  this.transition(
    this.fromRoute('smartlink-controller.select-program'),
    this.toRoute('smartlink-controller.run-program'),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute('smartlink-controller.select-zone'),
    this.toRoute('smartlink-controller.run-zone'),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute('smartlink-controller.select-valves'),
    this.toRoute('smartlink-controller.locate-valves'),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute([
     'smartlink-controller.run-program',
     'smartlink-controller.run-zone',
     'smartlink-controller.locate-valves',
    ]),
    this.toRoute('smartlink-controller.index'),
    this.use('toRight'),
  );

  this.transition(
    this.fromRoute('smartlink-controller.command-success'),
    this.toRoute('smartlink-controller.index'),
    this.use('toRight'),
  );

  this.transition(
    this.fromRoute(['smartlink-controller.index', 'smartlink-controller']),
    this.toRoute([
      'smartlink-controller.settings',
      'smartlink-controller.settings.index']),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute('smartlink-controller.settings.index'),
    this.toRoute([
     'smartlink-controller.settings.programming',
     'smartlink-controller.settings.flow',
     'smartlink-controller.settings.edit-controller-basic',
     'smartlink-controller.settings.edit-controller-advanced',
     'smartlink-controller.settings.edit-omit-times',
     'smartlink-controller.settings.edit-labels',
    ]),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute('smartlink-controller.settings.programming'),
    this.toRoute([
     'smartlink-controller.settings.program-details',
     'smartlink-controller.settings.program-run-times',
     'smartlink-controller.settings.auto-adjust',
     'smartlink-controller.settings.edit-omit-times',
     'smartlink-controller.settings.seasonal-adjust',
    ]),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute('smartlink-controller.settings.program-details'),
    this.toRoute('smartlink-controller.settings.edit-program-details'),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute('smartlink-controller.settings.flow'),
    this.toRoute('smartlink-controller.settings.edit-flow'),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute('smartlink-controller.settings.program-run-times'),
    this.toRoute('smartlink-controller.settings.edit-program-run-time'),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute('smartlink-controller.settings.seasonal-adjust'),
    this.toRoute('smartlink-controller.settings.edit-seasonal-adjust'),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute('smartlink-controller.settings.auto-adjust'),
    this.toRoute('smartlink-controller.settings.edit-auto-adjust'),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute('smartlink-controller.settings.edit-controller-advanced'),
    this.toRoute([
     'smartlink-controller.settings.edit-zone-activations',
     'smartlink-controller.settings.edit-zone-rain-sensor',
     'smartlink-controller.settings.edit-zone-freeze-sensor',
     'smartlink-controller.settings.edit-zone-sensor',
     'smartlink-controller.settings.edit-zone-master-valve',
     'smartlink-controller.settings.edit-program-max-run',
    ]),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

  this.transition(
    this.fromRoute('smartlink-controller.inspections.index'),
    this.toRoute([
     'smartlink-controller.inspections.edit-inspection',
     'smartlink-controller.inspections.select-inspection'
    ]),
    this.use('toLeft'),
    this.reverse('toRight'),
  );

};

export default Transitions;