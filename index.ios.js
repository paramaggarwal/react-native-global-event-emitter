/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
} = React;

var GlobalEventEmitter = require('./GlobalEventEmitter.ios.js');

var RNTGlobalEventEmitter = React.createClass({
  getInitialState: function () {
    return {
      events: []
    };
  },

  appendEvent: function (e) {
    this.setState((prevState) => {
      return {
        events: prevState.events.concat([e])
      };
    })
  },

  componentDidMount: function () {
    GlobalEventEmitter.addListener(GlobalEventEmitter.UIApplicationNotifications.UIApplicationDidEnterBackgroundNotification, (data) => {
      this.appendEvent('UIApplicationDidEnterBackgroundNotification');
    });
    GlobalEventEmitter.addListener(GlobalEventEmitter.UIApplicationNotifications.UIApplicationWillEnterForegroundNotification, (data) => {
      this.appendEvent('UIApplicationWillEnterForegroundNotification');
    });
    GlobalEventEmitter.addListener(GlobalEventEmitter.UIApplicationNotifications.UIApplicationDidBecomeActiveNotification, (data) => {
      this.appendEvent('UIApplicationDidBecomeActiveNotification');
    });
    GlobalEventEmitter.addListener(GlobalEventEmitter.UIApplicationNotifications.UIApplicationWillResignActiveNotification, (data) => {
      this.appendEvent('UIApplicationWillResignActiveNotification');
    });
  },

  render: function() {
    var events = this.state.events;
    console.log(events);
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Global Event Emitter for React Native
        </Text>
        <Text style={styles.instructions}>
          This app shows native events whenever app becomes inactive/active below.
        </Text>
        <View style={styles.space}>
          {events.map((e, i) => <Text>{i+1}.: {e}</Text>)}
        </View>
        <Text style={styles.instructions}>
          Try closing and reopening the app a few times.
        </Text>
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    // alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  space: {
    margin: 10
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('RNTGlobalEventEmitter', () => RNTGlobalEventEmitter);
