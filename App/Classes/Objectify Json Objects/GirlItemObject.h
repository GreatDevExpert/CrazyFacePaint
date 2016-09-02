//
//  GirlItemObject.h
//  
//
//  Created by ___FULLUSERNAME___ on 3/11/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kGirlItemObjectTypeMakeup;
extern NSString * const kGirlItemObjectTypeFaceAndBody;
extern NSString * const kGirlItemObjectTypeClothingAndAccessories;

extern NSString * const kGirlItemObjectIdentifierEyeShadow;
extern NSString * const kGirlItemObjectIdentifierEyeLiner;
extern NSString * const kGirlItemObjectIdentifierMascara;
extern NSString * const kGirlItemObjectIdentifierPowder;
extern NSString * const kGirlItemObjectIdentifierPowder2;
extern NSString * const kGirlItemObjectIdentifierLipstickRegular;
extern NSString * const kGirlItemObjectIdentifierLipstickSparkle;
extern NSString * const kGirlItemObjectIdentifierBackgrounds;

extern NSString * const kGirlItemObjectIdentifierLipstickColor;
extern NSString * const kGirlItemObjectIdentifierPowder3;
extern NSString * const kGirlItemObjectIdentifierPowder4;
extern NSString * const kGirlItemObjectIdentifierLipstickColor2;


extern NSString * const kGirlItemObjectIdentifierEyes;
extern NSString * const kGirlItemObjectIdentifierLips;
extern NSString * const kGirlItemObjectIdentifierEyeBrows;




@interface GirlItemObject : NSObject {
    NSString *identifier;
    NSString *imagesJsonPath;
    NSString *productId;
    NSString *thumbsJsonPath;
    NSString *type;
    BOOL visible;
}

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *imagesJsonPath;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *thumbsJsonPath;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) BOOL visible;

+ (GirlItemObject *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end

