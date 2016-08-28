import Ember from 'ember';
import AuthenticationMixin from '../mixins/authentication';
import Serialization from 'npm:node-qs-serialization';

const auth = Ember.Object.extend(AuthenticationMixin).create();

const addMobileAppHeaders = function(options) {
  options.headers = options.headers || {};
  Ember.merge(options.headers, {
    'X-Weathermatic-Mobile': 1,
  });
};

const addTimestamp = function(options) {
  var data;
  var isJSON = options.type.toUpperCase() !== 'GET' && options.dataType === 'json';
  if (isJSON) {
    data = JSON.parse(options.data);
  } else {
    data = Serialization.deparam(options.data);
  }
  Ember.merge(data, {
    timestamp: new Date().getTime(),
  });
  if (isJSON) {
    options.data = JSON.stringify(data);
  } else {
    options.data = Ember.$.param(data);
  }
};

export function initialize(/* app */) {
  Ember.$.ajaxPrefilter( (options, originalOptions, xhr) => {
    addMobileAppHeaders(options);
    addTimestamp(options);
    auth.setupHmacHeaders(xhr, options);
  });
}

export default {
  name: 'authentication-ajax-prefilter',
  initialize
};
