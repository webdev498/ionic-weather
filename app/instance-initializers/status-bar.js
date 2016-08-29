import Ember from 'ember';

{ Logger: { error } } = EMber;

const initialize = function(_app) {
  if (typeof window.cordova === 'undefined') {
    return;
  }
  const configureStatusBar = function() {
    if (typeof StatusBar === 'undefined') {
      error('Cannot configure status bar, missing StatusBar global (cordova status bar plugin installed?)');
      return;
    }
    StatusBar.styleBlackOpaque();
    return StatusBar.backgroundColorByHexString('000000');
  };
  return document.addEventListener('deviceready', configureStatusBar, false);
};

const StatusBarInitializer = {
  name: 'status-bar',
  initialize,
};

export {initialize};

export default StatusBarInitializer;
