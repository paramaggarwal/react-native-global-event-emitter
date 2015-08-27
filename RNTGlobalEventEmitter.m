//
//  RNTGlobalEventEmitter.m
//  RNTGlobalEventEmitter
//
//  Created by Param Aggarwal on 27/08/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "RNTGlobalEventEmitter.h"
#import "RCTEventDispatcher.h"

@interface RNTGlobalEventEmitter ()

- (void)bridgeNotification:(NSNotification *)notification;

@end

@implementation RNTGlobalEventEmitter

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(addObserver:(NSString *)notificationName)
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(bridgeNotification:)
                                               name:notificationName
                                             object:nil];
}

RCT_EXPORT_METHOD(postNotification:(NSString *)notificationName userInfo:(NSDictionary *)userInfo)
{
  [[NSNotificationCenter defaultCenter] postNotificationName:notificationName
                                                      object:nil
                                                    userInfo:userInfo];
}

RCT_EXPORT_METHOD(removeObserver:(NSString *)notificationName)
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:notificationName
                                                object:nil];
}

- (void)bridgeNotification:(NSNotification *)notification
{
  [self.bridge.eventDispatcher sendDeviceEventWithName:@"onNotification"
                                                  body:@{
                                                         @"name": notification.name,
                                                         @"userInfo": notification.userInfo ?: [NSNull null],
                                                         }];
  
}

- (NSDictionary *)constantsToExport
{
  return @{
           @"UIApplicationNotifications": @{
               @"UIApplicationDidEnterBackgroundNotification": UIApplicationDidEnterBackgroundNotification,
               @"UIApplicationWillEnterForegroundNotification": UIApplicationWillEnterForegroundNotification,
               @"UIApplicationDidFinishLaunchingNotification": UIApplicationDidFinishLaunchingNotification,
               @"UIApplicationDidBecomeActiveNotification": UIApplicationDidBecomeActiveNotification,
               @"UIApplicationWillResignActiveNotification": UIApplicationWillResignActiveNotification,
               @"UIApplicationDidReceiveMemoryWarningNotification": UIApplicationDidReceiveMemoryWarningNotification,
               @"UIApplicationWillTerminateNotification": UIApplicationWillTerminateNotification,
               @"UIApplicationSignificantTimeChangeNotification": UIApplicationSignificantTimeChangeNotification,
               @"UIApplicationWillChangeStatusBarOrientationNotification": UIApplicationWillChangeStatusBarOrientationNotification,
               @"UIApplicationDidChangeStatusBarOrientationNotification": UIApplicationDidChangeStatusBarOrientationNotification,
               @"UIApplicationStatusBarOrientationUserInfoKey": UIApplicationStatusBarOrientationUserInfoKey,
               @"UIApplicationWillChangeStatusBarFrameNotification": UIApplicationWillChangeStatusBarFrameNotification,
               @"UIApplicationDidChangeStatusBarFrameNotification": UIApplicationDidChangeStatusBarFrameNotification,
               },
           @"UIWindowNotifications": @{
               @"UIWindowDidBecomeVisibleNotification": UIWindowDidBecomeVisibleNotification,
               @"UIWindowDidBecomeHiddenNotification": UIWindowDidBecomeHiddenNotification,
               @"UIWindowDidBecomeKeyNotification": UIWindowDidBecomeKeyNotification,
               @"UIWindowDidResignKeyNotification": UIWindowDidResignKeyNotification,
               },
           @"UIKeyboardNotifications": @{
               @"UIKeyboardWillShowNotification": UIKeyboardWillShowNotification,
               @"UIKeyboardDidShowNotification": UIKeyboardDidShowNotification,
               @"UIKeyboardWillHideNotification": UIKeyboardWillHideNotification,
               @"UIKeyboardDidHideNotification": UIKeyboardDidHideNotification,
               @"UIKeyboardWillChangeFrameNotification": UIKeyboardWillChangeFrameNotification,
               @"UIKeyboardDidChangeFrameNotification": UIKeyboardDidChangeFrameNotification,
               },
           };
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
