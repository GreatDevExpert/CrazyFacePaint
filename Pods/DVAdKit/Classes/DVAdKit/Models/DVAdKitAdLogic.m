//
//  DVAdKitAdLogic.m
//  
//
//  Created by ___FULLUSERNAME___ on 6/5/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "DVAdKitAdLogic.h"

@implementation DVAdKitAdLogic

@synthesize appId;
@synthesize createdAt;
@synthesize identifier;
@synthesize maxPerDay;
@synthesize maxPerHour;
@synthesize updatedAt;
@synthesize zone;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.appId forKey:@"appId"];
    [encoder encodeObject:self.createdAt forKey:@"createdAt"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.maxPerDay forKey:@"maxPerDay"];
    [encoder encodeObject:self.maxPerHour forKey:@"maxPerHour"];
    [encoder encodeObject:self.updatedAt forKey:@"updatedAt"];
    [encoder encodeObject:self.zone forKey:@"zone"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.appId = [decoder decodeObjectForKey:@"appId"];
        self.createdAt = [decoder decodeObjectForKey:@"createdAt"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.maxPerDay = [decoder decodeObjectForKey:@"maxPerDay"];
        self.maxPerHour = [decoder decodeObjectForKey:@"maxPerHour"];
        self.updatedAt = [decoder decodeObjectForKey:@"updatedAt"];
        self.zone = [decoder decodeObjectForKey:@"zone"];
    }
    return self;
}

+ (DVAdKitAdLogic *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    DVAdKitAdLogic *instance = [[DVAdKitAdLogic alloc] init];
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

    if ([key isEqualToString:@"app_id"]) {
        [self setValue:value forKey:@"appId"];
    } else if ([key isEqualToString:@"created_at"]) {
        [self setValue:value forKey:@"createdAt"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else if ([key isEqualToString:@"max_per_day"]) {
        [self setValue:value forKey:@"maxPerDay"];
    } else if ([key isEqualToString:@"max_per_hour"]) {
        [self setValue:value forKey:@"maxPerHour"];
    } else if ([key isEqualToString:@"updated_at"]) {
        [self setValue:value forKey:@"updatedAt"];
    } else {
//        [super setValue:value forUndefinedKey:key];
        
    }

}


- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.appId) {
        [dictionary setObject:self.appId forKey:@"appId"];
    }

    if (self.createdAt) {
        [dictionary setObject:self.createdAt forKey:@"createdAt"];
    }

    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }

    if (self.maxPerDay) {
        [dictionary setObject:self.maxPerDay forKey:@"maxPerDay"];
    }

    if (self.maxPerHour) {
        [dictionary setObject:self.maxPerHour forKey:@"maxPerHour"];
    }

    if (self.updatedAt) {
        [dictionary setObject:self.updatedAt forKey:@"updatedAt"];
    }

    if (self.zone) {
        [dictionary setObject:self.zone forKey:@"zone"];
    }

    return dictionary;

}

@end
