import Ember from 'ember';

const { Helper } = Ember;

export function textOrSpace(params/*, hash*/) {
  const text = params[0];
  if (text && text.length) {
    return text;
  } else {
    return Ember.String.htmlSafe('&nbsp');
  }
}

export default helper(textOrSpace);
