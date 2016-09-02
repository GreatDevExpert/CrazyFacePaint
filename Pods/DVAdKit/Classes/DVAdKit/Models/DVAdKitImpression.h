//
//  DVAdKitImpression.h
//
//
//  Created by ___FULLUSERNAME___ on 6/14/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DVAdKitAd;
@class DVAdKitApp;
@class DVAdKitAdDisplaySettings;
@class DVAdKitDevice;



@interface DVAdKitImpression : NSObject <NSCoding> {
    DVAdKitAd *ad;
    NSNumber *adId;
    NSNumber *advertisingCampaignId;
    DVAdKitApp *app;
    NSNumber *appId;
    NSNumber *campaignId;
    BOOL clicked;
    BOOL clickedProxy;
    NSString *createdAt;
    NSNumber *deviceId;
    DVAdKitDevice *device;
    NSNumber *identifier;
    BOOL installed;
    BOOL maxPerDayReached;
    BOOL maxPerHourReached;
    NSNumber *publishingCampaignId;
    NSString *uniqueToken;
    NSString *updatedAt;
    DVAdKitAdDisplaySettings *adDisplaySettings;
}

@property (nonatomic, strong) DVAdKitAd *ad;
@property (nonatomic, copy) NSNumber *adId;
@property (nonatomic, copy) NSNumber *advertisingCampaignId;
@property (nonatomic, strong) DVAdKitApp *app;
@property (nonatomic, copy) NSNumber *appId;
@property (nonatomic, copy) NSNumber *campaignId;
@property (nonatomic, assign) BOOL clicked;
@property (nonatomic, assign) BOOL clickedProxy;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSNumber *deviceId;
@property (nonatomic, strong) DVAdKitDevice *device;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, assign) BOOL installed;
@property (nonatomic, assign) BOOL maxPerDayReached;
@property (nonatomic, assign) BOOL maxPerHourReached;
@property (nonatomic, copy) NSNumber *publishingCampaignId;
@property (nonatomic, copy) NSString *uniqueToken;
@property (nonatomic, copy) NSString *updatedAt;
@property (nonatomic, strong) DVAdKitAdDisplaySettings *adDisplaySettings;


+ (DVAdKitImpression *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
