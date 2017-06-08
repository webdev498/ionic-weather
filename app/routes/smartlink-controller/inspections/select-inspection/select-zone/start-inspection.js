import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import RSVP from 'rsvp';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  sprinklerTypes: [
    { display: "Standard (non-ET)", id: 0 },
    { display: "Off", id: 1 },
    { display: 'Spray (1.5")', id: 2 },
    { display: 'Rotor (0.5")', id: 3 },
    { display: 'Drip (1.1")', id: 4 },
    { display: 'Bubbler (2.3")', id: 5 },
  ],
  plant_types: [
    { display: "CTURF", id: 0 },
    { display: "WTURF", id: 1 },
    { display: "Shrubs", id: 2 },
    { display: "Annuals", id: 3 },
    { display: "Trees", id: 4 },
    { display: "Native", id: 5 }
  ],
  soil_types: [
    { display: "Sand", id: 0 },
    { display: "Loam", id: 1 },
    { display: "Clay", id: 2 },
  ],
  more_less: [],
  model(params, transition) {
    //This is how we get the id of the inspection
    for (var i = 20; i <= 100; i++) {
      var val = i / 100;
      var obj_local = { display: val.toFixed(2) + '"', index: i };
      this.sprinklerTypes.push(obj_local);
    }
    for (var i = 10; i <= 300; i++) {
      var obj_local = { display: i + '%', index: i };
      this.plant_types.push(obj_local);
    }
    for (var i = 25; i >= -50; i--) {
      var obj_local = { display: i + '%', index: i };
      this.more_less.push(obj_local);
    }
    var controller_id = transition.state.params['smartlink-controller'].controllerId
    var inspectionId = transition.state.params['smartlink-controller.inspections.select-inspection'].inspectionId;
    var zoneId = transition.state.params['smartlink-controller.inspections.select-inspection.select-zone.start-inspection'].zoneId;
    return RSVP.hash({
      id: zoneId,
      selectValues: [
        { display: "10", id: 10 },
        { display: "9", id: 9 },
        { display: "8", id: 8 },
        { display: "7", id: 7 },
        { display: "6", id: 6 },
        { display: "5", id: 5 },
        { display: "4", id: 4 },
        { display: "3", id: 3 },
        { display: "2", id: 2 },
        { display: "1", id: 1 },
        { display: "None", id: 0 }
      ],
      more_less: this.more_less,
      sprinklerTypes: this.sprinklerTypes,
      plantTypes: this.plant_types,
      soilTypes: this.soil_types,
      controller_id: controller_id,
      inspection: this.get('store').find('inspection', Number(inspectionId)),
      inspectionZone: this.get('store').find('inspection', Number(inspectionId)).then((zones) => {
        return zones.get('inspections_zones').filterBy('zone_id',Number(zoneId));
      }),
      programs: this.get('store').find('zone', zoneId).then((zones) => {
        return zones.get('programZones');
      }),
      zones: this.modelFor('smartlinkController').get('zones').then((zone) => {
        return zone.filterBy('id', zoneId);
      })
    });
  }
});

