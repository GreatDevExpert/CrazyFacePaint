/** @warning *Important:* This class is created automatically using Objectifty (http://tigerbears.com/objectify/). Code should not be modified directly but rather should use https://github.com/ninjafishstudios/ninjafish-templates/blob/master/App/App/Resources/Json/Config.json file to create class.
 */
//
//  Config.h
//
//
//  Created by ___FULLUSERNAME___ on 4/9/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject <NSCoding> {
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
    NSString *promotionalText;
    NSString *promotionalUrl;
}

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
@property (nonatomic, copy) NSString *promotionalText;
@property (nonatomic, copy) NSString *promotionalUrl;

+ (Config *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
