//
//  DVAdKitCreative.h
//  
//
//  Created by ___FULLUSERNAME___ on 5/31/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVAdKitCreative : NSObject <NSCoding> {
    NSString *adImageLink;
    NSString *frameImageLink;
    NSNumber *identifier;
    NSString *model;
    NSString *orientation;
}

@property (nonatomic, copy) NSString *adImageLink;
@property (nonatomic, copy) NSString *frameImageLink;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *orientation;

+ (DVAdKitCreative *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
