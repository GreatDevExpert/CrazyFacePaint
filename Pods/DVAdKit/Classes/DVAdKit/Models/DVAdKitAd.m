//
//  DVAdKitAd.m
//
//
//  Created by ___FULLUSERNAME___ on 5/31/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "DVAdKitAd.h"

#import "DVAdKitApp.h"
#import "DVAdKitCreative.h"

@implementation DVAdKitAd

@synthesize adImageLink;
@synthesize app;
@synthesize appId;
@synthesize createdAt;
@synthesize creatives;
@synthesize identifier;
@synthesize orientation;
@synthesize updatedAt;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.adImageLink forKey:@"adImageLink"];
    [encoder encodeObject:self.app forKey:@"app"];
    [encoder encodeObject:self.appId forKey:@"appId"];
    [encoder encodeObject:self.createdAt forKey:@"createdAt"];
    [encoder encodeObject:self.creatives forKey:@"creatives"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.orientation forKey:@"orientation"];
    [encoder encodeObject:self.updatedAt forKey:@"updatedAt"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.adImageLink = [decoder decodeObjectForKey:@"adImageLink"];
        self.app = [decoder decodeObjectForKey:@"app"];
        self.appId = [decoder decodeObjectForKey:@"appId"];
        self.createdAt = [decoder decodeObjectForKey:@"createdAt"];
        self.creatives = [decoder decodeObjectForKey:@"creatives"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.orientation = [decoder decodeObjectForKey:@"orientation"];
        self.updatedAt = [decoder decodeObjectForKey:@"updatedAt"];
    }
    return self;
}

+ (DVAdKitAd *)instanceFromDictionary:(NSDictionary *)aDictionary
{
    
    DVAdKitAd *instance = [[DVAdKitAd alloc] init];
    @try {
        [instance setAttributesFromDictionary:aDictionary];
    }
    @catch (NSException *exception) {
        NSLog(@"Warning: error creating NFAdKit model");
    }
    @finally {
    }
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
    
    if ([key isEqualToString:@"app"]) {
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            self.app = [DVAdKitApp instanceFromDictionary:value];
        }
        
    } else if ([key isEqualToString:@"creatives"]) {
        
        if ([value isKindOfClass:[NSArray class]])
        {
            
            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                DVAdKitCreative *populatedMember = [DVAdKitCreative instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }
            
            self.creatives = myMembers;
            
        }
        
    } else {
        [super setValue:value forKey:key];
    }
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"ad_image_link"]) {
        [self setValue:value forKey:@"adImageLink"];
    } else if ([key isEqualToString:@"app_id"]) {
        [self setValue:value forKey:@"appId"];
    } else if ([key isEqualToString:@"created_at"]) {
        [self setValue:value forKey:@"createdAt"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else if ([key isEqualToString:@"updated_at"]) {
        [self setValue:value forKey:@"updatedAt"];
    } else {
//        [super setValue:value forUndefinedKey:key];
        NSLog(@"Warning: undefined key in DVAdKitAd: %@", key);
        
    }
    
}


- (NSDictionary *)dictionaryRepresentation
{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.adImageLink) {
        [dictionary setObject:self.adImageLink forKey:@"adImageLink"];
    }
    
    if (self.app) {
        [dictionary setObject:self.app forKey:@"app"];
    }
    
    if (self.appId) {
        [dictionary setObject:self.appId forKey:@"appId"];
    }
    
    if (self.createdAt) {
        [dictionary setObject:self.createdAt forKey:@"createdAt"];
    }
    
    if (self.creatives) {
        [dictionary setObject:self.creatives forKey:@"creatives"];
    }
    
    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }
    
    if (self.orientation) {
        [dictionary setObject:self.orientation forKey:@"orientation"];
    }
    
    if (self.updatedAt) {
        [dictionary setObject:self.updatedAt forKey:@"updatedAt"];
    }
    
    return dictionary;
    
}

@end
