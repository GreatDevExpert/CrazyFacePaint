//
//  NFDevice.h
//  Cupcake
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFAccelerometer.h"
#import "NFMotionManager.h"
#import "NFTouchHandler.h"
#import "NFLocalPushNotification.h"

@interface NFDevice : NSObject

typedef void (^ NFDeviceCompletionHandler)(BOOL finished);

+(NFDevice *)sharedInstance;
-(void)vibrateForDuration:(float)duration completionHandler:(NFDeviceCompletionHandler)completionHandler;

-(void)vibrate;

+(BOOL)isRetina;

@end
