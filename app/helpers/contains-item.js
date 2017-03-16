import Ember from 'ember';

const { Helper } = Ember;

export function containsItem(params) {
  if (params.length > 1) {
    var haystack = String(params[0]);
    const needle = String(params[1]);
    return haystack.includes(needle);
  }
  else {
    return false;
  }
}

export default Ember.Helper.helper(containsItem);
