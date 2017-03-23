import Ember from 'ember';

export default Ember.Controller.extend({
  needs: ['smartlinkController'],
  init() {
    this.inspection_type = 0
  },
  actions: {
    onSelectEntityType(value) {
      this.inspection_type = value
      console.log(this.inspection_type)
    },
    submission(title, date, time, scheduleSelect) {
      var formData = new FormData(document.querySelector("form"))
      console.log(formData.get('name'))
      console.log(title);
      console.log(date);
      console.log(time);
      var combinedDateTime = date + "T" + time
      console.log(combinedDateTime);
      var inspection = this.get('store').createRecord('inspection',
        {
          title: title,
          date: combinedDateTime,
          inspection_type: this.inspection_type
        });
      inspection.save().then((response) => {
        var id = inspection.id;
        this.transitionToRoute('smartlink-controller.inspections.select-inspection',id);
        console.log("save returned: " + response);
      },(response) => {
        //if failure
        //server responded with {"error":"some custom error message"}
        //BUT HOW TO CATCH THIS AND POSSIBLY REMOVE THE MODEL FROM THE STORE
        if (response.error == 'no good') {
          myModel.deleteRecord();
        }

      });
    }
  }
})