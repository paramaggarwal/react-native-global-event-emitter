# react-native-global-event-emitter
Shared event emitter between native and JS for React Native.

Uses iOS `NotificationCenter` and RN `DeviceEventEmitter` to provide a seamless global event bus between native and React Native.

## Screenshot

![Screenshot of the example app](https://github.com/paramaggarwal/react-native-global-event-emitter/raw/master/Screenshot.png)

## Usage

```javascript
// 60fps updates
DeviceMotion.startDeviceMotionUpdates(1000/60, (data) => {
  console.log('Raw motion data: ', data);
});

// when done,
DeviceMotion.stopDeviceMotionUpdates();
```

## Properties

* `startDeviceMotionUpdates`: Pass an interval in `ms` and a callback to call with data.
* `stopDeviceMotionUpdates`: Call to stop listening for events.

## Installation

Use your preferred method of including the library in your app. 

## Example
Try the included example:

```sh
git clone git@github.com:paramaggarwal/react-native-device-motion.git
npm install
open iOS/RNTDeviceMotion.xcodeproj
```

Then `Cmd+R` to start the React Packager, build and run the project in the simulator.

## Author
Param Aggarwal (paramaggarwal@gmail.com)

## License
MIT License