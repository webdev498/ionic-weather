import DS from 'ember-data';

const ProgramZone = DS.Model.extend({

    formattedRunTime: DS.attr('string'),
    programIdentifier: DS.attr('string'),

    zone: DS.belongsTo('zone', { async: true }),
    program: DS.belongsTo('program', { async: true }),

    fullRunTime: Ember.computed('formattedRunTime', function() {
      const t = this.get('formattedRunTime');
      return `2000-01-01T${t}:00.000Z`;
    }),

    isOff: Ember.computed('formattedRunTime', function() {
      const t = this.get('formattedRunTime').split(':');
      return parseInt(t[0]) === 0 && parseInt(t[1]) === 0;
    }),

    isUsed: false,

    updateIsUsed: Ember.observer('zone.programZones.@each.formattedRunTime', function() {
      this.get('zone.smartlinkController').then( (ctrl) => {
        if (!ctrl.get('hasDripZoneConstraint')) {
          return;
        }

        // If program D is used, A-C cannot be.
        // Inversely, if one of A-C is used, D is not allowed

        if (this.get('programIdentifier') === 'D') {
          var used = false;
          this.get('zone.programZones.').forEach( (pz) => {
            if (pz.get('programIdentifier') !== 'D' && !pz.get('isOff')) {
              used = true;
            }
          });
          this.set('isUsed', used);
        } else {
          const programZoneD = this.get('zone.programZones').findBy(
            'programIdentifier', 'D');
          this.set('isUsed', !programZoneD.get('isOff'));
        }
      });
    })
});

export default ProgramZone;
