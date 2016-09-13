import Ember from 'ember';
import DS from 'ember-data';
import config from '../config/environment';
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin';
import ActiveModelAdapter from 'active-model-adapter';
import AuthenticationMixin from '../mixins/authentication';

const { Logger: { error, debug } } = Ember;

const ApplicationAdapter = ActiveModelAdapter.extend(DataAdapterMixin, AuthenticationMixin, {

  host: config.apiUrl,

  namespace: 'api/v2',

  authorizer: 'authorizer:weathermatic',

  handleResponse(status, _headers, json) {
    //  Weathermatic API responses are wrapped in an object called `result`, e.g.
    //
    //  {
    //    "result": {
    //      "site": { ... }
    //    },
    //    "meta": { ... }
    //  }
    //
    //  We want something like this instead:
    //  {
    //    "site": { ... },
    //    "meta": { ... }
    //  }
    //
    if (status !== 200) {
      error("ApplicationAdapter.handleResponse() got non-success status code: ", status);
    }
    json.result.meta = json.meta;
    delete json.meta;
    return json.result;
  },

  ajaxOptions(url, type, options) {
    debug("ApplicationAdapter.ajaxOptions(), url, type, options", url, type, options);
    const hash = this._super(...arguments) || {};
    this.addStandardParams(hash);
    return hash;
  },

  addStandardParams(options) {
    options.data = options.data || {};
    return Ember.merge(options.data, {
      wrap_result: true
    });
  },

  findHasManyWithExtraParams(store, snapshot, url, relationship, extraParams) {
    const id = snapshot.id;
    const type = snapshot.typeKey;
    return this.ajax(this.urlPrefix(url, this.buildURL(type, id)), 'GET', {
      data: extraParams
    });
  }

});

export default ApplicationAdapter;
