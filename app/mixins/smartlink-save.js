import Ember from 'ember';
import Instruction from '../models/instruction';
import config from '../config/environment';
import AjaxMixin from './ajax';

const buildErrors = function(response) {
  return Ember.get(response, 'meta.errors') || [
    {
      _default: defaultErrorMessage
    }
  ];
};

const defaultErrorMessage = 'There was a problem communicating with our servers. Please try again later';

const SmartlinkSaveMixin = Ember.Mixin.create(AjaxMixin, {
  errors: {},

  defaultTimeoutThresholdMillis: 20000,

  defaultInstructionPollingInterval: 1000,

  defaultSaveMessage: 'Your changes have been saved to SmartLink Network, but will still need to be transmitted to your controller to take effect.',

  baseUrl: config.apiUrl,

  openLoadingModal(message) {
    if (!this.get('loadingModal')) {
      Ember.Logger.debug('Cannot open loading modal, loadingModal does not exist!');
      return;
    }
    return this.get('loadingModal').send('open', message);
  },

  closeLoadingModal() {
    if (!this.get('loadingModal')) {
      Ember.Logger.debug('Cannot close loading modal, loadingModal does not exist!');
      return;
    }
    return this.get('loadingModal').send('close');
  },

  errorMessages: Ember.computed('errors', function() {
    const messages = [];
    Ember.$.each(this.get('errors'), (field, errors) => {
      const name = Ember.String.capitalize(field.split('_').join(' '));
      return errors.forEach( (msg) => {
        return messages.push(name + " " + msg);
      });
    });
    return messages;
  }),

  save(options) {
    var instructionStatusPoller, saveMessage, timeoutWatcher;
    if (options == null) {
      options = {};
    }
    if (options.saveMessage === false) {
      saveMessage = '';
    } else {
      saveMessage = options.saveMessage || this.defaultSaveMessage;
    }
    if (options.showLoadingModal !== false) {
      this.openLoadingModal(saveMessage);
    }
    if (options.params == null) {
      options.params = {};
    }
    const timeoutThresholdMillis = options.timeoutThresholdMillis || this.defaultTimeoutThresholdMillis;
    const allParams = Ember.merge(options.params, {
      timestamp: new Date().getTime()
    });
    const httpMethod = options.httpMethod || 'PATCH';
    const savePromise = new Ember.RSVP.Promise( (resolve, reject) => {
      timeoutWatcher = Ember.run.later(this, () => {
        return reject(new Error(options.errorMessage || defaultErrorMessage));
      }, timeoutThresholdMillis);
      const ajaxOptions = {
        type: httpMethod,
        data: JSON.stringify(allParams),
        dataType: 'json',
        contentType: 'application/json',
        success(response) {
          Ember.Logger.debug("Save, server responsed with success: ", response);
          if (Ember.get(response, 'meta.success')) {
            return resolve(response);
          } else {
            return reject(buildErrors(response));
          }
        },
        error(xhr) {
          return reject(buildErrors(xhr.responseJSON));
        }
      };
      Ember.Logger.debug(`Save - ${httpMethod}: ${options.url}, ajax options:`, ajaxOptions);
      this.ajax(options.url, ajaxOptions);
    });
    savePromise.then( (response) => {
      this.set('errors', {});
      const loadingModal = this.get('loadingModal');
      if (options.pollInstructionStatus) {
        const pollingIntervalMillis = options.pollingIntervalMillis || this.defaultInstructionPollingInterval;
        this.get('store').pushPayload('instruction', response.result);
        return this.get('store').find('instruction', response.result.instruction.id).then( (instruction) => {
          return this.pollInstructionStatus(pollingIntervalMillis, instruction);
        });
      }
      if (options.successRoute != null) {
        this.transitionToRoute(options.successRoute, options.successModel);
        return;
      }
      if (loadingModal != null) {
        return loadingModal.send('finished');
      } else {
        return Ember.Logger.debug('Cannot send finished action to loading modal, loadingModal does not exist!');
      }
    }).catch( (errors) => {
      Ember.Logger.error('SmartlinkSaveMixin.save() save promise encountered error(s): ', errors);
      this.closeLoadingModal();
      if (!options.pollInstructionStatus) {
        return this.set('errors', errors);
      }
    }).finally( () => {
      if (timeoutWatcher) {
        Ember.run.cancel(timeoutWatcher);
      }
      if (instructionStatusPoller) {
        return Ember.run.cancel(instructionStatusPoller);
      }
    });
    return savePromise;
  },

  saveAll(options) {
    var allPromises, httpMethod, saveMessage, timeoutThresholdMillis;
    if (options == null) {
      options = [];
    }
    if (options.saveMessage === false) {
      saveMessage = '';
    } else {
      saveMessage = options.saveMessage || this.defaultSaveMessage;
    }
    this.openLoadingModal(saveMessage);
    if (options.params == null) {
      options.params = {};
    }
    timeoutThresholdMillis = options.timeoutThresholdMillis || this.defaultTimeoutThresholdMillis;
    httpMethod = options.httpMethod || 'PATCH';
    allPromises = Ember.RSVP.all(options.map( (opts) => {
      var savePromise, timeoutWatcher;
      timeoutWatcher = null;
      savePromise = new Ember.RSVP.Promise( (resolve, reject) => {
        var ajaxOptions, allParams;
        timeoutWatcher = Ember.run.later(this, () => {
          return reject(new Error(opts.errorMessage || options.errorMessage || defaultErrorMessage));
        }, timeoutThresholdMillis);
        allParams = Ember.merge(opts.params, {
          timestamp: new Date().getTime()
        });
        ajaxOptions = {
          type: httpMethod,
          data: JSON.stringify(allParams),
          dataType: 'json',
          contentType: 'application/json',
          success(response) {
            Ember.Logger.debug("Save, server responsed with success: ", response);
            if (Ember.get(response, 'meta.success')) {
              return resolve(response);
            } else {
              return reject(buildErrors(response));
            }
          },
          error(xhr) {
            return reject(buildErrors(xhr.responseJSON));
          }
        };
        Ember.Logger.debug("SaveAll - " + httpMethod + ": " + opts.url + ", ajax options:", ajaxOptions);
        this.ajax(opts.url, ajaxOptions);
      });
      savePromise.finally( () => {
        if (timeoutWatcher) {
          return Ember.run.cancel(timeoutWatcher);
        }
      });
      return savePromise;
    }));
    allPromises.then( (results) => {
      this.set('errors', {});
      if (options.successRoute != null) {
        return this.transitionToRoute(options.successRoute, options.successModel);
      } else {
        if (this.get('loadingModal') != null) {
          return this.get('loadingModal').send('finished');
        } else {
          return Ember.Logger.debug('Cannot send finished action to loading modal, loadingModal does not exist!');
        }
      }
    }).catch( (errors) => {
      Ember.Logger.error('SmartlinkSaveMixin.saveAll(), save promise encountered error(s): ', errors);
      this.closeLoadingModal();
      return this.set('errors', errors);
    });
    return allPromises;
  },

  pollInstructionStatus(delayMillis, instruction) {
    var loadingModal, statusId;
    delayMillis = delayMillis || this.defaultInstructionPollingInterval;
    statusId = Ember.get(instruction, 'statusId');
    loadingModal = this.get('loadingModal');
    Ember.Logger.debug('Polling instruction status: ', statusId);
    switch (statusId) {
      case Instruction.STATUS_ERROR:
        Ember.Logger.error("Instruction failed", instruction);
        alert("There was a problem communicating with your device. Please try again later.");
        return this.closeLoadingModal();
      case Instruction.STATUS_FINISHED:
        Ember.Logger.debug('Instruction finished successfully', instruction);
        instruction.set('controller.hasUnsentChanges', false);
        if (loadingModal != null) {
          loadingModal.send('finished');
        }
        break;
      default:
        return instruction.reload().then( (instruction) => {
          return Ember.run.later(this, this.pollInstructionStatus, delayMillis, instruction, delayMillis);
        });
    }
  },

  transmitUrl(smartlinkControllerId) {
    return config.apiUrl + "/api/v2/controllers/" + smartlinkControllerId + "/transmit";
  },

  receiveUrl(smartlinkControllerId) {
    return config.apiUrl + "/api/v2/controllers/" + smartlinkControllerId + "/receive";
  },

  actions: {
    loadingAbandoned() {
      return this.closeLoadingModal();
    },

    loadingFinished() {
      return this.closeLoadingModal();
    },

    transmit(smartlinkController) {
      Ember.Logger.debug('SmartlinkSaveMixin transmit action called, with smartlink controller:', smartlinkController);
      return this.save({
        url: this.transmitUrl(smartlinkController.get('id')),
        pollInstructionStatus: true,
        saveMessage: 'Successfully saved your settings to the Smartlink controller'
      }).catch( (errors) => {
        return alert(errors.join('. '));
      });
    },

    receive(smartlinkController) {
      Ember.Logger.debug('SmartlinkSaveMixin receive action called, with smartlink controller', smartlinkController);
      return this.save({
        url: this.receiveUrl(smartlinkController.get('id')),
        pollInstructionStatus: true,
        saveMessage: 'Successfully received settings from your Smartlink controller'
      }).then( () => {
        return smartlinkController.set('hasUnsentChanges', false);
      }).catch( (errors) => {
        return alert(errors.join('. '));
      });
    }
  }
});

export default SmartlinkSaveMixin;
