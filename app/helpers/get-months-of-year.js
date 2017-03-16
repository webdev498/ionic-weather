import Ember from 'ember';

const { Helper } = Ember;

export function getMonthsOfYear(params) {
  var monthArray = new Array();
  monthArray[0] = "January";
  monthArray[1] = "February";
  monthArray[2] = "March";
  monthArray[3] = "April";
  monthArray[4] = "May";
  monthArray[5] = "June";
  monthArray[6] = "July";
  monthArray[7] = "August";
  monthArray[8] = "September";
  monthArray[9] = "October";
  monthArray[10] = "November";
  monthArray[11] = "December";
  return monthArray;
}

export default Ember.Helper.helper(getMonthsOfYear);
