import ApplicationAdapter from './application';

const { merge } = Ember;

const ZoneAdapter = ApplicationAdapter.extend({

  ajaxOptions(url, type, options) {
    const hash = this._super(...arguments);
    this.addCustomParams(hash);
    return hash;
  },

  addCustomParams(options) {
    options.data = options.data || {};
    return merge(options.data, {
      embed_program_zones: true
    });
  }

});

export default ZoneAdapter;
