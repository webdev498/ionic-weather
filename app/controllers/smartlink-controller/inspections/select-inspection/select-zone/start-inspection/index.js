import Ember from 'ember';
import ManualRunMixin from '../../../../../../mixins/manual-run';
import Base from 'ember-simple-auth/authenticators/base';
import AuthenticationMixin from '../../../../../../mixins/authentication';
import AjaxMixin from '../../../../../../mixins/ajax';
import config from '../../../../../../config/environment';

export default Ember.Controller.extend(AjaxMixin, {
    session: Ember.inject.service(),
    init: function () {
        $('body').on('change', '#image-upload-input', (e) => {
            this.send('saveImage')
            e.preventDefault();
            e.stopPropagation();
            return;
        });
    },
    actions: {
        submitForm() {
            var $form = $('#inspection-form');
            var params = $form.serializeArray();
            var data = {};
            for (var i = 0; i < params.length; i++) {
                var obj = params[i];
                data[obj.name] = obj.value;
            }
            console.log(data);
        },
        saveImage() {
            var self = this;
            self.set('isLoading', true);

            var zone = this.get('model');
            var zone_id = $('#image-upload-input').attr('data-zone');
            var controllerId = this.get('model').controller_id;
            var file = Ember.$('#image-upload-input').get(0).files[0]
            var api_url = config.apiUrl + "/api/v2/controllers/" + controllerId + "/zones/" + zone_id + "/photo";
            var email = self.get('session.data.authenticated.email');
            var password = self.get('session.data.authenticated.password');
            var formData = new FormData(document.querySelector("#image-upload"));
            $.ajax({
                // Your server script to process the upload
                url: api_url,
                type: 'POST',

                // Form data
                data: formData,
                username: email,
                password: password,

                // Tell jQuery not to process data or worry about content-type
                // You *must* include these options!
                cache: false,
                contentType: false,
                processData: false,

                // Custom XMLHttpRequest
                xhr: function () {
                    var myXhr = $.ajaxSettings.xhr();
                    if (myXhr.upload) {
                        // For handling the progress of the upload
                        myXhr.upload.addEventListener('progress', function (e) {
                            if (e.lengthComputable) {
                                $('progress').attr({
                                    value: e.loaded,
                                    max: e.total,
                                });
                            }
                        }, false);
                    }
                    return myXhr;
                },
            });
        }
    }

})
