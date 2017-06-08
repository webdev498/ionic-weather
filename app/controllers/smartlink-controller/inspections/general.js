import Ember from 'ember';

const SmartlinkControllerGeneralInspectionController = Ember.Controller.extend({
  needs: ['smartlinkController'],
  init: function(){
    Ember.run.schedule("afterRender", this, function() {
      this.send("initializeJQuery");
    });
  },

  actions: {
  initializeJQuery() {
      //alert(this.get('model.smartlinkController.site'));
   }
  }
});

export default SmartlinkControllerGeneralInspectionController;