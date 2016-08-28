import Ember from 'ember';
import Instruction from '../models/instruction';
import AjaxMixin from './ajax';
import config from '../config/environment';

const ManualRunMixin = Ember.Mixin.create(AjaxMixin, {

  smartlinkControllerController: Ember.inject.controller('smartlink-controller'),

  store: Ember.inject.service('store:main'),

  smartlinkController: Ember.computed.alias('smartlinkControllerController.model'),

  timeoutThresholdMillis: 20000,

  url: Ember.computed('smartlinkController.id', function() {
    return config.apiUrl + "/api/v2/controllers/" + (this.get('smartlinkController.id')) + "/manual_run";
  }),

  submitManualRun(manualRunParams) {
    var timeoutWatcher = null;
    const self = this;
    const defaultParams = {
      run_action: 'start'
    };
    const allParams = Ember.merge(defaultParams, manualRunParams);
    const url = this.get('url');
    const defaultErrorMessage = 'There was a problem communicating with your device. Please try again later';
    const manualRunPromise = new Ember.RSVP.Promise( (resolve, reject) => {
      var ajaxOptions;
      timeoutWatcher = Ember.run.later(this, () => {
        return reject(new Error(defaultErrorMessage));
      }, this.timeoutThresholdMillis);
      ajaxOptions = {
        type: 'POST',
        data: allParams,
        success: (response) => {
          if (Ember.get(response, 'meta.success')) {
            this.get('store').pushPayload('instruction', response.result);
            const instruction = self.get('store').find('instruction', response.result.instruction.id);
            return resolve(instruction);
          } else {
            const message = Ember.get(response, 'result.instruction.exception');
            return reject(new Error(message));
          }
        },
        error() {
          return reject(new Error(defaultErrorMessage));
        }
      };
      return this.ajax(url, ajaxOptions);
    });
    manualRunPromise.finally( () => {
      if (timeoutWatcher) {
        return Ember.run.cancel(timeoutWatcher);
      }
    });
    return manualRunPromise;
  }
});

export default ManualRunMixin;
