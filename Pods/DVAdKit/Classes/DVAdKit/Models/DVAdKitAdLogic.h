//
//  DVAdKitAdLogic.h
//  
//
//  Created by ___FULLUSERNAME___ on 6/5/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVAdKitAdLogic : NSObject <NSCoding> {
    NSNumber *appId;
    NSString *createdAt;
    NSNumber *identifier;
    NSNumber *maxPerDay;
    NSNumber *maxPerHour;
    NSString *updatedAt;
    NSString *zone;
}

@property (nonatomic, copy) NSNumber *appId;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSNumber *maxPerDay;
@property (nonatomic, copy) NSNumber *maxPerHour;
@property (nonatomic, copy) NSString *updatedAt;
@property (nonatomic, copy) NSString *zone;

+ (DVAdKitAdLogic *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
