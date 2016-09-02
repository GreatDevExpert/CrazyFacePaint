//
//  FiksuAttributionPlugin.h
//  FiksuSDK
//
//  Copyright (c) 2014 Fiksu, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const FiksuURLHandledNotification;
extern NSString *const FiksuURLHandledURLKey;
extern NSString *const FiksuURLHandledSourceApplicationKey;
extern NSString *const FiksuURLSchemePrefix;

typedef void (^AttributionBlock)(BOOL, NSDictionary *);

@protocol FiksuAttributionPlugin <NSObject>

+ (NSString *)pluginVersion;

- (void)attemptAttributionForApp:(NSString *)appId completion:(AttributionBlock)attributionBlock;

@end
