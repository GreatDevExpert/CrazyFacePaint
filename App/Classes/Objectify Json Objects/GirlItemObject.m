//
//  GirlItemObject.m
//  
//
//  Created by ___FULLUSERNAME___ on 3/11/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "GirlItemObject.h"

NSString * const kGirlItemObjectTypeMakeup = @"makeup";
NSString * const kGirlItemObjectTypeFaceAndBody = @"face_and_body";
NSString * const kGirlItemObjectTypeClothingAndAccessories = @"clothing_and_accessories";


NSString * const kGirlItemObjectIdentifierEyeShadow = @"eye_shadow";
NSString * const kGirlItemObjectIdentifierEyeLiner = @"eye_liner";
NSString * const kGirlItemObjectIdentifierMascara = @"mascara";
NSString * const kGirlItemObjectIdentifierPowder = @"powder";
NSString * const kGirlItemObjectIdentifierPowder2 = @"powder2";
NSString * const kGirlItemObjectIdentifierLipstickRegular = @"regular_lipstick";
NSString * const kGirlItemObjectIdentifierLipstickSparkle = @"sparkle_lipstick";
NSString * const kGirlItemObjectIdentifierLipstickColor = @"color_lipstick";
NSString * const kGirlItemObjectIdentifierPowder3 = @"powder3";
NSString * const kGirlItemObjectIdentifierPowder4 = @"powder4";
NSString * const kGirlItemObjectIdentifierLipstickColor2 = @"color_lipstick2";
 

NSString * const kGirlItemObjectIdentifierBackgrounds = @"backgrounds";

NSString * const kGirlItemObjectIdentifierEyes = @"eyes";
NSString * const kGirlItemObjectIdentifierLips = @"lips_default";
NSString * const kGirlItemObjectIdentifierEyeBrows = @"eye_brows";

@implementation GirlItemObject

@synthesize identifier = _identifier;
@synthesize imagesJsonPath = _imagesJsonPath;
@synthesize productId = _productId;
@synthesize thumbsJsonPath = _thumbsJsonPath;
@synthesize type = _type;
@synthesize visible = _visible;

+ (GirlItemObject *)instanceFromDictionary:(NSDictionary *)aDictionary
{ 
    
    GirlItemObject *instance = [[GirlItemObject alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
    
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary
{
    
    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    [self setValuesForKeysWithDictionary:aDictionary];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else if ([key isEqualToString:@"images_json_path"]) {
        [self setValue:value forKey:@"imagesJsonPath"];
    } else if ([key isEqualToString:@"product_id"]) {
        [self setValue:value forKey:@"productId"];
    } else if ([key isEqualToString:@"thumbs_json_path"]) {
        [self setValue:value forKey:@"thumbsJsonPath"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }
    
}


- (NSDictionary *)dictionaryRepresentation
{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }
    
    if (self.imagesJsonPath) {
        [dictionary setObject:self.imagesJsonPath forKey:@"imagesJsonPath"];
    }
    
    if (self.productId) {
        [dictionary setObject:self.productId forKey:@"productId"];
    }
    
    if (self.thumbsJsonPath) {
        [dictionary setObject:self.thumbsJsonPath forKey:@"thumbsJsonPath"];
    }
    
    if (self.type) {
        [dictionary setObject:self.type forKey:@"type"];
    }
    
    [dictionary setObject:[NSNumber numberWithBool:self.visible] forKey:@"visible"];
    
    return dictionary;
    
}

@end
