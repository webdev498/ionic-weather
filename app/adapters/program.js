import ApplicationAdapter from './application';

const ProgramAdapter = ApplicationAdapter.extend({

  ajaxOptions(url, type, options) {
    const hash = this._super(...arguments);
    this.addCustomParams(hash);
    return hash;
  },

  addCustomParams(options) {
    options.data = options.data || {};
    return Ember.merge(options.data, {
      embed_program_seasonal_adjustments: true
    });
  }

});

export default ProgramAdapter;
