import Ember from 'ember';

export function textOrSpace(params/*, hash*/) {
  const text = params[0];
  if (text && text.length) {
    return text;
  } else {
    return Ember.String.htmlSafe('&nbsp');
  }
}

export default Ember.Helper.helper(textOrSpace);
