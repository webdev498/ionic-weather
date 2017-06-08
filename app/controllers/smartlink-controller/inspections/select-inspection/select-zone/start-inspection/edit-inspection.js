import Ember from 'ember';
import moment from 'moment';

export default Ember.Controller.extend({
  needs: ['smartlinkController'],
  date: moment().format('YYYY-MM-DD'),
  time:  moment().format('HH:mm'),
  inspection_status: 'Start Inspection',
  disabled: null,
  init() {
    this._super();
    this.inspection_type = 0;
  },

  actions: {
    onSelectEntityType(value) {
      this.inspection_type = value
    },
    submission(title, date, time) {
      var combinedDateTime = date + "T" + time
      var inspection_id = this.get('model').inspection_id;
      this.set('inspection_status','Updating Inspection...');
      this.set('disabled','disabled');
      if(title && date && time) {
        this.get('store').find('inspection', inspection_id).then((item) => {
          item.set('title' , title);
          item.set('date', combinedDateTime);
          item.set('inspection_type', this.inspection_type);
          item.save().then((response) => {
            this.set('inspection_status','Save Inspection')
            this.set('disabled',null)
            this.transitionToRoute('smartlink-controller.inspections.select-inspection.select-zone.start-inspection')
          })
        }).catch(() => {
            alert("There has been an issue creating your inspection. Please check your fields and try again");
        });
      } else {
        alert('Please make sure you have entered a title');
      }
    }
  }
})