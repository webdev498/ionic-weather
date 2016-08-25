import ApplicationSerializer from './application';

const SiteSerializer = ApplicationSerializer.extend({
  normalizeLinks(data) {
    if (data.links) {
      data.links.smartlinkControllers = data.links.controllers;
      delete data.links.controllers;
    }
    return this._super(...arguments);
  },

  keyForRelationship(rawKey, _kind) {
    switch (rawKey) {
      case 'smartlinkControllers':
        return 'controller_ids';
      default:
        return this._super(...arguments);
    }
  }
});

export default SiteSerializer;
