import Ember from 'ember';

const { Helper } = Ember;

export function isArrayEmpty(params) {
  var array = params[0];
  return array.length < 1;
}

export default Ember.Helper.helper(isArrayEmpty);
