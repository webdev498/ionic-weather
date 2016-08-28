import Ember from 'ember';
import Serialization from 'npm:node-qs-serialization';

const SLNAK = '7d56617d4d6febd91be7f87c03c1ee37';
const SLNAS = '52834b76a803eb35706701fa71c7ac79';

const AuthenticationMixin = Ember.Mixin.create({
  verifyTimestamp: function(options) {
    var data;
    if (options.contentType === 'application/json') {
      if (typeof options.data === 'string') {
        data = JSON.parse(options.data);
      } else {
        data = options.data;
      }
    } else {
      if (typeof options.data === 'string') {
        data = Serialization.deparam(options.data);
      } else {
        data = options.data;
      }
    }
    if (!data.timestamp) {
      throw new Error('AJAX requests must include a `timestamp` query param');
    }
  },

  setupHttpBasicHeaders(xhr, email, password) {
    return xhr.setRequestHeader('Authorization', this.buildHttpBasicHeader(email, password));
  },

  buildHttpBasicHeader(email, password) {
    const base64EncodedAuthToken = btoa(email + ":" + password);
    return `Basic ${base64EncodedAuthToken}`;
  },

  setupHmacHeaders(xhr, options) {
    xhr.setRequestHeader('x-api-key', SLNAK);
    return xhr.setRequestHeader('x-api-hmac', this.buildHmacSignature(options));
  },

  buildHmacSignature(options) {
    this.verifyTimestamp(options);
    const content = this.buildHmacContent(options);
    return this.signHmacContent(content);
  },

  signHmacContent(content) {
    return CryptoJS.HmacSHA256(content, SLNAS).toString(CryptoJS.enc.Base64);
  },

  buildHmacContent(options) {
    if (typeof options.data === 'string') {
      return options.data;
    }
    if (options.type === 'GET') {
      return Ember.$.param(options.data);
    } else {
      return JSON.stringify(options.data);
    }
  },

});

export default AuthenticationMixin;
