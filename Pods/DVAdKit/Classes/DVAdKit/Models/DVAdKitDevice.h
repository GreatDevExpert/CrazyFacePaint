//
//  DVAdKitDevice.h
//
//
//  Created by ___FULLUSERNAME___ on 5/30/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVAdKitDevice : NSObject <NSCoding> {
    NSString *advertisingIdentifier;
    NSString *countryCode;
    NSString *createdAt;
    NSString *deviceType;
    NSNumber *identifier;
    NSString *identifierForVendor;
    NSString *model;
    NSString *openUdid;
    NSString *osVersion;
    NSString *screenScale;
    NSString *updatedAt;
}

@property (nonatomic, copy) NSString *advertisingIdentifier;
@property (nonatomic, copy) NSString *countryCode;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *deviceType;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *identifierForVendor;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *openUdid;
@property (nonatomic, copy) NSString *osVersion;
@property (nonatomic, copy) NSString *screenScale;
@property (nonatomic, copy) NSString *updatedAt;

+ (DVAdKitDevice *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
