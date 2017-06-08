import Ember from 'ember';
import ManualRunMixin from '../../../../mixins/manual-run';
import Base from 'ember-simple-auth/authenticators/base';
import AuthenticationMixin from '../../../../mixins/authentication';
import AjaxMixin from '../../../../mixins/ajax';
import config from '../../../../config/environment';

export default Ember.Controller.extend(ManualRunMixin, AjaxMixin, {
  session: Ember.inject.service(),
  isEmailInspectionOpen: false,
  validateEmail: function(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
  },
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

      var emails = data.emails.split(",")
      var emailValid = emails.length !== 0;

      for(var i=0;i<emails.length;i++){
        emailValid = this.validateEmail(emails[i]) && emailValid;
      }


      if (data.emails && emailValid) {
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
            alert("Report has been sent");
            this.set('isEmailInspectionOpen', false);
          }, error: (response) => {
            console.log(response);
            alert("There has been in issue sending your report. Please check your fields and try again");
          }
        });
      }
      else if(!data.emails) {
        alert('Please enter an email address to send a report');
      }
      else if (!emailValid){
        alert("This email(s) that you've entered aren't valid")
      }
    }
  }
});