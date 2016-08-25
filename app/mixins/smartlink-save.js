import Ember from 'ember';
import Instruction from '../models/instruction';
import config from '../config/environment';

const buildErrors = function(response) {
  return Ember.get(response, 'meta.errors') || [
    {
      _default: defaultErrorMessage
    }
  ];
};

const defaultErrorMessage = 'There was a problem communicating with our servers. Please try again later';

const SmartlinkSaveMixin = Ember.Mixin.create({
  session: Ember.inject.service(),

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
    Ember.$.each(this.get('errors'), function(field, errors) {
      const name = Ember.String.capitalize(field.split('_').join(' '));
      return errors.forEach(function(msg) {
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
      timeoutWatcher = Ember.run.later(this, function() {
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
    savePromise.then(function(response) {
      var loadingModal, pollingIntervalMillis;
      self.set('errors', {});
      loadingModal = self.get('loadingModal');
      if (options.pollInstructionStatus) {
        pollingIntervalMillis = options.pollingIntervalMillis || self.defaultInstructionPollingInterval;
        self.get('store').pushPayload('instruction', response.result);
        return self.get('store').find('instruction', response.result.instruction.id).then(function(instruction) {
          return self.pollInstructionStatus(pollingIntervalMillis, instruction);
        });
      }
      if (options.successRoute != null) {
        self.transitionToRoute(options.successRoute, options.successModel);
        return;
      }
      if (loadingModal != null) {
        return loadingModal.send('finished');
      } else {
        return Ember.Logger.debug('Cannot send finished action to loading modal, loadingModal does not exist!');
      }
    }).catch( (errors) => {
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
    var allPromises, httpMethod, saveMessage, self, timeoutThresholdMillis;
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
    allPromises = Ember.RSVP.all(options.map(function(opts) {
      var savePromise, timeoutWatcher;
      timeoutWatcher = null;
      savePromise = new Ember.RSVP.Promise(function(resolve, reject) {
        var ajaxOptions, allParams;
        timeoutWatcher = Ember.run.later(this, function() {
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
          success: function(response) {
            Ember.Logger.debug("Save, server responsed with success: ", response);
            if (Ember.get(response, 'meta.success')) {
              return resolve(response);
            } else {
              return reject(buildErrors(response));
            }
          },
          error: function(xhr) {
            return reject(buildErrors(xhr.responseJSON));
          }
        };
        Ember.Logger.debug("Save - " + httpMethod + ": " + options.url + ", ajax options:", ajaxOptions);
        this.ajax(options.url, ajaxOptions);
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
      this.closeLoadingModal();
      return this.set('errors', errors);
    });
    return allPromises;
  },

  pollInstructionStatus: function(delayMillis, instruction) {
    var loadingModal, self, statusId;
    delayMillis = delayMillis || this.defaultInstructionPollingInterval;
    statusId = Ember.get(instruction, 'statusId');
    loadingModal = this.get('loadingModal');
    self = this;
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
        return instruction.reload().then(function(instruction) {
          return Ember.run.later(self, self.pollInstructionStatus, delayMillis, instruction, delayMillis);
        });
    }
  },

  ajax(url, options) {
    this.get('session').authorize('authorizer:weathermatic', (headerName, headerValue) => {
      const authHeaders = {};
      authHeaders[headerName] = headerValue;
      Ember.$.ajax(url, Ember.merge(options, { headers: authHeaders }));
    });
  },

  transmitUrl: function(smartlinkControllerId) {
    return config.apiUrl + "/api/v2/controllers/" + smartlinkControllerId + "/transmit";
  },

  receiveUrl: function(smartlinkControllerId) {
    return config.apiUrl + "/api/v2/controllers/" + smartlinkControllerId + "/receive";
  },

  actions: {
    loadingAbandoned: function() {
      return this.closeLoadingModal();
    },
    loadingFinished: function() {
      return this.closeLoadingModal();
    },
    transmit: function(smartlinkController) {
      Ember.Logger.debug('SmartlinkSaveMixin transmit action called, with smartlink controller:', smartlinkController);
      return this.save({
        url: this.transmitUrl(smartlinkController.get('id')),
        pollInstructionStatus: true,
        saveMessage: 'Successfully saved your settings to the Smartlink controller'
      })["catch"](function(errors) {
        return alert(errors.join('. '));
      });
    },
    receive: function(smartlinkController) {
      Ember.Logger.debug('SmartlinkSaveMixin receive action called, with smartlink controller', smartlinkController);
      return this.save({
        url: this.receiveUrl(smartlinkController.get('id')),
        pollInstructionStatus: true,
        saveMessage: 'Successfully received settings from your Smartlink controller'
      }).then((function(_this) {
        return function() {
          return smartlinkController.set('hasUnsentChanges', false);
        };
      })(this))["catch"](function(errors) {
        return alert(errors.join('. '));
      });
    }
  }
});

export default SmartlinkSaveMixin;
