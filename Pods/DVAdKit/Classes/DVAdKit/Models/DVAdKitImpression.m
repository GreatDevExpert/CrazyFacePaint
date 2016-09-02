//
//  DVAdKitImpression.m
//
//
//  Created by ___FULLUSERNAME___ on 6/14/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "DVAdKitImpression.h"

#import "DVAdKitAd.h"
#import "DVAdKitApp.h"
#import "DVAdKitAdDisplaySettings.h"
#import "DVAdKitDevice.h"

@implementation DVAdKitImpression

@synthesize ad;
@synthesize adId;
@synthesize advertisingCampaignId;
@synthesize app;
@synthesize appId;
@synthesize campaignId;
@synthesize clicked;
@synthesize clickedProxy;
@synthesize createdAt;
@synthesize deviceId;
@synthesize device;
@synthesize identifier;
@synthesize installed;
@synthesize maxPerDayReached;
@synthesize maxPerHourReached;
@synthesize publishingCampaignId;
@synthesize uniqueToken;
@synthesize updatedAt;
@synthesize adDisplaySettings;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.ad forKey:@"ad"];
    [encoder encodeObject:self.adId forKey:@"adId"];
    [encoder encodeObject:self.advertisingCampaignId forKey:@"advertisingCampaignId"];
    [encoder encodeObject:self.app forKey:@"app"];
    [encoder encodeObject:self.appId forKey:@"appId"];
    [encoder encodeObject:self.campaignId forKey:@"campaignId"];
    [encoder encodeObject:[NSNumber numberWithBool:self.clicked] forKey:@"clicked"];
    [encoder encodeObject:[NSNumber numberWithBool:self.clickedProxy] forKey:@"clickedProxy"];
    [encoder encodeObject:self.createdAt forKey:@"createdAt"];
    [encoder encodeObject:self.deviceId forKey:@"deviceId"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:[NSNumber numberWithBool:self.installed] forKey:@"installed"];
    [encoder encodeObject:[NSNumber numberWithBool:self.maxPerDayReached] forKey:@"maxPerDayReached"];
    [encoder encodeObject:[NSNumber numberWithBool:self.maxPerHourReached] forKey:@"maxPerHourReached"];
    [encoder encodeObject:self.publishingCampaignId forKey:@"publishingCampaignId"];
    [encoder encodeObject:self.uniqueToken forKey:@"uniqueToken"];
    [encoder encodeObject:self.updatedAt forKey:@"updatedAt"];
    [encoder encodeObject:self.adDisplaySettings forKey:@"adDisplaySettings"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.ad = [decoder decodeObjectForKey:@"ad"];
        self.adId = [decoder decodeObjectForKey:@"adId"];
        self.advertisingCampaignId = [decoder decodeObjectForKey:@"advertisingCampaignId"];
        self.app = [decoder decodeObjectForKey:@"app"];
        self.appId = [decoder decodeObjectForKey:@"appId"];
        self.campaignId = [decoder decodeObjectForKey:@"campaignId"];
        self.clicked = [(NSNumber *)[decoder decodeObjectForKey:@"clicked"] boolValue];
        self.clickedProxy = [(NSNumber *)[decoder decodeObjectForKey:@"clickedProxy"] boolValue];
        self.createdAt = [decoder decodeObjectForKey:@"createdAt"];
        self.deviceId = [decoder decodeObjectForKey:@"deviceId"];
        self.device = [decoder decodeObjectForKey:@"device"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.installed = [(NSNumber *)[decoder decodeObjectForKey:@"installed"] boolValue];
        self.maxPerDayReached = [(NSNumber *)[decoder decodeObjectForKey:@"maxPerDayReached"] boolValue];
        self.maxPerHourReached = [(NSNumber *)[decoder decodeObjectForKey:@"maxPerHourReached"] boolValue];
        self.publishingCampaignId = [decoder decodeObjectForKey:@"publishingCampaignId"];
        self.uniqueToken = [decoder decodeObjectForKey:@"uniqueToken"];
        self.updatedAt = [decoder decodeObjectForKey:@"updatedAt"];
        self.adDisplaySettings = [decoder decodeObjectForKey:@"adDisplaySettings"];
    }
    return self;
}

+ (DVAdKitImpression *)instanceFromDictionary:(NSDictionary *)aDictionary
{
    
    DVAdKitImpression *instance = [[DVAdKitImpression alloc] init];
    @try {
        [instance setAttributesFromDictionary:aDictionary];
    }
    @catch (NSException *exception) {
        NSLog(@"Warning: error creating NFAdKitImpression");
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
    
    if ([key isEqualToString:@"ad"]) {
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            self.ad = [DVAdKitAd instanceFromDictionary:value];
        }
        
    } else if ([key isEqualToString:@"app"]) {
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            self.app = [DVAdKitApp instanceFromDictionary:value];
        }
        
    } else if ([key isEqualToString:@"adDisplaySettings"]) {
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            self.adDisplaySettings = [DVAdKitAdDisplaySettings instanceFromDictionary:value];
        }
        
    }else if ([key isEqualToString:@"device"]) {
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            self.device = [DVAdKitDevice instanceFromDictionary:value];
        }
        
    }  else {
        [super setValue:value forKey:key];
    }
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"ad_id"]) {
        [self setValue:value forKey:@"adId"];
    } else if ([key isEqualToString:@"advertising_campaign_id"]) {
        [self setValue:value forKey:@"advertisingCampaignId"];
    } else if ([key isEqualToString:@"app_id"]) {
        [self setValue:value forKey:@"appId"];
    } else if ([key isEqualToString:@"campaign_id"]) {
        [self setValue:value forKey:@"campaignId"];
    } else if ([key isEqualToString:@"clicked_proxy"]) {
        [self setValue:value forKey:@"clickedProxy"];
    } else if ([key isEqualToString:@"created_at"]) {
        [self setValue:value forKey:@"createdAt"];
    } else if ([key isEqualToString:@"device_id"]) {
        [self setValue:value forKey:@"deviceId"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else if ([key isEqualToString:@"max_per_day_reached"]) {
        [self setValue:value forKey:@"maxPerDayReached"];
    } else if ([key isEqualToString:@"max_per_hour_reached"]) {
        [self setValue:value forKey:@"maxPerHourReached"];
    } else if ([key isEqualToString:@"publishing_campaign_id"]) {
        [self setValue:value forKey:@"publishingCampaignId"];
    } else if ([key isEqualToString:@"unique_token"]) {
        [self setValue:value forKey:@"uniqueToken"];
    } else if ([key isEqualToString:@"updated_at"]) {
        [self setValue:value forKey:@"updatedAt"];
    } else if ([key isEqualToString:@"ad_display_settings"]) {
        [self setValue:value forKey:@"adDisplaySettings"];
    } else {
//        [super setValue:value forUndefinedKey:key];
    }
    
}


- (NSDictionary *)dictionaryRepresentation
{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.ad) {
        [dictionary setObject:self.ad forKey:@"ad"];
    }
    
    if (self.adId) {
        [dictionary setObject:self.adId forKey:@"adId"];
    }
    
    if (self.advertisingCampaignId) {
        [dictionary setObject:self.advertisingCampaignId forKey:@"advertisingCampaignId"];
    }
    
    if (self.app) {
        [dictionary setObject:self.app forKey:@"app"];
    }
    
    if (self.appId) {
        [dictionary setObject:self.appId forKey:@"appId"];
    }
    
    if (self.campaignId) {
        [dictionary setObject:self.campaignId forKey:@"campaignId"];
    }
    
    [dictionary setObject:[NSNumber numberWithBool:self.clicked] forKey:@"clicked"];
    
    [dictionary setObject:[NSNumber numberWithBool:self.clickedProxy] forKey:@"clickedProxy"];
    
    if (self.createdAt) {
        [dictionary setObject:self.createdAt forKey:@"createdAt"];
    }
    
    if (self.deviceId) {
        [dictionary setObject:self.deviceId forKey:@"deviceId"];
    }
    
    if (self.device) {
        [dictionary setObject:self.device forKey:@"device"];
    }
    
    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }
    
    [dictionary setObject:[NSNumber numberWithBool:self.installed] forKey:@"installed"];
    
    [dictionary setObject:[NSNumber numberWithBool:self.maxPerDayReached] forKey:@"maxPerDayReached"];
    
    [dictionary setObject:[NSNumber numberWithBool:self.maxPerHourReached] forKey:@"maxPerHourReached"];
    
    if (self.publishingCampaignId) {
        [dictionary setObject:self.publishingCampaignId forKey:@"publishingCampaignId"];
    }
    
    if (self.uniqueToken) {
        [dictionary setObject:self.uniqueToken forKey:@"uniqueToken"];
    }
    
    if (self.updatedAt) {
        [dictionary setObject:self.updatedAt forKey:@"updatedAt"];
    }
    
    if (self.adDisplaySettings) {
        [dictionary setObject:self.adDisplaySettings forKey:@"adDisplaySettings"];
    }
    
    return dictionary;
    
}

@end
