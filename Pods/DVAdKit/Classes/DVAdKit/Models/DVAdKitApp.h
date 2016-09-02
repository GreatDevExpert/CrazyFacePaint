//
//  DVAdKitApp.h
//
//
//  Created by ___FULLUSERNAME___ on 6/14/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVAdKitApp : NSObject <NSCoding> {
    NSMutableArray *adLogics;
    NSString *appKey;
    NSString *appStoreLink;
    NSNumber *appleId;
    NSString *bundleIdentifier;
    NSNumber *companyId;
    NSString *createdAt;
    NSString *iconImageLink;
    NSNumber *identifier;
    BOOL isKidsApp;
    NSString *name;
    NSString *orientation;
    NSString *uniqueToken;
    NSString *updatedAt;
    NSString *urlScheme;
}

@property (nonatomic, copy) NSMutableArray *adLogics;
@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appStoreLink;
@property (nonatomic, copy) NSNumber *appleId;
@property (nonatomic, copy) NSString *bundleIdentifier;
@property (nonatomic, copy) NSNumber *companyId;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *iconImageLink;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, assign) BOOL isKidsApp;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *orientation;
@property (nonatomic, copy) NSString *uniqueToken;
@property (nonatomic, copy) NSString *updatedAt;
@property (nonatomic, copy) NSString *urlScheme;

+ (DVAdKitApp *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
