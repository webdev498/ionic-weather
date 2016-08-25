import Ember from 'ember';

const AjaxMixin = Ember.Mixin.create({
  session: Ember.inject.service(),

  ajax(url, options) {
    this.get('session').authorize('authorizer:weathermatic', (headerName, headerValue) => {
      const authHeaders = {};
      authHeaders[headerName] = headerValue;
      Ember.$.ajax(url, Ember.merge(options, { headers: authHeaders }));
    });
  },
});

export default AjaxMixin;
