import Ember from 'ember';
import moment from 'moment'; 

export default Ember.Controller.extend({
  needs: ['smartlinkController'],
  date: moment().format('YYYY-MM-DD'),
  time:  moment().format('HH:mm'),
  init() {
    this.inspection_type = 0
  },
  actions: {
    onSelectEntityType(value) {
      this.inspection_type = value
    },
    submission(title, date, time) {
      var combinedDateTime = date + "T" + time
      var inspection = this.get('store').createRecord('inspection',
        {
          title: title,
          date: combinedDateTime,
          inspection_type: this.inspection_type
        });
      if(title && date && time) {
        inspection.save().then((response) => {
          var id = inspection.id;
          if(id) {
            this.transitionToRoute('smartlink-controller.inspections.select-inspection',id);
          } else {
            alert("There has been an issue creating your inspection. Please check your fields and try again");
          }
        },(response) => {
          //if failure
          //server responded with {"error":"some custom error message"}
          //BUT HOW TO CATCH THIS AND POSSIBLY REMOVE THE MODEL FROM THE STORE
          if (response.error) {
            alert(response.error);
          }
          else {
             alert("There has been an issue creating your inspection. Please check your fields and try again");
          }
          inspection.deleteRecord();
        });
      } else {
        alert('Please make sure you have entered a title');
      }
    }
  }
})