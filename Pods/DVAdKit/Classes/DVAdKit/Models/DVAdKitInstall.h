//
//  DVAdKitInstall.h
//  
//
//  Created by ___FULLUSERNAME___ on 5/30/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DVAdKitApp;
@class DVAdKitDevice;
@class DVAdKitImpression;

@interface DVAdKitInstall : NSObject <NSCoding> {
    DVAdKitApp *app;
    NSNumber *appId;
    DVAdKitDevice *device;
    NSNumber *deviceId;
    NSNumber *identifier;
    DVAdKitImpression *impression;
    NSNumber *impressionId;
}

@property (nonatomic, strong) DVAdKitApp *app;
@property (nonatomic, copy) NSNumber *appId;
@property (nonatomic, strong) DVAdKitDevice *device;
@property (nonatomic, copy) NSNumber *deviceId;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, strong) DVAdKitImpression *impression;
@property (nonatomic, copy) NSNumber *impressionId;

+ (DVAdKitInstall *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
