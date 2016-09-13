import ApplicationAdapter from './application';

const InstructionAdapter = ApplicationAdapter.extend({

  ajaxOptions(url, type, options) {
    const hash = this._super(...arguments);
    this.addCustomParams(hash);
    return hash;
  },

  addCustomParams(options) {
    options.data = options.data || {};
    return Ember.merge(options.data, {
      embed_controller: false
    });
  }

});

export default InstructionAdapter;
