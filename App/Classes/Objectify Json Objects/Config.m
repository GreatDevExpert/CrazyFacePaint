//
//  Config.m
//
//
//  Created by ___FULLUSERNAME___ on 4/9/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "Config.h"

@implementation Config

@synthesize analyticsDomainName;
@synthesize apiBaseUrl;
@synthesize apiDomainName;
@synthesize appleId;
@synthesize cdnDomainName;
@synthesize chartboostAppId;
@synthesize chartboostAppSignature;
@synthesize flurryAppKey;
@synthesize googleAnalyticsTrackingId;
@synthesize jsonDownloadConfig;
@synthesize jsonImages;
@synthesize jsonLocalPushNotifications;
@synthesize jsonProducts;
@synthesize jsonUser;
@synthesize jsonUserSession;
@synthesize promotionalText;
@synthesize promotionalUrl;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.analyticsDomainName forKey:@"analyticsDomainName"];
    [encoder encodeObject:self.apiBaseUrl forKey:@"apiBaseUrl"];
    [encoder encodeObject:self.apiDomainName forKey:@"apiDomainName"];
    [encoder encodeObject:self.appleId forKey:@"appleId"];
    [encoder encodeObject:self.cdnDomainName forKey:@"cdnDomainName"];
    [encoder encodeObject:self.chartboostAppId forKey:@"chartboostAppId"];
    [encoder encodeObject:self.chartboostAppSignature forKey:@"chartboostAppSignature"];
    [encoder encodeObject:self.flurryAppKey forKey:@"flurryAppKey"];
    [encoder encodeObject:self.googleAnalyticsTrackingId forKey:@"googleAnalyticsTrackingId"];
    [encoder encodeObject:self.jsonDownloadConfig forKey:@"jsonDownloadConfig"];
    [encoder encodeObject:self.jsonImages forKey:@"jsonImages"];
    [encoder encodeObject:self.jsonLocalPushNotifications forKey:@"jsonLocalPushNotifications"];
    [encoder encodeObject:self.jsonProducts forKey:@"jsonProducts"];
    [encoder encodeObject:self.jsonUser forKey:@"jsonUser"];
    [encoder encodeObject:self.jsonUserSession forKey:@"jsonUserSession"];
    [encoder encodeObject:self.promotionalText forKey:@"promotionalText"];
    [encoder encodeObject:self.promotionalUrl forKey:@"promotionalUrl"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.analyticsDomainName = [decoder decodeObjectForKey:@"analyticsDomainName"];
        self.apiBaseUrl = [decoder decodeObjectForKey:@"apiBaseUrl"];
        self.apiDomainName = [decoder decodeObjectForKey:@"apiDomainName"];
        self.appleId = [decoder decodeObjectForKey:@"appleId"];
        self.cdnDomainName = [decoder decodeObjectForKey:@"cdnDomainName"];
        self.chartboostAppId = [decoder decodeObjectForKey:@"chartboostAppId"];
        self.chartboostAppSignature = [decoder decodeObjectForKey:@"chartboostAppSignature"];
        self.flurryAppKey = [decoder decodeObjectForKey:@"flurryAppKey"];
        self.googleAnalyticsTrackingId = [decoder decodeObjectForKey:@"googleAnalyticsTrackingId"];
        self.jsonDownloadConfig = [decoder decodeObjectForKey:@"jsonDownloadConfig"];
        self.jsonImages = [decoder decodeObjectForKey:@"jsonImages"];
        self.jsonLocalPushNotifications = [decoder decodeObjectForKey:@"jsonLocalPushNotifications"];
        self.jsonProducts = [decoder decodeObjectForKey:@"jsonProducts"];
        self.jsonUser = [decoder decodeObjectForKey:@"jsonUser"];
        self.jsonUserSession = [decoder decodeObjectForKey:@"jsonUserSession"];
        self.promotionalText = [decoder decodeObjectForKey:@"promotionalText"];
        self.promotionalUrl = [decoder decodeObjectForKey:@"promotionalUrl"];
    }
    return self;
}

+ (Config *)instanceFromDictionary:(NSDictionary *)aDictionary
{
    
    Config *instance = [[Config alloc] init];
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

- (NSDictionary *)dictionaryRepresentation
{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.analyticsDomainName) {
        [dictionary setObject:self.analyticsDomainName forKey:@"analyticsDomainName"];
    }
    
    if (self.apiBaseUrl) {
        [dictionary setObject:self.apiBaseUrl forKey:@"apiBaseUrl"];
    }
    
    if (self.apiDomainName) {
        [dictionary setObject:self.apiDomainName forKey:@"apiDomainName"];
    }
    
    if (self.appleId) {
        [dictionary setObject:self.appleId forKey:@"appleId"];
    }
    
    if (self.cdnDomainName) {
        [dictionary setObject:self.cdnDomainName forKey:@"cdnDomainName"];
    }
    
    if (self.chartboostAppId) {
        [dictionary setObject:self.chartboostAppId forKey:@"chartboostAppId"];
    }
    
    if (self.chartboostAppSignature) {
        [dictionary setObject:self.chartboostAppSignature forKey:@"chartboostAppSignature"];
    }
    
    if (self.flurryAppKey) {
        [dictionary setObject:self.flurryAppKey forKey:@"flurryAppKey"];
    }
    
    if (self.googleAnalyticsTrackingId) {
        [dictionary setObject:self.googleAnalyticsTrackingId forKey:@"googleAnalyticsTrackingId"];
    }
    
    if (self.jsonDownloadConfig) {
        [dictionary setObject:self.jsonDownloadConfig forKey:@"jsonDownloadConfig"];
    }
    
    if (self.jsonImages) {
        [dictionary setObject:self.jsonImages forKey:@"jsonImages"];
    }
    
    if (self.jsonLocalPushNotifications) {
        [dictionary setObject:self.jsonLocalPushNotifications forKey:@"jsonLocalPushNotifications"];
    }
    
    if (self.jsonProducts) {
        [dictionary setObject:self.jsonProducts forKey:@"jsonProducts"];
    }
    
    if (self.jsonUser) {
        [dictionary setObject:self.jsonUser forKey:@"jsonUser"];
    }
    
    if (self.jsonUserSession) {
        [dictionary setObject:self.jsonUserSession forKey:@"jsonUserSession"];
    }
    
    if (self.promotionalText) {
        [dictionary setObject:self.promotionalText forKey:@"promotionalText"];
    }
    
    if (self.promotionalUrl) {
        [dictionary setObject:self.promotionalUrl forKey:@"promotionalUrl"];
    }
    
    return dictionary;
    
}

@end
