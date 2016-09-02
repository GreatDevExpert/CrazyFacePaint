//
//  DVAdKitCreative.m
//  
//
//  Created by ___FULLUSERNAME___ on 5/31/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "DVAdKitCreative.h"

@implementation DVAdKitCreative

@synthesize adImageLink;
@synthesize frameImageLink;
@synthesize identifier;
@synthesize model;
@synthesize orientation;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.adImageLink forKey:@"adImageLink"];
    [encoder encodeObject:self.frameImageLink forKey:@"frameImageLink"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.model forKey:@"model"];
    [encoder encodeObject:self.orientation forKey:@"orientation"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.adImageLink = [decoder decodeObjectForKey:@"adImageLink"];
        self.frameImageLink = [decoder decodeObjectForKey:@"frameImageLink"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.model = [decoder decodeObjectForKey:@"model"];
        self.orientation = [decoder decodeObjectForKey:@"orientation"];
    }
    return self;
}

+ (DVAdKitCreative *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    DVAdKitCreative *instance = [[DVAdKitCreative alloc] init];
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

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"ad_image_link"]) {
        [self setValue:value forKey:@"adImageLink"];
    } else if ([key isEqualToString:@"frame_image_link"]) {
        [self setValue:value forKey:@"frameImageLink"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else {
//        [super setValue:value forUndefinedKey:key];
    }

}


- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.adImageLink) {
        [dictionary setObject:self.adImageLink forKey:@"adImageLink"];
    }

    if (self.frameImageLink) {
        [dictionary setObject:self.frameImageLink forKey:@"frameImageLink"];
    }

    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }

    if (self.model) {
        [dictionary setObject:self.model forKey:@"model"];
    }

    if (self.orientation) {
        [dictionary setObject:self.orientation forKey:@"orientation"];
    }

    return dictionary;

}

@end
