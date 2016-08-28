import DS from 'ember-data';
import { ActiveModelSerializer } from 'active-model-adapter';

const SmartlinkControllerSerializer = ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    site: {
      serialize: 'id',
      deserialize: 'id'
    },
    faults: {
      serialize: false,
      deserialize: 'records'
    },
    omissionDays: {
      serialize: false,
      deserialize: 'records'
    },
    omissionTimes: {
      serialize: false,
      deserialize: 'records'
    },
    omissionDates: {
      serialize: false,
      deserialize: 'records'
    }
  },

  modelNameFromPayloadKey(payloadKey) {
    switch (payloadKey) {
      case 'controller':
        return 'smartlink-controller';
      case 'controllers':
        return 'smartlink-controller'
      default:
        return this._super(...arguments);
    }
  },

  keyForAttribute(attr) {
    switch (attr) {
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
    }
  },

  keyForRelationship(rawKey, kind) {
    switch (rawKey) {
      case 'omissionDays':
        return 'controller_omission_days';
      case 'omissionTimes':
        return 'controller_omission_times';
      case 'omissionDates':
        return 'controller_omission_dates';
      default:
        return this._super(...arguments);
    }
  },

  // TODO: some of these methods are no longer used after the 2.x upgrade
  // find out which ones and remove them.
  normalizePayload(payload) {
    if (payload.controller)
      payload.smartlinkController = payload.controller;
      delete payload.controller;

    if (payload.controllers)
      payload.smartlinkController = payload.controllers;
      delete payload.controllers;

    return payload;
  }

});

export default SmartlinkControllerSerializer;
