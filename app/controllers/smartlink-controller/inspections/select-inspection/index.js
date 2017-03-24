import Ember from 'ember';
import ManualRunMixin from '../../../../mixins/manual-run';
import Base from 'ember-simple-auth/authenticators/base';
import AuthenticationMixin from '../../../../mixins/authentication';
import AjaxMixin from '../../../../mixins/ajax';
import config from '../../../../config/environment';

export default Ember.Controller.extend(ManualRunMixin, AjaxMixin, {
  session: Ember.inject.service(),
  isEmailInspectionOpen: false,
  actions: {
    openEmailInspectionMenu() {
      this.set('isEmailInspectionOpen', true);
    },
    closeEmailInspectionMenu() {
      this.set('isEmailInspectionOpen', false);
    },
    sendInspectionEmail(params) {
      var $form = $('#send-inspection');
      var params = $form.serializeArray();
      var data = {};
      for (var i = 0; i < params.length; i++) {
        var obj = params[i];
        data[obj.name] = obj.value;
      }
      if (data.emails) {
        //Now, parse out the emails
        var emailArray = data.emails.split(',');
        var url = `${config.apiUrl}/api/v2/controllers/${this.get('model').controller_id}/inspections/${this.get('model').inspection_id}/export`;
        var json_body = {
          "controller_id": this.get('model').controller_id,
          "id": this.get('model').inspection_id,
          "emails": emailArray,
          "photos": data.photoGroup === "true",
          "type": data.fileGroup
        };
        this.ajax(url, {
          method: 'POST',
          data: json_body,
          success: (response) => {
            alert("Report sent to " + data.emails);
            this.set('isEmailInspectionOpen', false);
          }, error: (response) => {
            console.log(response);
            alert("There has been in issue sending your report. Please check your fields and try again");
          }
        });
      }
      else {
        alert('Please enter an email address to send a report');
      }
    }
  }
});