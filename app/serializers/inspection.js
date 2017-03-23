import DS from 'ember-data';
import { ActiveModelSerializer } from 'active-model-adapter';

const InspectionSerializer = ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    controller: {
      serialize: false,
      deserialize: 'controller'
    },
    created_at: {
        serialize: false,
      deserialize: 'created_at'
    },
    inspector_id: {
      serialize: false,
      deserialize: 'inspector_id'
    },
    inspector_id: {
      serialize: false,
      deserialize: 'inspector_id'
    },
    inspector_name: {
      serialize: false,
      deserialize: 'inspector_name'
    },
    inspections_zones: {
      serialize: false,
      deserialize: 'inspections_zones'
    },
    is_first_inspection: {
      serialize: false,
      deserialize: 'is_first_inspection'
    },
    prior_configuration_compliant: {
      serialize: false,
      deserialize: 'prior_configuration_compliant'
    },
    prior_configuration_rf_present: {
      serialize: false,
      deserialize: 'prior_configuration_rf_present'
    },
    prior_equipment: {
      serialize: false,
      deserialize: 'prior_equipment'
    },
    water_pressure: {
      serialize: false,
      deserialize: 'water_pressure'
    },
    water_pressure_unit: {
      serialize: false,
      deserialize: 'water_pressure_unit'
    }
  },

  modelNameFromPayloadKey(payloadKey) {
       return this._super(...arguments);
    /*switch (payloadKey) {
      case 'controller':
        return 'smartlink-controller';
      case 'controllers':
        return 'smartlink-controller'
      default:
        return this._super(...arguments);
    }*/
  },

  keyForAttribute(attr) {
      return this._super(...arguments);
    /*switch (attr) {
      case 'weatherStatus':
        return 'sw_status';
      case 'wateringMode':
        return 'mode';
      case 'rainFreezeSensorMode':
        return 'sensor_mode';
      case 'canRunCommands':
        return 'run_remote';
      default:
        return this._super(...arguments);
    } */
  },

  keyForRelationship(rawKey, kind) {
      return this._super(...arguments);
    /*switch (rawKey) {
      case 'omissionDays':
        return 'controller_omission_days';
      case 'omissionTimes':
        return 'controller_omission_times';
      case 'omissionDates':
        return 'controller_omission_dates';
      default:
        return this._super(...arguments);
    }*/
  },

  // TODO: some of these methods are no longer used after the 2.x upgrade
  // find out which ones and remove them.
  /*normalizePayload(payload) {
    if (payload.controller)
      payload.smartlinkController = payload.controller;
      delete payload.controller;

    if (payload.controllers)
      payload.smartlinkController = payload.controllers;
      delete payload.controllers;

    return payload;
  }*/

});

export default InspectionSerializer;
