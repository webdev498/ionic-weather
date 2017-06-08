import Ember from 'ember';

const SmartlinkControllerGeneralInspectionController = Ember.Controller.extend({
  needs: ['smartlinkController'],
  updateAddress: function(){
    let $this = this;
    this.get('model.controller.site').then(function(response){
        $this.set('address',response.get('address1'));
    })
  }.observes('model.controller.site'),

  updateInspectType: function(){
    let $this = this;
    this.get('model.inspection').then(function(response){
        $this.set('scheduleType', response.get('inspection_type') === 0 ? "Service Call" : "Scheduled Inspection");
    })
  }.observes('model.controller.inspection'),

  init: function(){
    Ember.run.schedule("afterRender", this, function() {
      this.send("initializeJQuery");
    });
  },

  actions: {
      initializeJQuery() {

      }
  }
});

export default SmartlinkControllerGeneralInspectionController;