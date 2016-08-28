import Ember from 'ember';
import ApplicationAdapter from './application';

const { Logger: { debug }, merge } = Ember;

const SitesAdapter = ApplicationAdapter.extend({
  find(store, type, id, snapshot) {
    const url = this.buildURL(type.typeKey, id, snapshot);
    return this.ajax(url, 'GET', {
      data: this.customQueryParams
    });
  },

  query(store, type, query) {
    query = query || {};
    merge(query, this.customQueryParams);
    return this._super(...arguments);
  },

  ajaxOptions(url, type, options) {
    debug("SitesAdapter.ajaxOptions(), url, type, options", url, type, options);
    options.data = options.data || {};
    merge(options.data, this.customQueryParams);
    return this._super(...arguments);
  },

  findHasMany(store, snapshot, url, relationship) {
    switch (relationship.key) {
      case 'smartlinkControllers':
        return this.findSmartlinkControllers(...arguments);
      default:
        return this._super(...arguments);
    }
  },

  findSmartlinkControllers(store, snapshot, url, relationship) {
    var extraParams;
    extraParams = store.adapterFor('smartlink-controller').get('customQueryParams');
    return this.findHasManyWithExtraParams(store, snapshot, url, relationship, extraParams);
  },

  customQueryParams: {
    embed_controllers:         'false',
    include_faults_count:      'true',
    include_controllers_count: 'true'
  }
});

export default SitesAdapter;
