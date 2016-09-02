//
//  DVAdKitAd.h
//
//
//  Created by ___FULLUSERNAME___ on 5/31/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DVAdKitApp;

@interface DVAdKitAd : NSObject <NSCoding> {
    NSString *adImageLink;
    DVAdKitApp *app;
    NSNumber *appId;
    NSString *createdAt;
    NSMutableArray *creatives;
    NSNumber *identifier;
    NSString *orientation;
    NSString *updatedAt;
}

@property (nonatomic, copy) NSString *adImageLink;
@property (nonatomic, strong) DVAdKitApp *app;
@property (nonatomic, copy) NSNumber *appId;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSMutableArray *creatives;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *orientation;
@property (nonatomic, copy) NSString *updatedAt;

+ (DVAdKitAd *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
