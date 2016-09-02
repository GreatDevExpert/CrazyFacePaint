/** @warning *Important:* This class is created automatically using Objectifty (http://tigerbears.com/objectify/). Code should not be modified directly but rather should use https://github.com/ninjafishstudios/ninjafish-templates/blob/master/App/App/Resources/Json/Config.json file to create class.
 */
//
//  Config.h
//
//
//  Created by ___FULLUSERNAME___ on 4/9/13.
//  Copyright (c) 2013. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface NFConfig : NSObject <NSCoding> {

    NSString *adcolonyAppId;
    NSString *adcolonyV4VCSecretyKey;
    NSString *adcolonyZoneId;
    
    NSString *admob320x50PhoneBannerAdUnitId;
    NSString *admob728x90TabletBannerAdUnitId;
    NSString *admobInterstitialAdUnitId;
    NSString *admobVideoAdUnitId;
    
    NSString *analyticsDomainName;
    NSString *apiBaseUrl;
    NSString *apiDomainName;
    NSString *appleId;
    NSString *cdnDomainName;
    NSString *chartboostAppId;
    NSString *chartboostAppSignature;
    NSString *flurryAppKey;
    NSString *googleAnalyticsTrackingId;
    NSString *jsonDownloadConfig;
    NSString *jsonImages;
    NSString *jsonLocalPushNotifications;
    NSString *jsonProducts;
    NSString *jsonUser;
    NSString *jsonUserSession;
    NSString *mopub320x50PhoneBannerAdUnitId;
    NSString *mopub728x90TabletBannerAdUnitId;
    NSString *mopubFullPhoneInterstitialAdUnitId;
    NSString *mopubFullTabletInterstitialAdUnitId;
    NSString *nativexAppId;
    NSString *promotionalText;
    NSString *promotionalUrl;
    
    NSString *vungleAppId;
}

@property (nonatomic, copy) NSString *adcolonyAppId;
@property (nonatomic, copy) NSString *adcolonyV4VCSecretyKey;
@property (nonatomic, copy) NSString *adcolonyZoneId;
@property (nonatomic, copy) NSString *admob320x50PhoneBannerAdUnitId;
@property (nonatomic, copy) NSString *admob728x90TabletBannerAdUnitId;
@property (nonatomic, copy) NSString *admobInterstitialAdUnitId;
@property (nonatomic, copy) NSString *admobVideoAdUnitId;

@property (nonatomic, copy) NSString *analyticsDomainName;
@property (nonatomic, copy) NSString *apiBaseUrl;
@property (nonatomic, copy) NSString *apiDomainName;
@property (nonatomic, copy) NSString *appleId;
@property (nonatomic, copy) NSString *cdnDomainName;
@property (nonatomic, copy) NSString *chartboostAppId;
@property (nonatomic, copy) NSString *chartboostAppSignature;
@property (nonatomic, copy) NSString *flurryAppKey;
@property (nonatomic, copy) NSString *googleAnalyticsTrackingId;
@property (nonatomic, copy) NSString *jsonDownloadConfig;
@property (nonatomic, copy) NSString *jsonImages;
@property (nonatomic, copy) NSString *jsonLocalPushNotifications;
@property (nonatomic, copy) NSString *jsonProducts;
@property (nonatomic, copy) NSString *jsonUser;
@property (nonatomic, copy) NSString *jsonUserSession;
@property (nonatomic, copy) NSString *mopub320x50PhoneBannerAdUnitId;
@property (nonatomic, copy) NSString *mopub728x90TabletBannerAdUnitId;
@property (nonatomic, copy) NSString *mopubFullPhoneInterstitialAdUnitId;
@property (nonatomic, copy) NSString *mopubFullTabletInterstitialAdUnitId;
@property (nonatomic, copy) NSString *nativexAppId;
@property (nonatomic, copy) NSString *promotionalText;
@property (nonatomic, copy) NSString *promotionalUrl;
@property (nonatomic, copy) NSString *vungleAppId;

+ (NFConfig *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
