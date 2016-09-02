//
//  BenchItemObject.h
//
//
//  Created by ___FULLUSERNAME___ on 3/8/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kBenchViewIdentifierClothingAndAccessories1;
extern NSString * const kBenchViewIdentifierClothingAndAccessories2;
extern NSString * const kBenchViewIdentifierFaceAndBody;
extern NSString * const kBenchViewIdentifierSparkleLipstick;
extern NSString * const kBenchViewIdentifierRegularLipstick;
extern NSString * const kBenchViewIdentifierEyeLinerAndEyeShadow;
extern NSString * const kBenchViewIdentifierMascara;
extern NSString * const kBenchViewIdentifierPowder;
extern NSString * const kBenchViewIdentifierPowder2;
extern NSString * const kBenchViewIdentifierColorLipstick;
extern NSString * const kBenchViewIdentifierPowder3;
extern NSString * const kBenchViewIdentifierPowder4; 
extern NSString * const kBenchViewIdentifierColorLipstick2;
extern NSString * const kBenchViewIdentifierEyeLiner;
extern NSString * const kBenchViewIdentifierEyeShadow;

extern NSString * const kBenchViewIdentifierConcealerAndFoundation;
extern NSString * const kBenchViewIdentifierExfoliation;
extern NSString * const kBenchViewIdentifierPimplesAndPlucker;
extern NSString * const kBenchViewIdentifierScrubber;
extern NSString * const kBenchViewIdentifierSoap;

extern NSString * const kBenchItemViewIdentifierWaterSprayer;
extern NSString * const kBenchItemViewIdentifierSoap;
extern NSString * const kBenchItemViewIdentifierSponge;
extern NSString * const kBenchItemViewIdentifierScrubber;
extern NSString * const kBenchItemViewIdentifierExfoliationTool;
extern NSString * const kBenchItemViewIdentifierCucumberOnPlate;

extern NSString * const kBenchItemViewIdentifierPlucker;
extern NSString * const kBenchItemViewIdentifierBlemishExtractor;

extern NSString * const kBenchItemViewIdentifierConcealerTool;
extern NSString * const kBenchItemViewIdentifierFoundationTool;

extern NSString * const kBenchItemViewIdentifierEyeLiner;
extern NSString * const kBenchItemViewIdentifierEyeLinerApplier;
extern NSString * const kBenchItemViewIdentifierEyeShadow;
extern NSString * const kBenchItemViewIdentifierEyeShadowApplier;
extern NSString * const kBenchItemViewIdentifierTops;


@interface BenchItemObject : NSObject {
    NSMutableArray *appliers;
    NSString *baseJsonPath;
    NSString *benchItem;
    NSString *benchItemDraggingImage;
    NSNumber *benchItemViewIndex;
    NSString *benchViewId;
    BOOL clickable;
    BOOL draggable;
    NSString *identifier;
    NSMutableArray *items;
    NSString *productId;
    NSNumber *rotateOnDragAngle;
    NSMutableArray *thumbs;
    NSString *type;
}

@property (nonatomic, copy) NSMutableArray *appliers;
@property (nonatomic, copy) NSString *baseJsonPath;
@property (nonatomic, copy) NSString *benchItem;
@property (nonatomic, copy) NSString *benchItemDraggingImage;
@property (nonatomic, copy) NSNumber *benchItemViewIndex;
@property (nonatomic, copy) NSString *benchViewId;
@property (nonatomic, assign) BOOL clickable;
@property (nonatomic, assign) BOOL draggable;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSMutableArray *items;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSNumber *rotateOnDragAngle;
@property (nonatomic, copy) NSMutableArray *thumbs;
@property (nonatomic, copy) NSString *type;

+ (BenchItemObject *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end