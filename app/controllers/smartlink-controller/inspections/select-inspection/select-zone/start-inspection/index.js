import Ember from 'ember';
import ManualRunMixin from '../../../../../../mixins/manual-run';
import Base from 'ember-simple-auth/authenticators/base';
import AuthenticationMixin from '../../../../../../mixins/authentication';
import AjaxMixin from '../../../../../../mixins/ajax';
import config from '../../../../../../config/environment';
import leftPad from '../../../../../../util/strings/left-pad';

var $scope = this;

export default Ember.Controller.extend(AjaxMixin,ManualRunMixin, {
    session: Ember.inject.service(),
    init: function () {
        $('body').on('change', '#image-upload-input', (e) => {
            this.send('saveImage')
            e.preventDefault();
            e.stopPropagation();
            return;
        });

        //running zone code

      var allMins, availHrs, fiveMinIntvls, i, j, results, results1;

      allMins = (function () {
        results = [];
        for (i = 1; i <= 59; i++) {
          results.push(i);
        }
        return results;
      }).apply(this).map(function (num) {
        return {
          label: (0, leftPad)(2, num),
          value: num
        };
      });

      fiveMinIntvls = [];

      (function () {
        results1 = [];
        for (j = 0; j <= 55; j++) {
          results1.push(j);
        }
        return results1;
      }).apply(this).forEach(function (num) {
        if (num % 5 === 0) {
          return fiveMinIntvls.push({
            label: (0, leftPad)(2, num),
            value: num
          });
        }
      }, this);

      availHrs = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map(function (num) {
        return {
          label: (0, leftPad)(2, num),
          value: num
        };
      });

      this.set('allMinutes', allMins);
      this.set('fiveMinuteIntervals', fiveMinIntvls);
      this.set('availableRunTimeHours', availHrs);
      this.set('availableRunTimeMinutes', allMins);

    },
    startCountdown: function startCountdown(min, display) {
      var duration, keepGoing, start, stop, timer;
      if(this.get('showTimer')){
          $(display).css('display', 'block');
          $('.weathermatic-content').css('bottom','50px');
          if (window.cordova) {
            StatusBar.overlaysWebView(true);
          }
          start = Date.now();
          duration = min * 60;
          stop = function () {
            clearInterval($scope.countdown);
            $(display).html(' ').removeClass('close').css('display', 'none');
            if (window.cordova) {
              return StatusBar.overlaysWebView(false);
            }
          };
          keepGoing = function () {
            var diff, minutes, seconds, zone;
            diff = duration - ((Date.now() - start) / 1000 | 0);
            minutes = diff / 60 | 0;
            seconds = diff % 60 | 0;
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;
            zone = $scope.zoneName ? $scope.zoneName + " (Zone " + $scope.zoneNumber + ")" : "Zone " + $scope.zoneNumber;
            $(display).css('display', 'block').attr('href', $scope.zoneLink).html('<div>Running ' + zone + '<span> - ' + minutes + ':' + seconds + '</span></div>');
            if (window.cordova) {
              StatusBar.overlaysWebView(true);
            }
            if (diff <= 0) {
              return stop();
            }
          };
          timer = function () {
            if (!$('.statusBar').hasClass('close')) {
              return keepGoing();
            } else {
              return stop();
            }
          };
          stop();
          timer();
          $scope.countdown = setInterval(timer, 1000);
        }else{
            $('.statusBar').addClass('close');
            $('.weathermatic-content').css('bottom','0px');
        }
    },

    runTimeHours: 0,

    runTimeMinutes: 5,

    minutesDidChange: Ember.observer('runTimeMinutes', function () {
      if (parseInt(this.get('runTimeHours')) === 0) {
        return this.set('previousRunTimeMinutesSelection', this.get('runTimeMinutes'));
      }
    }),

    hoursDidChange: Ember.observer('runTimeHours', function () {
      var prevMin;
      if (parseInt(this.get('runTimeHours')) >= 1) {
        this.set('availableRunTimeMinutes', this.get('fiveMinuteIntervals'));
        return this.set('runTimeMinutes', 0);
      } else {
        prevMin = this.get('previousRunTimeMinutesSelection');
        if (prevMin) {
          this.set('runTimeMinutes', prevMin);
        }
          this.set('availableRunTimeMinutes', this.allMinutes);
      }
    }),

    totalRunTimeMinutesConverted: Ember.computed('runTimeHours', 'runTimeMinutes', function () {
      var extraMins, fiveMinIntvls, hrs, mins, totalMins;
      hrs = parseInt(this.get('runTimeHours'));
      mins = parseInt(this.get('runTimeMinutes'));
      totalMins = hrs * 60 + mins;
      if (totalMins <= 60) {
        return totalMins;
      }
      extraMins = totalMins - 60;
      fiveMinIntvls = Math.floor(extraMins / 5);
      return 60 + fiveMinIntvls;
    }),

    actions: {
        runZone(zoneName,zone){
            var params, self;
            self = this;
            $scope.zone = {};
            $scope.zone.name = zoneName;
            $scope.zone.number = zone;
            $scope.zone.href = location.hash;
            this.set('showTimer',true);
            params = {
              zone: zone,
              run_time: this.get('totalRunTimeMinutesConverted')
            };
            this.get('loadingModal').send('open');
            this.submitManualRun(params).then(function (instruction) {
              Ember.debug("Posted run zone: " + self.get('model.number') + " for controller: " + self.get('model.smartlinkController.id'));
              self.get('loadingModal').send('loadInstruction', instruction);
            })["catch"](function (error) {
              Ember.Logger.error(error);
              self.get('loadingModal').send('close');
            });
        },
        loadingFinished() {
            var self = this;
            $scope.zoneName = $scope.zone.name;
            $scope.zoneNumber = $scope.zone.number;
            $scope.zoneLink = $scope.zone.href;
            this.startCountdown(this.runTimeMinutes, '.statusBar');
            Ember.run.later(this, function () {
              self.get('loadingModal').send('close');
            }, 750);
        },
        loadingAbandoned() {
            $('.statusBar').addClass('close');
        },
        stop: function stop() {
            var params, self;
            self = this;
            this.set('showTimer',false);
            params = {
              run_action: 'manual_stop_program'
            };
            this.get('loadingModal').send('open');
            this.submitManualRun(params).then(function (instruction) {
              self.get('loadingModal').send('loadInstruction', instruction);
            })["catch"](function (error) {
              self.get('loadingModal').send('close');
            });
        },
        submitForm() {
            var $form = $('#inspection-form');
            var params = $form.serializeArray();
            var data = {
                "controllers_inspections_zone": {}
            };
            for (var i = 0; i < params.length; i++) {
                var obj = params[i];
                data[obj.name] = obj.value;
            }
            
            //Store the body in object form, with the final result as a nested object
            var finalBody = {
              "controllers_inspections_zone": data
            }

            var zone_id = this.get('model.id');
            var controllerId = this.get('model').controller_id;
            var inspectionID = this.get('model.inspection.id');
            var api_url = config.apiUrl + "/api/v2/controls/" + controllerId + "/inspections/" + inspectionID + "/zones/" + zone_id;
            console.log(api_url);
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
