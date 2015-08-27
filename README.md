# react-native-global-event-emitter
Shared event emitter between native and JS for React Native.

Uses iOS `NotificationCenter` and RN `DeviceEventEmitter` to provide a seamless global event bus between native and React Native.

## Screenshot

![Screenshot of the example app](https://github.com/paramaggarwal/react-native-global-event-emitter/raw/master/Screenshot.png)

## Usage

```javascript

// listen to event posted to NSNotificationCenter by native code
var eventName = GlobalEventEmitter.UIApplicationNotifications.UIApplicationDidEnterBackgroundNotification;
GlobalEventEmitter.addListener(eventName, (data) => {
    console.log('UIApplicationDidEnterBackgroundNotification');
});

// event available on NSNotificationCenter for native code
var eventName = "UserDidLoginFromJS"
GlobalEventEmitter.emit(eventName, {name: 'John'});

```

## Properties

* `addListener`: Add a listener for an `eventName` and pass a `callback` function.
* `emit`: Emit events to native/JS globally.
* `removeListener`: Remove a listener by passing the `eventName` and the reference to the original `callback` function.
* `removeAllListeners`: Stop listening to all events of a particular `eventName`.

## Installation

Use your preferred method of including the library in your app. 

## Example
Try the included example:

```sh
git clone git@github.com:paramaggarwal/react-native-global-event-emitter.git
npm install
open iOS/RNTGlobalEventEmitter.xcodeproj
```

Then `Cmd+R` to start the React Packager, build and run the project in the simulator.

## Author
Param Aggarwal (paramaggarwal@gmail.com)

## License
MIT License