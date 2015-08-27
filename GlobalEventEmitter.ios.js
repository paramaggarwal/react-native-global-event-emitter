'use strict'

var React = require('react-native');
var {
  NativeModules,
  DeviceEventEmitter,
} = React;

var RNTGlobalEventEmitter = NativeModules.RNTGlobalEventEmitter;

var listeners = {};
DeviceEventEmitter.addListener('onNotification', (data) => {
  var notifName = data.name;
  var notifData = data.userInfo;

  for (var i=0; i<listeners[notifName].length; i++) {
    var listener = listeners[notifName][i];
    listener(notifData);
  };
});

function addListener(eventName, callback) {
  listeners[eventName] = listeners[eventName] ? listeners[eventName].push(callback) : [callback];
  RNTGlobalEventEmitter.addObserver(eventName);
};

function emit(eventName, data) {
  RNTGlobalEventEmitter.postNotification(eventName, data);
};

function removeListener(eventName, callbackRef) {
  var i = listeners[eventName].indexOf(callbackRef);
  if (i != -1) {
    listeners[eventName].splice(i, 1);
  }
  
  if (!listeners[eventName].length) {
    removeAllListeners(eventName);
  };
}

function removeAllListeners(eventName) {
  RNTGlobalEventEmitter.removeObserver(eventName);
  delete listeners[eventName];
  if (!listeners.length) {
      DeviceEventEmitter.removeAllListeners('onNotification');
  };
}

var DeviceMotion = {
  addListener,
  emit,
  removeListener,
  removeAllListeners,
};

DeviceMotion.UIApplicationNotifications = RNTGlobalEventEmitter.UIApplicationNotifications;
DeviceMotion.UIWindowNotifications = RNTGlobalEventEmitter.UIWindowNotifications;
DeviceMotion.UIKeyboardNotifications = RNTGlobalEventEmitter.UIKeyboardNotifications;

module.exports = DeviceMotion;