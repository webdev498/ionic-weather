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
            var finalBody = { "controlers_inspections_zone": data };
            var zone_id = $('#image-upload-input').attr('data-zone');
            var controllerId = this.get('model').controller_id;
            var api_url = config.apiUrl + "/api/v2/controls/" + controllerId + "/zones/" + zone_id;
            $.ajax({
                type: "POST",
                url: api_url,
                data: finalBody 
            }).done(function() {
               alert("Item saved")
            }).error(function (xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
                alert(thrownError);
            });
            console.log(finalBody);
            //this.transitionToRoute('smartlink-controller.inspections.select-inspection.select-zone');
        },
        openZoneImageView() {
            this.set('isZoneImageViewOpen', true);
        },
        closeZoneImageView() {
            this.set('isZoneImageViewOpen', false);
        },
        saveImage() {
            var self = this;
            this.set('isLoading', true);

            var zone = this.get('model');
            var zone_id = $('#image-upload-input').attr('data-zone');
            var controllerId = this.get('model').controller_id;
            var file = Ember.$('#image-upload-input').get(0).files[0]
            var api_url = config.apiUrl + "/api/v2/controllers/" + controllerId + "/zones/" + zone_id + "/photo";
            var email = self.get('session.data.authenticated.email');
            var password = self.get('session.data.authenticated.password');
            var formData = new FormData($("#image-upload")[0]);
            var uploadZoneImage = function (url, form_data) {
                return new Promise(function (resolve, reject) {
                    var xhr = new XMLHttpRequest;
                    var handler = function () {
                        if (this.readyState == this.DONE) {
                            if (this.status == 201) {
                                formData = null
                                resolve(this.response);
                            }
                            else {
                                reject('getJSON: ' + url + ' failed with status: [' + this.status + this.response + ']');
                            }
                        }
                        return;
                    }
                    xhr.open('POST', api_url);
                    xhr.onreadystatechange = handler;
                    var email = self.get('session.data.authenticated.email');
                    var password = self.get('session.data.authenticated.password');
                    var auth = btoa("#{email}:#{password}");
                    xhr.setRequestHeader("Authorization", "Basic #{auth}");
                    xhr.send(form_data);
                });
            }

            uploadZoneImage(api_url, formData).then((response) => {
                var reader = new FileReader();
                self.set('_uploadedZoneImage', true);
                reader.onload = (e) => {
                    /*if (self.get('model.id') == zoneId) {
                        self.set('model.photo', e.target.result)
                        self.set('model.photoThumbnail', e.target.result)
                        self.set('isZoneImageViewOpen', true)
                        self.set('isLoading', false)
                    }
                    else {
                        oldZone = self.get('model.smartlinkController.zones').findBy('number', zoneNumber)
                        oldZone.set('photo', e.target.result)
                        oldZone.set('photoThumbnail', e.target.result)
                    }*/
                    reader.readAsDataURL(file);
                    self.set('isLoading', false);
                }
            }).catch((err) => {
                console.error(err);
                self.set('isLoading', false);
            });

        }
    }
});
