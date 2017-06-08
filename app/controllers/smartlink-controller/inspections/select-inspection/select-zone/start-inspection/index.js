import Ember from 'ember';
import ManualRunMixin from '../../../../../../mixins/manual-run';
import Base from 'ember-simple-auth/authenticators/base';
import AuthenticationMixin from '../../../../../../mixins/authentication';
import AjaxMixin from '../../../../../../mixins/ajax';
import config from '../../../../../../config/environment';
import leftPad from '../../../../../../util/strings/left-pad';

var $scope = this,
formChanged = false;

export default Ember.Controller.extend(ManualRunMixin, AjaxMixin, {
    session: Ember.inject.service(),
    init: function () {
        this._super();

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

      this.set('currentState', 'Save');
      this.set('allMinutes', allMins);
      this.set('fiveMinuteIntervals', fiveMinIntvls);
      this.set('availableRunTimeHours', availHrs);
      this.set('availableRunTimeMinutes', allMins);

    },

    submitForm: function(path,upcomingZone){
        var $form = $('#inspection-form');
        var disabled = $form.find(':input:disabled').removeAttr('disabled');
        var params = $form.serializeArray();

        if(formChanged){
          this.updateZoneModel();
        }

        disabled.attr('disabled','disabled');

        var $file = $('#image-upload-input').get(0).files[0]

        if(path === "allZones"){
          this.set('currentState', 'Updating Inspection..');
        }else{
          this.set('successMessageClass', 'active');
        }

        var data = {
              "inspection_id": parseFloat(this.get('model.inspection.id')),
              "inspections_photos": $file ? [{
                "lastMod"    : $file.lastModified,
                "lastModDate": $file.lastModifiedDate,
                "name"       : $file.name,
                "size"       : $file.size,
                "type"       : $file.type,
              }] : []

            };
        for (var i = 0; i < params.length; i++) {
            var obj = params[i];
            data[obj.name + ""] = obj.value;
        }
        //Store the body in object form, with the final result as a nested object
        var finalBody = {
          "controls_inspections_zone": data
        };

        var controllerId = this.get('model').controller_id;
        var inspectionID = this.get('model.inspection.id');
        var zone = this.getCurrentInspectionZone();
        var api_url = config.apiUrl + "/api/v2/controls/" + controllerId + "/inspections/" + inspectionID + "/zones/" + zone.id;

        this.ajax(api_url,{
            method: "PUT",
            contentType: 'application/json',
            data: JSON.stringify(finalBody),
            success: (response) => {
              //save model
              this.get('model.inspection').save();

              if(path === 'allZones'){
                this.set('currentState', 'Save');
                this.transitionToRoute('smartlink-controller.inspections.select-inspection.select-zone');
              }else if(path === 'nextZone'){
                this.navigateToZone(upcomingZone,'toLeft');
                this.set('successMessageClass', '');
              }else if(path === 'prevZone'){
                this.navigateToZone(upcomingZone,'toRight');
                this.set('successMessageClass', '');
              }
            }, error: (response) => {
              if(path === 'allZones'){
                this.set('currentState', 'Save');
              }
            }
        })
    },

    navigateToZone: function(zone,direction){
      this.set('transition', direction);
      this.transitionToRoute('smartlink-controller.inspections.select-inspection.select-zone.start-inspection', zone);
    },

    zoneChanged: function() {
      var zoneNumber = this.getCurrentInspectionZone().zone_number,
      zone = this.getCurrentZone();
      formChanged = false;

      //get zone name
      this.set('zoneName',zone.get('description'));

      //program settings
      this.set('progA', this.get('model.programs.canonicalState')[0]._data.formattedRunTime);
      this.set('progB', this.get('model.programs.canonicalState')[1]._data.formattedRunTime);
      this.set('progC', this.get('model.programs.canonicalState')[2]._data.formattedRunTime);
      this.set('progD', this.get('model.programs.canonicalState')[3]._data.formattedRunTime);

      //zone previous and next button
      this.set('zoneNumber', 'Zone ' + zoneNumber);
      this.set('prevZone', this.getInspectionZone(zoneNumber - 1).zone_id);
      this.set('nextZone', this.getInspectionZone(zoneNumber + 1).zone_id);
    }.observes('model.inspectionZone'),

    updateZoneModel: function(){
      let currentZone = this.getCurrentZone();
      Ember.set(currentZone,'status','complete');
    },

    //get current zone
    getCurrentZone: function(){
      return this.get('model.zones')[0];
    },

    //get current inspection zone
    getCurrentInspectionZone: function(){
      return this.get('model.inspectionZone')[0];
    },

    //get any inspection zone
    getInspectionZone: function(zoneNumber){
      let $this = this,
      zone = this.get('model.inspection.inspections_zones').filter(function(zone,index){
        return zone.zone_number === parseInt(zoneNumber);
      });
      return zone.length ? zone[0] : {};
    },

    navigateBack: function(buttonIndex){
      if(buttonIndex === 1){
        this.transitionToRoute('smartlink-controller.inspections.select-inspection.select-zone');
      }
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
        handleChange(e){
          //get current zone
          let zone = this.getCurrentInspectionZone();
          //update model subtractValue
          Ember.set(zone,event.target.name,event.target.value);
          formChanged = true;
        },
        prevZone(zone){
          if(formChanged){
            this.submitForm('prevZone', zone);
          }else{
            this.navigateToZone(zone,'toRight');
          }
        },
        nextZone(zone){
          if(formChanged){
            this.submitForm('nextZone', zone);
          }else{
            this.navigateToZone(zone,'toLeft');
          }
        },
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
        promptDisclaimer(){
          let disclaimer = "By pressing cancel, you will be erasing the values you've entered into this inspection";

          if(formChanged){
            navigator.notification.confirm(disclaimer, this.navigateBack.bind(this), "Warning")
          }else {
            this.transitionToRoute('smartlink-controller.inspections.select-inspection.select-zone');
          }
        },
        sendForm() {
          this.submitForm('allZones');
        },
        addValue(prop,value){
          //add 1 to value
          let val = parseInt(value) + 1,
          //get current zone
          zone = this.getCurrentInspectionZone();
          //update model value
          Ember.set(zone,prop, val);
          //form has changed
          formChanged = true;
        },
        subtractValue(prop,value){
          //subtract 1 to value
          let val = (parseInt(value) > 0) ? parseInt(value) - 1 : 0,
          //get current zone
          zone = this.getCurrentInspectionZone();
          //update model value
          Ember.set(zone,prop,val);
          //form has changed
          formChanged = true;
        },
        openZoneImageView() {
            var zone = this.getCurrentInspectionZone().inspections_photos.reverse();
            this.set('zone_photos', zone);
            this.set('isZoneImageViewOpen', true);
        },
        closeZoneImageView() {
            this.set('isZoneImageViewOpen', false);
        },
        saveImage() {
            var self = this;
            var file = Ember.$('#image-upload-input').get(0).files[0]
            var reader = new FileReader();
            var zone = this.getCurrentInspectionZone();
            this.set('isLoading', true);

            reader.onload = function(e){
              Ember.set(zone,'temp_photo',e.target.result);
            }

            reader.readAsDataURL(file)

            var zone = this.get('model');
            var zone_id = $('#image-upload-input').attr('data-zone');
            var controllerId = this.get('model').controller_id;
            var inspectionId = this.get('model.inspection.id');

            var zone = this.getCurrentInspectionZone();
            var api_url = config.apiUrl + "/api/v2/controls/" + controllerId + "/inspections/"+inspectionId+"/zones/" + zone.id + "/photos.json";
            var email = self.get('session.data.authenticated.email');
            var password = self.get('session.data.authenticated.password');
            var formData = new FormData();
            formData.append('inspections_photo[image]',file);
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
                    var auth = btoa(email+":"+password);
                    xhr.setRequestHeader("Authorization", "Basic " + auth);
                    xhr.send(form_data);
                    return;
                });
            }
            StatusBar.overlaysWebView(true)
            StatusBar.overlaysWebView(false)
            uploadZoneImage(api_url, formData)
        }
    }
});
