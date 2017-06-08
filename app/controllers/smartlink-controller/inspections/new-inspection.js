import Ember from 'ember';
import moment from 'moment';

export default Ember.Controller.extend({
  needs: ['smartlinkController'],
  date: moment().format('YYYY-MM-DD'),
  time:  moment().format('HH:mm'),
  disabled: null,
  inspection_status: "Start Inspection",
  inspection_error: "",
  init: function(){
    this.inspection_type = 1;
    this.inspection_error = "";
  },
  actions: {
    onSelectEntityType(value) {
      this.inspection_type = value
    },
    submission(title, date, time) {
      var combinedDateTime = date + "T" + time;
      var inspection = this.get('store').createRecord('inspection',
        {
          title: title,
          date: combinedDateTime,
          inspection_type: this.inspection_type
        });
      this.set('inspection_error',"");
      if(title && date && time) {
        this.set('disabled',true);
        this.set('inspection_status',"Creating Inspection...");
        inspection.save().then((response) => {
          var id = inspection.id;
          this.set('disabled',null);
          this.set('date',moment().format('YYYY-MM-DD'));
          this.set('title',"");
          this.set('inspection_status',"Inspection Created");
          if(id) {
            this.set('inspection_status',"Start Inspection");
            this.transitionToRoute('smartlink-controller.inspections.select-inspection',id);
          }
        },(response) => {
          this.set('disabled',null);
          //if failure
          //server responded with {"error":"some custom error message"}
          //BUT HOW TO CATCH THIS AND POSSIBLY REMOVE THE MODEL FROM THE STORE
          if (response.error) {
             alert("There can't be be ");
          }
          else {
             this.set('inspection_error',"There was another inspection created on this date. Please pick another date.");
             this.set('inspection_status',"Start Inspection");
             this.set('disabled',null);
          }
          inspection.deleteRecord();
        });
      } else {
        alert('Please make sure you have entered a title');
      }
    }
  }
})