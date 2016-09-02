//
//  FiksuTrackingManager.h
//
//  Copyright 2014 Fiksu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FiksuSDK/FiksuAttributionPlugin.h>

typedef enum {
  FiksuRegistrationEvent1,
  FiksuRegistrationEvent2,
  FiksuRegistrationEvent3
} FiksuRegistrationEvent;

typedef enum {
  FiksuPurchaseEvent1,
  FiksuPurchaseEvent2,
  FiksuPurchaseEvent3,
  FiksuPurchaseEvent4,
  FiksuPurchaseEvent5
} FiksuPurchaseEvent;

@interface FiksuTrackingManager : NSObject

+ (void)applicationDidFinishLaunching:(NSDictionary *)launchOptions;

+ (void)setClientID:(NSString *)clientID;
+ (NSString *)clientID;

+ (void)setAppTrackingEnabled:(BOOL)enabled;
+ (BOOL)isAppTrackingEnabled;

+ (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;

+ (void)uploadRegistration:(FiksuRegistrationEvent)event;

+ (void)uploadPurchase:(FiksuPurchaseEvent)event
                 price:(double)price
              currency:(NSString *)currency;

+ (void)uploadCustomEvent;

+ (void)displayAdInSuperview:(UIView *)superView withinFrame:(CGRect)frame;

+ (void)setAttributionPlugin:(NSObject<FiksuAttributionPlugin> *)plugin;
+ (NSObject<FiksuAttributionPlugin> *)attributionPlugin;

@end

@interface FiksuTrackingManager (Deprecated)

+ (void)uploadRegistrationEvent:(NSString *)username __attribute__((deprecated));

+ (void)uploadPurchaseEvent:(NSString *)username
                   currency:(NSString *)currency     __attribute__((deprecated));

+ (void)uploadPurchaseEvent:(NSString *)username
                      price:(double)price
                   currency:(NSString *)currency     __attribute__((deprecated));
@end

@interface FiksuTrackingManager (Private)

+ (void)uploadEvent:(NSString *)event
           withInfo:(NSDictionary *)eventInfo        __attribute__((deprecated));
@end
