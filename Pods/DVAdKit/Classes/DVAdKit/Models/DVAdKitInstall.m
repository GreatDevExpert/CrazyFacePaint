//
//  DVAdKitInstall.m
//  
//
//  Created by ___FULLUSERNAME___ on 5/30/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "DVAdKitInstall.h"

#import "DVAdKitApp.h"
#import "DVAdKitDevice.h"
#import "DVAdKitImpression.h"

@implementation DVAdKitInstall

@synthesize app;
@synthesize appId;
@synthesize device;
@synthesize deviceId;
@synthesize identifier;
@synthesize impression;
@synthesize impressionId;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.app forKey:@"app"];
    [encoder encodeObject:self.appId forKey:@"appId"];
    [encoder encodeObject:self.device forKey:@"device"];
    [encoder encodeObject:self.deviceId forKey:@"deviceId"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.impression forKey:@"impression"];
    [encoder encodeObject:self.impressionId forKey:@"impressionId"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.app = [decoder decodeObjectForKey:@"app"];
        self.appId = [decoder decodeObjectForKey:@"appId"];
        self.device = [decoder decodeObjectForKey:@"device"];
        self.deviceId = [decoder decodeObjectForKey:@"deviceId"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.impression = [decoder decodeObjectForKey:@"impression"];
        self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
    }
    return self;
}

+ (DVAdKitInstall *)instanceFromDictionary:(NSDictionary *)aDictionary
{
    DVAdKitInstall *instance = [[DVAdKitInstall alloc] init];
    
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

    } else if ([key isEqualToString:@"device"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.device = [DVAdKitDevice instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"impression"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.impression = [DVAdKitImpression instanceFromDictionary:value];
        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"app_id"]) {
        [self setValue:value forKey:@"appId"];
    } else if ([key isEqualToString:@"device_id"]) {
        [self setValue:value forKey:@"deviceId"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else if ([key isEqualToString:@"impression_id"]) {
        [self setValue:value forKey:@"impressionId"];
    } else {
//        [super setValue:value forUndefinedKey:key];
        
    }

}


- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.app) {
        [dictionary setObject:self.app forKey:@"app"];
    }

    if (self.appId) {
        [dictionary setObject:self.appId forKey:@"appId"];
    }

    if (self.device) {
        [dictionary setObject:self.device forKey:@"device"];
    }

    if (self.deviceId) {
        [dictionary setObject:self.deviceId forKey:@"deviceId"];
    }

    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }

    if (self.impression) {
        [dictionary setObject:self.impression forKey:@"impression"];
    }

    if (self.impressionId) {
        [dictionary setObject:self.impressionId forKey:@"impressionId"];
    }

    return dictionary;

}

@end
