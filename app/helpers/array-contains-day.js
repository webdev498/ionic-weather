import Ember from 'ember';

const { Helper } = Ember;

export function arrayContainsDay(params) {
  if (params.length > 1) {
    var haystack = params[0];
    const needle = String(params[1]);
    for(var i=0; i < haystack.length; i++) {
        var element = haystack[i];
        if(element.day == needle) {
            //Day Found
            return true;
        }
    }
    //Nothing found
    return false;
  }
  else {
    return false;
  }
}

export default Ember.Helper.helper(arrayContainsDay);
