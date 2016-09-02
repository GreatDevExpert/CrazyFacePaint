//
//  BenchItemObject.m
//
//
//  Created by ___FULLUSERNAME___ on 3/8/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "BenchItemObject.h"

NSString * const kBenchViewIdentifierClothingAndAccessories1 = @"clothing_and_accessories_1";;
NSString * const kBenchViewIdentifierClothingAndAccessories2 = @"clothing_and_accessories_2";
NSString * const kBenchViewIdentifierFaceAndBody = @"face_and_body";
NSString * const kBenchViewIdentifierSparkleLipstick = @"sparkle_lipstick";
NSString * const kBenchViewIdentifierRegularLipstick = @"regular_lipstick";
NSString * const kBenchViewIdentifierEyeLinerAndEyeShadow = @"eye_liner_and_eye_shadow";
NSString * const kBenchViewIdentifierMascara = @"mascara";
NSString * const kBenchViewIdentifierPowder = @"powder";
NSString * const kBenchViewIdentifierPowder2 = @"powder2";
NSString * const kBenchViewIdentifierColorLipstick = @"color_lipstick";
NSString * const kBenchViewIdentifierPowder3 = @"powder3";
NSString * const kBenchViewIdentifierPowder4 = @"powder4";
NSString * const kBenchViewIdentifierColorLipstick2 = @"color_lipstick2";
NSString * const kBenchViewIdentifierEyeLiner = @"eye_liner";
NSString * const kBenchViewIdentifierEyeShadow = @"eye_shadow";
 
NSString * const kBenchViewIdentifierConcealerAndFoundation = @"concealer_and_foundation";
NSString * const kBenchViewIdentifierExfoliation = @"exfoliation";
NSString * const kBenchViewIdentifierPimplesAndPlucker = @"pimples_and_plucker";
NSString * const kBenchViewIdentifierScrubber = @"scrubber";
NSString * const kBenchViewIdentifierSoap = @"soap";
NSString * const kBenchItemViewIdentifierWaterSprayer = @"water_sprayer";
NSString * const kBenchItemViewIdentifierSoap = @"soap";
NSString * const kBenchItemViewIdentifierSponge = @"sponge";
NSString * const kBenchItemViewIdentifierScrubber = @"scrubber";
NSString * const kBenchItemViewIdentifierExfoliationTool = @"exfoliation_tool";
NSString * const kBenchItemViewIdentifierCucumberOnPlate = @"cucumber_on_plate";
NSString * const kBenchItemViewIdentifierPlucker = @"plucker";
NSString * const kBenchItemViewIdentifierBlemishExtractor = @"blemish_extractor";
NSString * const kBenchItemViewIdentifierConcealerTool = @"concealer_tool";
NSString * const kBenchItemViewIdentifierFoundationTool = @"foundation_tool";

NSString * const kBenchItemViewIdentifierEyeLiner = @"eye_liner";
NSString * const kBenchItemViewIdentifierEyeLinerApplier = @"eye_liner_applier";
NSString * const kBenchItemViewIdentifierEyeShadow = @"eye_shadow";
NSString * const kBenchItemViewIdentifierEyeShadowApplier = @"eye_shadow_applier";
NSString * const kBenchItemViewIdentifierTops = @"tops";

@implementation BenchItemObject

@synthesize appliers = _appliers;
@synthesize baseJsonPath = _baseJsonPath;
@synthesize benchItem = _benchItem;
@synthesize benchItemDraggingImage = _benchItemDraggingImage;
@synthesize benchItemViewIndex = _benchItemViewIndex;
@synthesize benchViewId = _benchViewId;
@synthesize clickable = _clickable;
@synthesize draggable = _draggable;
@synthesize identifier = _identifier;
@synthesize items = _items;
@synthesize productId = _productId;
@synthesize rotateOnDragAngle = _rotateOnDragAngle;
@synthesize thumbs = _thumbs;
@synthesize type = _type;

+ (BenchItemObject *)instanceFromDictionary:(NSDictionary *)aDictionary
{
    
    BenchItemObject *instance = [[BenchItemObject alloc] init];
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

- (void)setValue:(id)value forKey:(NSString *)key
{
    
    if ([key isEqualToString:@"appliers"]) {
        
        if ([value isKindOfClass:[NSArray class]])
        {
            
            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                [myMembers addObject:valueMember];
            }
            
            self.appliers = myMembers;
            
        }
        
    } else if ([key isEqualToString:@"items"]) {
        
        if ([value isKindOfClass:[NSArray class]])
        {
            
            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                [myMembers addObject:valueMember];
            }
            
            self.items = myMembers;
            
        }
        
    } else if ([key isEqualToString:@"thumbs"]) {
        
        if ([value isKindOfClass:[NSArray class]])
        {
            
            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                [myMembers addObject:valueMember];
            }
            
            self.thumbs = myMembers;
            
        }
        
    } else {
        [super setValue:value forKey:key];
    }
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"base_json_path"]) {
        [self setValue:value forKey:@"baseJsonPath"];
    } else if ([key isEqualToString:@"bench_item"]) {
        [self setValue:value forKey:@"benchItem"];
    } else if ([key isEqualToString:@"bench_item_dragging_image"]) {
        [self setValue:value forKey:@"benchItemDraggingImage"];
    } else if ([key isEqualToString:@"bench_item_view_index"]) {
        [self setValue:value forKey:@"benchItemViewIndex"];
    } else if ([key isEqualToString:@"bench_view_id"]) {
        [self setValue:value forKey:@"benchViewId"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else if ([key isEqualToString:@"product_id"]) {
        [self setValue:value forKey:@"productId"];
    } else if ([key isEqualToString:@"rotate_on_drag_angle"]) {
        [self setValue:value forKey:@"rotateOnDragAngle"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }
    
}


- (NSDictionary *)dictionaryRepresentation
{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.appliers) {
        [dictionary setObject:self.appliers forKey:@"appliers"];
    }
    
    if (self.baseJsonPath) {
        [dictionary setObject:self.baseJsonPath forKey:@"baseJsonPath"];
    }
    
    if (self.benchItem) {
        [dictionary setObject:self.benchItem forKey:@"benchItem"];
    }
    
    if (self.benchItemDraggingImage) {
        [dictionary setObject:self.benchItemDraggingImage forKey:@"benchItemDraggingImage"];
    }
    
    if (self.benchItemViewIndex) {
        [dictionary setObject:self.benchItemViewIndex forKey:@"benchItemViewIndex"];
    }
    
    if (self.benchViewId) {
        [dictionary setObject:self.benchViewId forKey:@"benchViewId"];
    }
    
    [dictionary setObject:[NSNumber numberWithBool:self.clickable] forKey:@"clickable"];
    
    [dictionary setObject:[NSNumber numberWithBool:self.draggable] forKey:@"draggable"];
    
    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }
    
    if (self.items) {
        [dictionary setObject:self.items forKey:@"items"];
    }
    
    if (self.productId) {
        [dictionary setObject:self.productId forKey:@"productId"];
    }
    
    if (self.rotateOnDragAngle) {
        [dictionary setObject:self.rotateOnDragAngle forKey:@"rotateOnDragAngle"];
    }
    
    if (self.thumbs) {
        [dictionary setObject:self.thumbs forKey:@"thumbs"];
    }
    
    if (self.type) {
        [dictionary setObject:self.type forKey:@"type"];
    }
    
    return dictionary;
    
}

@end
