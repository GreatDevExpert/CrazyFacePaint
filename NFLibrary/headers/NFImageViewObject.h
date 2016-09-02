//
//  NFImageViewObject.h
//
//
//  Created by ___FULLUSERNAME___ on 8/30/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFImageViewObject : NSObject <NSCoding> {
    BOOL animated;
    NSMutableArray *animationTiming;
    NSMutableArray *animationTimingRanges;
    NSString *identifier;
    NSNumber *imageIndex;
    NSMutableArray *imageNames;
    NSNumber *repeatCount;
    BOOL scratchable;
    NSNumber *scratchableMode;
}

@property (nonatomic, assign) BOOL animated;
@property (nonatomic, strong) NSNumber *animationType;
@property (nonatomic, copy) NSMutableArray *animationTiming;
@property (nonatomic, copy) NSMutableArray *animationTimingRanges;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSNumber *imageIndex;
@property (nonatomic, copy) NSMutableArray *imageNames;
@property (nonatomic, copy) NSNumber *repeatCount;
@property (nonatomic, assign) BOOL scratchable;
@property (nonatomic, copy) NSNumber *scratchableMode;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, strong) NSNumber *alpha;

+ (NFImageViewObject *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
