import Ember from 'ember';

const noteq = (params) => params[0] !== params[1];

export default Ember.Helper.helper(noteq);
