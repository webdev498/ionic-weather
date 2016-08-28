import ApplicationAdapter from './application';
import CurrentUserMixin from './../mixins/current-user';

const { Logger: { debug }, merge } = Ember;

const SmartlinkControllerAdapter = ApplicationAdapter.extend(CurrentUserMixin, {

  pathForType() {
    return 'controllers';
  },

  ajaxOptions(url, type, options) {
    debug("SmartlinkControllerAdapter.ajaxOptions(), url, type, options", url, type, options);
    options.data = options.data || {};
    merge(options.data, this.customQueryParams);
    return this._super(...arguments);
  },

  find(store, type, id, snapshot) {
    debug('SmartlinkControllerAdapter.find(), type:, id:', type, id);
    const url = this.buildURL(type.typeKey, id, snapshot);
    return this.ajax(url, 'GET', {
      data: this.customQueryParams
    });
  },

  findHasMany(store, snapshot, url, relationship) {
    switch (relationship.key) {
      case 'instructions':
        return this.findInstructions(...arguments);
      case 'zones':
        return this.findZones(...arguments);
      case 'programs':
        return this.findPrograms(...arguments);
      default:
        return this._super(...arguments);
    }
  },

  findInstructions(store, snapshot, url, relationship) {
    const extraParams = {
      embed_controller: false,
      hide_admin_instructions: !this.get('isLoggedInAsAdmin'),
      hide_overnight_instructions: true,
      datetime_format: '%b %d %l:%M %P (%Z)'
    };
    return this.findHasManyWithExtraParams(store, snapshot, url, relationship, extraParams);
  },

  findZones(store, snapshot, url, relationship) {
    const extraParams = {
      embed_program_zones: true
    };
    return this.findHasManyWithExtraParams(store, snapshot, url, relationship, extraParams);
  },

  findPrograms(store, snapshot, url, relationship) {
    const extraParams = {
      embed_program_seasonal_adjustments: 'true'
    };
    return this.findHasManyWithExtraParams(store, snapshot, url, relationship, extraParams);
  },

  customQueryParams: {
    embed_site:                         'false',
    embed_controller_omission_days:     'true',
    embed_controller_omission_dates:    'true',
    embed_controller_omission_times:    'true',
    embed_program_seasonal_adjustments: 'true'
  }

});

export default SmartlinkControllerAdapter;
