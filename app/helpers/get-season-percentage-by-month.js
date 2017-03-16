import Ember from 'ember';

const { Helper } = Ember;

export function getSeasonPercentageByMonth(params) {
  var array = params[0];
  var index = params[1];
  return array[index].percentage;
}

export default Ember.Helper.helper(getSeasonPercentageByMonth);
