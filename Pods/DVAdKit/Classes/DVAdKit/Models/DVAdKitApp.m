//
//  DVAdKitApp.m
//
//
//  Created by ___FULLUSERNAME___ on 6/14/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "DVAdKitApp.h"

#import "DVAdKitAdLogic.h"

@implementation DVAdKitApp

@synthesize adLogics;
@synthesize appKey;
@synthesize appStoreLink;
@synthesize appleId;
@synthesize bundleIdentifier;
@synthesize companyId;
@synthesize createdAt;
@synthesize iconImageLink;
@synthesize identifier;
@synthesize isKidsApp;
@synthesize name;
@synthesize orientation;
@synthesize uniqueToken;
@synthesize updatedAt;
@synthesize urlScheme;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.adLogics forKey:@"adLogics"];
    [encoder encodeObject:self.appKey forKey:@"appKey"];
    [encoder encodeObject:self.appStoreLink forKey:@"appStoreLink"];
    [encoder encodeObject:self.appleId forKey:@"appleId"];
    [encoder encodeObject:self.bundleIdentifier forKey:@"bundleIdentifier"];
    [encoder encodeObject:self.companyId forKey:@"companyId"];
    [encoder encodeObject:self.createdAt forKey:@"createdAt"];
    [encoder encodeObject:self.iconImageLink forKey:@"iconImageLink"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:[NSNumber numberWithBool:self.isKidsApp] forKey:@"isKidsApp"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.orientation forKey:@"orientation"];
    [encoder encodeObject:self.uniqueToken forKey:@"uniqueToken"];
    [encoder encodeObject:self.updatedAt forKey:@"updatedAt"];
    [encoder encodeObject:self.urlScheme forKey:@"urlScheme"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.adLogics = [decoder decodeObjectForKey:@"adLogics"];
        self.appKey = [decoder decodeObjectForKey:@"appKey"];
        self.appStoreLink = [decoder decodeObjectForKey:@"appStoreLink"];
        self.appleId = [decoder decodeObjectForKey:@"appleId"];
        self.bundleIdentifier = [decoder decodeObjectForKey:@"bundleIdentifier"];
        self.companyId = [decoder decodeObjectForKey:@"companyId"];
        self.createdAt = [decoder decodeObjectForKey:@"createdAt"];
        self.iconImageLink = [decoder decodeObjectForKey:@"iconImageLink"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.isKidsApp = [(NSNumber *)[decoder decodeObjectForKey:@"isKidsApp"] boolValue];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.orientation = [decoder decodeObjectForKey:@"orientation"];
        self.uniqueToken = [decoder decodeObjectForKey:@"uniqueToken"];
        self.updatedAt = [decoder decodeObjectForKey:@"updatedAt"];
        self.urlScheme = [decoder decodeObjectForKey:@"urlScheme"];
    }
    return self;
}

+ (DVAdKitApp *)instanceFromDictionary:(NSDictionary *)aDictionary
{
    
    DVAdKitApp *instance = [[DVAdKitApp alloc] init];
    @try {
        [instance setAttributesFromDictionary:aDictionary];
    }
    @catch (NSException *exception) {
        NSLog(@"Warning: error creating NFAdKitApp");
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
    
    if ([key isEqualToString:@"ad_logics"]) {
        
        if ([value isKindOfClass:[NSArray class]])
        {
            
            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                DVAdKitAdLogic *populatedMember = [DVAdKitAdLogic instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }
            
            self.adLogics = myMembers;
            
        }
        
    } else {
        [super setValue:value forKey:key];
    }
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"ad_logics"]) {
        [self setValue:value forKey:@"adLogics"];
    } else if ([key isEqualToString:@"app_key"]) {
        [self setValue:value forKey:@"appKey"];
    } else if ([key isEqualToString:@"app_store_link"]) {
        [self setValue:value forKey:@"appStoreLink"];
    } else if ([key isEqualToString:@"apple_id"]) {
        [self setValue:value forKey:@"appleId"];
    } else if ([key isEqualToString:@"bundle_identifier"]) {
        [self setValue:value forKey:@"bundleIdentifier"];
    } else if ([key isEqualToString:@"company_id"]) {
        [self setValue:value forKey:@"companyId"];
    } else if ([key isEqualToString:@"created_at"]) {
        [self setValue:value forKey:@"createdAt"];
    } else if ([key isEqualToString:@"icon_image_link"]) {
        [self setValue:value forKey:@"iconImageLink"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else if ([key isEqualToString:@"is_kids_app"]) {
        [self setValue:value forKey:@"isKidsApp"];
    } else if ([key isEqualToString:@"unique_token"]) {
        [self setValue:value forKey:@"uniqueToken"];
    } else if ([key isEqualToString:@"updated_at"]) {
        [self setValue:value forKey:@"updatedAt"];
    } else if ([key isEqualToString:@"url_scheme"]) {
        [self setValue:value forKey:@"urlScheme"];
    } else {
//        [super setValue:value forUndefinedKey:key];
    }
    
}


- (NSDictionary *)dictionaryRepresentation
{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.adLogics) {
        [dictionary setObject:self.adLogics forKey:@"adLogics"];
    }
    
    if (self.appKey) {
        [dictionary setObject:self.appKey forKey:@"appKey"];
    }
    
    if (self.appStoreLink) {
        [dictionary setObject:self.appStoreLink forKey:@"appStoreLink"];
    }
    
    if (self.appleId) {
        [dictionary setObject:self.appleId forKey:@"appleId"];
    }
    
    if (self.bundleIdentifier) {
        [dictionary setObject:self.bundleIdentifier forKey:@"bundleIdentifier"];
    }
    
    if (self.companyId) {
        [dictionary setObject:self.companyId forKey:@"companyId"];
    }
    
    if (self.createdAt) {
        [dictionary setObject:self.createdAt forKey:@"createdAt"];
    }
    
    if (self.iconImageLink) {
        [dictionary setObject:self.iconImageLink forKey:@"iconImageLink"];
    }
    
    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }
    
    [dictionary setObject:[NSNumber numberWithBool:self.isKidsApp] forKey:@"isKidsApp"];
    
    if (self.name) {
        [dictionary setObject:self.name forKey:@"name"];
    }
    
    if (self.orientation) {
        [dictionary setObject:self.orientation forKey:@"orientation"];
    }
    
    if (self.uniqueToken) {
        [dictionary setObject:self.uniqueToken forKey:@"uniqueToken"];
    }
    
    if (self.updatedAt) {
        [dictionary setObject:self.updatedAt forKey:@"updatedAt"];
    }
    
    if (self.urlScheme) {
        [dictionary setObject:self.urlScheme forKey:@"urlScheme"];
    }
    
    return dictionary;
    
}

@end
