import Ember from 'ember';
import moment from 'moment';

export default Ember.Controller.extend({
  needs: ['smartlinkController'],
  date: moment().format('YYYY-MM-DD'),
  time:  moment().format('HH:mm'),
  init() {
    this._super();
    this.inspection_type = 0;
    console.log(this.get('model'));
  },

  actions: {
    onSelectEntityType(value) {
      this.inspection_type = value
    },
    submission(title, date, time) {
      var combinedDateTime = date + "T" + time
      var inspection_id = this.get('model').inspection_id;
      if(title && date && time) {
        this.get('store').find('inspection', inspection_id).then((item) => {
          item.set('title' , title);
          item.set('date', combinedDateTime);
          item.set('inspection_type', this.inspection_type);
          item.save().then(this.transitionToRoute('smartlink-controller.inspections'),
             alert("Inspection has been successfully updated")
          );
        }).catch(() => {
            alert("There has been an issue creating your inspection. Please check your fields and try again");
        });
      } else {
        alert('Please make sure you have entered a title');
      }
    }
  }
})