//
//  NFAnalytics.m
//
//  Created by William Locke on 3/5/13.
//
//

#import "DVAdKit.h"

#import <AdSupport/AdSupport.h>
#import "OpenUDID.h"
#import "DVAdViewController.h"
#import "DVAdKitDevice.h"
#import "DVAdKitApp.h"
#import "DVAdKitImpression.h"
#import "DVAdKitAd.h"
#import "DVAdKitManagedObjects.h"
#import "DVAdKitInstall.h"
#import "DVDate.h"
#import "NSString+MD5.h"
#import "DVAdKitCreative.h"
#import "DVAdKitAdLogic.h"
#import "DVWebApiClient.h"
#import "DVImageDownloader.h"
#import "DVStoreKit.h"
#import "DVAdKitPurchase.h"
#import "DVAdKitWebAPI.h"
#import <StoreKit/StoreKit.h>

// DLog will output like DVAdKitLog only when the DEBUG variable is set
#define DEBUG_ YES

#ifdef DEBUG_
#   define DVAdKitLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DVAdKitLog(...)
#endif


// TODO: FIND BEST LOCATION FOR CONSTANTS
typedef void (^ DVAdKitInstallCallback)(BOOL installed);
NSString * const kNFAdsDeviceIdentifierTypeOpenUDID = @"open_udid";
NSString * const kNFAdsDeviceIdentifierTypeAdvertisingIdentifier = @"advertising_identifier";
NSString * const kNFAdsDeviceIdentifierTypeIdentifierForVendor = @"identifier_for_vendor";
NSString * const kNFAdsSecureKey = @"7d506e3954385d7e2636466a502d716727736f2c774f6b7c4a69593068";
NSString * const kDVAdKitErrorNameMaxPerHourReached = @"MaxPerHourReached";
NSString * const kDVAdKitErrorNameMaxPerDayReached = @"MaxPerDayReached";
NSString * const kDVAdKitErrorNameRecordNotFound = @"RecordNotFound";
NSString * const kDVAdKitPasteboardName = @"com.dvadkit";

NSString * const kDVAdKitParameterOptionShouldFilter = @"should_filter";
NSString * const kDVAdKitParameterOptionLocationInAppLabel = @"zone";
NSString * const kDVAdKitParameterOptionShouldBlockIfAdsNotFound = @"should_block_if_ads_not_found";
NSString * const kDVAdKitParameterOptionOverrideLocalBlocking = @"override_local_blocking";


// TODO: add throttling for max number of errors.
// TODO: add reachability check.


@interface DVAdKitWebAPI()<DVAdViewControllerDelegate>{
//    DVWebApiClient *_webApi;
    NSString *_deviceIdentifier;
    NSString *_deviceIdentifierType;
    
    // TODO: uncomment.
    //DVAdViewController *_adViewController;
    DVAdKitDevice *_device;
    DVAdKitApp *_app;
    NSMutableArray *_queuedInvocations;
    
    NSDate *_methodNamedShowInterstitialLastCalledAt;
}

@end

@implementation DVAdKitWebAPI

- (id)init
{
    self = [super init];
    if (self) {
        
        @try {
            /**/
            _webApi = [[DVWebApiClient alloc] initWithBaseUrl:@"http://www.dvadkit.com/api"];
            /*/
             
             _webApi = [[DVWebApiClient alloc] initWithBaseUrl:@"http://aws.dvadkit.com/api"];
             
             //*/
            
            
#ifdef DEBUG
//            _webApi = [[DVWebApiClient alloc] initWithBaseUrl:@"http://staging.dvadkit.com/api"];
            
            _webApi = [[DVWebApiClient alloc] initWithBaseUrl:@"http://localhost:3000/api"];
//            _webApi = [[DVWebApiClient alloc] initWithBaseUrl:@"http://192.168.1.6:3000/api"];
            
#endif
            
            
#ifdef __DVADKIT_USE_STAGING_SERVER__
            _webApi = [[DVWebApiClient alloc] initWithBaseUrl:@"http://aws.dvadkit.com/api"];
#endif
            
            // TODO: remove this. Set this only in non COPPA mode.
            _webApi.httpAuthenticationKey = [self httpAuthenticationKey];
            
            NSString *versionNumber = [self apiVersionNumber];
            
            _webApi.headerFields = [[NSMutableDictionary alloc] initWithObjectsAndKeys:versionNumber, @"X-DVAdKitVersion", @"application/json", @"Content-Type", nil];
            
            //            _webApi.headerFields = [[NSMutableDictionary alloc] initWithDictionary:@{@"X-DVAdKitVersion":[self apiVersionNumber], @"Content-Type":@"application/json"}];
            
            DVAdKitLog(@"API VERSION NUMBER: %@", [self apiVersionNumber]);
            
            _deviceIdentifier = [self deviceIdentifier];
            _deviceIdentifierType = [self availableDeviceIdentifierType];
            
            _device = [[DVAdKitManagedObjects sharedInstance] device];
            _app = [[DVAdKitManagedObjects sharedInstance] app];
            
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad || [UIScreen mainScreen].bounds.size.width == 768){
                _device.model = @"iPad";
            }else{
                _device.model = @"iPhone";
            }
            
            [DVStoreKit sharedInstance];
            
        }
        @catch (NSException *exception) {
            DVAdKitLog(@"Exception");
        }
        @finally {
            
        }
        
    }
    return self;
}

+ (id)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}




#pragma mark Web Api
-(void)webApiCall:(NSString *)url
           params:(NSMutableDictionary *)params
       httpMethod:(NSString *)httpMethod
          options:(NSMutableDictionary *)options NFWebApiResponseHandler:(NFWebApiResponseHandler)NFWebApiResponseHandler{
    
    NSString *timestamp = [DVDate delocalizedDateStringForDate:[NSDate date]];
    NSString *TOTP = [[@"" stringByAppendingFormat:@"%@%@", timestamp, kNFAdsSecureKey] MD5Digest];
    if(!_webApi.headerFields){
        _webApi.headerFields = [[NSMutableDictionary alloc] init];
    }
    [_webApi.headerFields setValue:TOTP forKey:@"X-DVAdKitTOTP"];
    [_webApi.headerFields setValue:timestamp forKey:@"X-DVAdKitTimestamp"];
    [_webApi.headerFields setValue:@"application/json" forKey:@"Content-Type"];
    
    DVAdKitLog(@"_webApi.headerFields: %@", _webApi.headerFields);
    
    
    [_webApi webApiCall:url params:params httpMethod:httpMethod options:options NFWebApiResponseHandler:NFWebApiResponseHandler];
    
}


#pragma mark Start
-(void)start{
    
    if(!_appKey){
        _appKey = [self createAppKey];
    }
    //[self startSessionUsingApiKey:_appKey];
    
    @try {
        if(!_app.identifier || (!_app.isKidsApp && !_device.identifier)){
            [self install];
        }else{
            [self refreshStaleLocalData];
        }
    }
    @catch (NSException *exception) {
        DVAdKitLog(@"NSException: %@", [exception description]);
    }
    @finally {
    }
}

-(void)startSession{
    [self start];
}

-(void)startSessionUsingApiKey:(NSString *)apiKey{
    @try {
        _appKey = apiKey;
        if(!_app.identifier || (!_app.isKidsApp && !_device.identifier)){
            [self install];
        }else{
            [self refreshStaleLocalData];
        }
    }
    @catch (NSException *exception) {
        DVAdKitLog(@"NSException: %@", [exception description]);
    }
    @finally {
    }
    
}

-(void)refreshStaleLocalData{
    
    NSDate *appDataLastQueriedAt = [[DVAdKitManagedObjects sharedInstance] appDataLastQueriedAt];
    NSDate *appsInstalledDataLastQueriedAt = [[DVAdKitManagedObjects sharedInstance] appsInstalledDataLastQueriedAt];
    
    if (appDataLastQueriedAt) {
        
        if(([[NSDate date] timeIntervalSince1970] - [appDataLastQueriedAt timeIntervalSince1970]) > kDVDateTimeIntervalOneDay){
            
            [self getThisApp:^(DVAdKitApp *app, NSError *error){
                @try {
                    
                    // TODO: move this to getThisApp function?
                    if(app){
                        _app = app;
                        [[DVAdKitManagedObjects sharedInstance] setAppDataLastQueriedAt:[NSDate date]];
                        [[DVAdKitManagedObjects sharedInstance] setApp:_app];
                        [[DVAdKitManagedObjects sharedInstance] saveApp];
                        [[DVAdKitManagedObjects sharedInstance] saveAppDataLastQueriedAt];
                    }
                    
                }
                @catch (NSException *exception) {
                    DVAdKitLog(@"Exception");
                }
                @finally {
                }
                
            }];
        }
    }
    
    if(appsInstalledDataLastQueriedAt){
        if(([[NSDate date] timeIntervalSince1970] - [appsInstalledDataLastQueriedAt timeIntervalSince1970]) > kDVDateTimeIntervalOneWeek){
            
            [self getAppsInstalledOnThisDevice:^(NSArray *installs, NSError *error){
                
            }];
        }
    }
}

-(void)startUpActionsComplete{
    @try {
        DVAdKitLog(@"Start Up Actions Complete");
        
        if(_methodNamedShowInterstitialLastCalledAt){
            
            NSDate *lastImpressionShownAt;
            if([[DVAdKitManagedObjects sharedInstance] lastImpression] && [[DVAdKitManagedObjects sharedInstance] lastImpression].createdAt){
                lastImpressionShownAt = [DVDate dateFromString:[[DVAdKitManagedObjects sharedInstance] lastImpression].createdAt];
            }
            
            int timeIntervalSinceShowInterstitialLastCalled = [[NSDate date] timeIntervalSince1970] - [_methodNamedShowInterstitialLastCalledAt timeIntervalSince1970];
            
            if(timeIntervalSinceShowInterstitialLastCalled < kDVDateTimeIntervalOneMinute * 2){
                int timeIntervalSinceImpressionLastShown = 10000000; // Some large number.
                if(lastImpressionShownAt){
                    timeIntervalSinceImpressionLastShown = [[NSDate date] timeIntervalSince1970] - [lastImpressionShownAt timeIntervalSince1970];
                }
                
                if(timeIntervalSinceImpressionLastShown > kDVDateTimeIntervalOneMinute * 2){
                    [self showInterstitial];
                }
            }
        }
    }
    @catch (NSException *exception) {
        DVAdKitLog(@"Exception: %@", [exception debugDescription]);
    }
    @finally {
        
    }
}

#pragma mark Authentication
-(NSString *)httpAuthenticationKey{
    return [[@"" stringByAppendingFormat:@"%@%@", [self deviceIdentifier], kNFAdsSecureKey] MD5Digest];
}

-(NSString *)createAppKey{
    return [[[@"" stringByAppendingFormat:@"%@%@", [[NSBundle mainBundle] bundleIdentifier], kNFAdsSecureKey] MD5Digest] uppercaseString];
}

#pragma mark Api Version Number
-(NSString *)apiVersionNumber{
    NSString *versionString = @"Unknown";
    @try {
        NSString *mainBundlePath = [[NSBundle mainBundle] bundlePath];
        NSString *podspecPath = [mainBundlePath stringByAppendingPathComponent:@"DVAdKit.podspec"];
        NSString *podspecString = [NSString stringWithContentsOfFile:podspecPath encoding:NSUTF8StringEncoding error:nil];
        
        NSRange range = [podspecString rangeOfString:@"s.version"];
        NSString *tmpString = [podspecString substringFromIndex:range.location];
        range = [tmpString rangeOfString:@"="];
        tmpString = [tmpString substringFromIndex:range.location];
        NSRange rangeOfFirstQuote = [tmpString rangeOfString:@"\""];
        tmpString = [tmpString substringFromIndex:rangeOfFirstQuote.location+1];
        NSRange rangeOfSecondQuote = [tmpString rangeOfString:@"\""];
        versionString = [tmpString substringToIndex:rangeOfSecondQuote.location];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    return versionString;
}

#pragma mark Pasteboard
-(NSDictionary *)impressionDictionaryFromPasteboardForApp:(DVAdKitApp *)app{
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:kDVAdKitPasteboardName create:NO];//no because we doesn't want to create a new one
    
    if (pb) {
        
        NSArray *dataArray = [pb items];
        
        for(NSDictionary *click in dataArray){
            NSString *appId;
            NSString *impressionId;
            NSString *impressionUniqueToken;
            
            if([click valueForKey:@"app_id"]){
                appId = [[NSString alloc] initWithData:[click valueForKey:@"app_id"] encoding:NSUTF8StringEncoding];
                
                if([appId isKindOfClass:[NSString class]] && [appId intValue] == [app.identifier intValue]){
                    if([click valueForKey:@"impression_id"]){
                        impressionId = [[NSString alloc] initWithData:[click valueForKey:@"impression_id"] encoding:NSUTF8StringEncoding];
                    }
                    
                    if([click valueForKey:@"impression_unique_token"]){
                        impressionUniqueToken = [[NSString alloc] initWithData:[click valueForKey:@"impression_unique_token"] encoding:NSUTF8StringEncoding];
                    }
                    
                    NSMutableDictionary *impressionDictionary = [[NSMutableDictionary alloc] init];
                    if(impressionUniqueToken && impressionId){
                        [impressionDictionary setValue:impressionId forKey:@"impression_id"];
                        [impressionDictionary setValue:impressionUniqueToken forKey:@"impression_unique_token"];
                        
                        DVAdKitLog(@"Found impressionDictionary: %@", impressionDictionary);
                        
                        return impressionDictionary;
                    }
                }
            }
        }
    }
    
    return nil;
}

-(void)addClickEventToPasteboardForImpression:(DVAdKitImpression *)impression{
    if(!impression || !impression.identifier){
        return;
    }
    
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:kDVAdKitPasteboardName create:NO];//no because we doesn't want to create a new one
    if(!pb){
        pb = [UIPasteboard pasteboardWithName:kDVAdKitPasteboardName create:YES];
    }
    
    if ([pb items]) {
        NSMutableArray *newItems = [[NSMutableArray alloc] init];
        if([pb items]){
            [newItems addObjectsFromArray:[pb items]];
        }
        
        NSMutableDictionary *clickItem = [[NSMutableDictionary alloc] init];
        [clickItem setValue:[@"" stringByAppendingFormat:@"%@", impression.ad.app.identifier] forKey:@"app_id"];
        [clickItem setValue:[@"" stringByAppendingFormat:@"%@", impression.identifier] forKey:@"impression_id"];
        [clickItem setValue:impression.uniqueToken forKey:@"impression_unique_token"];
        [newItems addObject:clickItem];
        [pb setItems:newItems];
        [pb setPersistent:YES];
        
        DVAdKitLog(@"added Click item: %@", clickItem);
        
    }
}


#pragma mark AppKey
-(void)setAppKey:(NSString *)appKey{
    _appKey = appKey;
}


#pragma mark ===== INSTALLS =====
-(void)install{
    if(!self.appKey){
        DVAdKitLog(@"Warning: app key not set");
        return;
    }
    
    [self getThisApp:^(DVAdKitApp *app, NSError *error){
        
        @try {
            if(!app){
                return;
            }
            
            _app = app;
            [[DVAdKitManagedObjects sharedInstance] setApp:_app];
            [[DVAdKitManagedObjects sharedInstance] saveApp];
            
            NSDictionary *impressionDictionary = [self impressionDictionaryFromPasteboardForApp:app];
            
            if(!app.isKidsApp || (impressionDictionary && [impressionDictionary valueForKey:@"impression_unique_token"])){
                
                [self createInstall:^(DVAdKitInstall *install, NSError *error){
                    @try {
                        
                        if(install){
                            _app = install.app;
                            
                            
#ifndef ANDROID
                            if((!_app.uniqueToken || [_app.uniqueToken isEqualToString:@""]) && (_app.appKey && ![_app.appKey isEqualToString:@""])){
                                _app.uniqueToken = _app.appKey;
                            }
#endif
                            
                            _device = install.device;
                            [[DVAdKitManagedObjects sharedInstance] setApp:install.app];
                            [[DVAdKitManagedObjects sharedInstance] setAppDataLastQueriedAt:[NSDate date]];
                            [[DVAdKitManagedObjects sharedInstance] setDevice:install.device];
                            [[DVAdKitManagedObjects sharedInstance] saveAppDataLastQueriedAt];
                            [[DVAdKitManagedObjects sharedInstance] saveApp];
                            [[DVAdKitManagedObjects sharedInstance] saveDevice];
                            
                            [self getAppsInstalledOnThisDevice:^(NSArray *installs, NSError *error){
                                [self startUpActionsComplete];
                                
                            }];
                        }
                    }
                    @catch (NSException *exception) {
                        DVAdKitLog(@"Exception: %@", [exception description]);
                    }
                    @finally {
                    }
                }];
            }
            
            
            
        }
        @catch (NSException *exception) {
            DVAdKitLog(@"Exception: %@", [exception debugDescription]);
        }
        @finally {
        }
        
    }];
}


-(void)createInstall:(void (^ )(DVAdKitInstall *install, NSError *error))completionHandler{
    if(!self.appKey){
        DVAdKitLog(@"Warning: self.appKey is not set.");
        return;
    }
    
    
    NSMutableDictionary *params;
    
    
    if(_app && _app.isKidsApp){
        NSDictionary *impressionDictionary = [self impressionDictionaryFromPasteboardForApp:_app];
        NSString *impressionUniqueToken = @"";
        NSString *impressionId = @"";
        
        if([impressionDictionary valueForKey:@"impression_unique_token"]){
            impressionUniqueToken = [impressionDictionary valueForKey:@"impression_unique_token"];
        }
        if([impressionDictionary valueForKey:@"impression_id"]){
            impressionId = [impressionDictionary valueForKey:@"impression_id"];
        }
        
        // TODO: deprecate app[unique_token]
        params = [[NSMutableDictionary alloc] initWithDictionary:@{@"app":@{@"unique_token":_app.uniqueToken, @"app_key":self.appKey}, @"impression":@{@"id":impressionId, @"unique_token":impressionUniqueToken}}];
        
        
    }else{
        // TODO: deprecate app[unique_token]
        params = [[NSMutableDictionary alloc] initWithDictionary:@{[self availableDeviceIdentifierType]:[self deviceIdentifier], @"app_key":self.appKey, @"app":@{@"unique_token":self.appKey, @"app_key":self.appKey}, @"device":@{[self availableDeviceIdentifierType]:[self deviceIdentifier]} }];
        
        NSString *openUdid = [self openUDID];
        NSString *identifierForVendor = [self identifierForVendor];
        NSString *advertisingIdentifier = [self advertisingIdentifier];
        NSMutableDictionary *deviceOptions = [[NSMutableDictionary alloc] init];
        if (openUdid) {
            [params setValue:openUdid forKey:kNFAdsDeviceIdentifierTypeOpenUDID];
            [deviceOptions setValue:openUdid forKey:kNFAdsDeviceIdentifierTypeOpenUDID];
        }
        
        if (identifierForVendor) {
            [params setValue:identifierForVendor forKey:kNFAdsDeviceIdentifierTypeIdentifierForVendor];
            [deviceOptions setValue:identifierForVendor forKey:kNFAdsDeviceIdentifierTypeIdentifierForVendor];
        }
        if (advertisingIdentifier) {
            [params setValue:advertisingIdentifier forKey:kNFAdsDeviceIdentifierTypeAdvertisingIdentifier];
            [deviceOptions setValue:advertisingIdentifier forKey:kNFAdsDeviceIdentifierTypeAdvertisingIdentifier];
        }
        [params setValue:[UIDevice currentDevice].model forKey:@"model"];
        NSString *osVersion = [@"" stringByAppendingFormat:@"%@", [[UIDevice currentDevice] systemVersion]];
        [params setValue:osVersion forKey:@"os_version"];
        [deviceOptions setValue:osVersion forKey:@"os_version"];
        [deviceOptions setValue:[UIDevice currentDevice].model forKey:@"model"];
        
        NSString *countryCode = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
        if(countryCode){
            [params setValue:countryCode forKey:@"country_code"];
            [deviceOptions setValue:countryCode forKey:@"country_code"];
        }
        NSString *screenScale = [@"" stringByAppendingFormat:@"%.2f", [[UIScreen mainScreen] scale]];
        [params setValue:screenScale forKey:@"screen_scale"];
        [deviceOptions setValue:screenScale forKey:@"screen_scale"];
        
        [params setValue:deviceOptions forKey:@"device"];

    }
    
    
    
    // NFNetworking
    [self webApiCall:@"/installs/" params:params httpMethod:@"POST" options:nil NFWebApiResponseHandler:^(id<DVWebApiResponse> webApiResponse){
        
        @try {
            // TOOD: move this to WebApiResponseData class/protocol.
            NSDictionary *firstItem;
            if([[[webApiResponse data] items] count] > 0){
                firstItem = [[[webApiResponse data] items] objectAtIndex:0];
            }
            if(![webApiResponse error]){
                DVAdKitInstall *install = [DVAdKitInstall instanceFromDictionary:firstItem];
                completionHandler(install, nil);
            }else{
                
                completionHandler(nil, [webApiResponse error]);
            }
        }
        @catch (NSException *exception) {
            DVAdKitLog(@"Exception");
        }
        @finally {
        }
        
    }];
    
}

// TODO: break this into two functions, by adding generic getInstalls: function.
-(void)getAppsInstalledOnThisDevice:(void (^ )(NSArray *installs, NSError *error))completionHandler{
    
    if(!(_device.identifier && _app.identifier)){
        DVAdKitLog(@"Warning: _device.identifier and _app.identifier are not set. App still needs to call install api to get its ID values for app and device");
        
        return;
    }
    
    
    // TODO: deprecate app[unique_token]
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"device_id":_device.identifier, @"app_id":_app.identifier, @"device":@{@"id":_device.identifier}, @"app":@{@"id":_app.identifier, @"app_key":_app.appKey, @"unique_token": _app.uniqueToken ? _app.uniqueToken : @"" } }];
    
    
    // NFNetworking
    [self webApiCall:@"/installs/" params:params httpMethod:@"GET" options:nil NFWebApiResponseHandler:^(id<DVWebApiResponse> webApiResponse){
        
        @try {
            NSArray *items = nil;
            if(webApiResponse && [webApiResponse data] && [[webApiResponse data] items]) {
                items = [[webApiResponse data] items];
            }
            
            if(items){
                NSMutableArray *installs;
                if([[DVAdKitManagedObjects sharedInstance] appsInstalled]){
                    installs = [[DVAdKitManagedObjects sharedInstance] appsInstalled];
                }else{
                    installs = [[NSMutableArray alloc] init];
                }
                
                for(NSDictionary *item in items){
                    if([item isKindOfClass:[NSDictionary class]]){
                        DVAdKitInstall *install = [DVAdKitInstall instanceFromDictionary:item];
                        [installs addObject:install.app];
                    }
                }
                
                [[DVAdKitManagedObjects sharedInstance] setAppsInstalled:installs];
                [[DVAdKitManagedObjects sharedInstance] setAppsInstalledDataLastQueriedAt:[NSDate date]];
                [[DVAdKitManagedObjects sharedInstance] saveAppsInstalledDataLastQueriedAt];
                [[DVAdKitManagedObjects sharedInstance] saveAppsInstalled];
                
            }
            
            completionHandler(items, [webApiResponse error]);
            
        }
        @catch (NSException *exception) {
            DVAdKitLog(@"Exception")
        }
        @finally {
            
        }
        
        
    }];
    
}




#pragma mark Apps
// TODO: break this into two functions, by adding generic getApp: function.
-(void)getThisApp:(void (^ )(DVAdKitApp *app, NSError *error))completionHandler{
    //    if(!(_device.identifier && _app.identifier)){
    //        DVAdKitLog(@"Warning: _device.identifier and _app.identifier are not set. App still needs to call install api to get its ID values for app and device");
    //        return;
    //    }
    
    NSString *appKey = _appKey;
    
    if(!appKey){
        appKey = [self createAppKey];
    }
    
    
    //    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"device_id":_device.identifier, @"app_id":_app.identifier}];
    
    NSString *buildConfiguration = @"Release";
#ifdef DEBUG
    buildConfiguration = @"Debug";
#endif
    NSString *displayName = @"";
    
    if([[NSBundle mainBundle] objectForInfoDictionaryKey:(__bridge NSString*)kCFBundleNameKey]){
        displayName = [[NSBundle mainBundle] objectForInfoDictionaryKey:(__bridge NSString*)kCFBundleNameKey];
    }
    
    // TODO: deprecate app[unique_token]
    NSMutableDictionary *params = (NSMutableDictionary *) @{@"app":@{@"unique_token":appKey, @"app_key":appKey, @"bundle_identifier":[[NSBundle mainBundle] bundleIdentifier], @"display_name":displayName}, @"build_configuration":buildConfiguration};
    
    
    NSString *urlString = @"/apps/";
    
    // NFNetworking
    [self webApiCall:urlString params:params httpMethod:@"GET" options:nil NFWebApiResponseHandler:^(id<DVWebApiResponse> webApiResponse){
        
        @try {
            // TOOD: move this to WebApiResponseData class/protocol.
            NSDictionary *firstItem;
            if([[[webApiResponse data] items] count] > 0){
                firstItem = [[[webApiResponse data] items] objectAtIndex:0];
            }
            if(![webApiResponse error]){
                DVAdKitApp *app = [DVAdKitApp instanceFromDictionary:firstItem];
                
                completionHandler(app, nil);
            }else{
                if([[webApiResponse error] code] == 404){
                    [self createApp:completionHandler];
                }else{
                    completionHandler(nil, [webApiResponse error]);
                }
            }
        }
        @catch (NSException *exception) {
            DVAdKitLog(@"Exception")
        }
        @finally {
        }
    }];
}


-(void)createApp:(void (^ )(DVAdKitApp *app, NSError *error))completionHandler{
    //    if(!(_device.identifier && _app.identifier)){
    //        DVAdKitLog(@"Warning: _device.identifier and _app.identifier are not set. App still needs to call install api to get its ID values for app and device");
    //        return;
    //    }
    
    NSString *appKey = _appKey;
    
    if(!appKey){
        appKey = [self createAppKey];
    }
    
    
    //    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"device_id":_device.identifier, @"app_id":_app.identifier}];
    
    NSString *buildConfiguration = @"Release";
#ifdef DEBUG
    buildConfiguration = @"Debug";
#endif
    NSString *displayName = @"";
    
    if([[NSBundle mainBundle] objectForInfoDictionaryKey:(__bridge NSString*)kCFBundleNameKey]){
        displayName = [[NSBundle mainBundle] objectForInfoDictionaryKey:(__bridge NSString*)kCFBundleNameKey];
    }
    
    NSString *orientation = @"portrait";
    @try {
        UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        if(rootViewController && rootViewController.view.frame.size.width > rootViewController.view.frame.size.height){
            orientation = @"landscape";
        }
    }
    @catch (NSException *exception) {
        
    }
    
    
    // TODO: deprecate app[unique_token]
    NSMutableDictionary *params = (NSMutableDictionary *) @{@"app":@{@"unique_token":appKey, @"app_key":appKey, @"bundle_identifier":[[NSBundle mainBundle] bundleIdentifier], @"display_name":displayName, @"orientation":orientation}, @"build_configuration":buildConfiguration};
    
    
    NSString *urlString = @"/apps/";
    
    // NFNetworking
    [self webApiCall:urlString params:params httpMethod:@"POST" options:nil NFWebApiResponseHandler:^(id<DVWebApiResponse> webApiResponse){
        
        @try {
            // TOOD: move this to WebApiResponseData class/protocol.
            NSDictionary *firstItem;
            if([[[webApiResponse data] items] count] > 0){
                firstItem = [[[webApiResponse data] items] objectAtIndex:0];
            }
            if(![webApiResponse error]){
                DVAdKitApp *app = [DVAdKitApp instanceFromDictionary:firstItem];
                
                completionHandler(app, nil);
            }else{
                completionHandler(nil, [webApiResponse error]);
            }
        }
        @catch (NSException *exception) {
            DVAdKitLog(@"Exception")
        }
        @finally {
        }
    }];
}




#pragma mark ===== IMPRESSIONS =====
-(void)addAppToParams:(NSMutableDictionary *)params{
    if([[DVAdKitWebAPI sharedInstance] app].identifier){
        [params setValue:[[DVAdKitWebAPI sharedInstance] app].identifier forKey:@"app_id"];
    }else{
        if(!self.appKey){
            self.appKey = [[DVAdKitWebAPI sharedInstance] createAppKey];
        }
        [params setValue:@{ @"app_key": self.appKey } forKey:@"app"];
    }
}

-(void)addDeviceToParams:(NSMutableDictionary *)params{
    if([[DVAdKitWebAPI sharedInstance] device].identifier){
        [params setValue:[[DVAdKitWebAPI sharedInstance] device].identifier forKey:@"device_id"];
    }else{
        NSString *openUdid = [self openUDID];
        NSString *identifierForVendor = [self identifierForVendor];
        NSString *advertisingIdentifier = [self advertisingIdentifier];
        NSMutableDictionary *deviceOptions = [[NSMutableDictionary alloc] init];
        if (openUdid) {
            [params setValue:openUdid forKey:kNFAdsDeviceIdentifierTypeOpenUDID];
            [deviceOptions setValue:openUdid forKey:kNFAdsDeviceIdentifierTypeOpenUDID];
        }
        
        if (identifierForVendor) {
            [params setValue:identifierForVendor forKey:kNFAdsDeviceIdentifierTypeIdentifierForVendor];
            [deviceOptions setValue:identifierForVendor forKey:kNFAdsDeviceIdentifierTypeIdentifierForVendor];
        }
        if (advertisingIdentifier) {
            [params setValue:advertisingIdentifier forKey:kNFAdsDeviceIdentifierTypeAdvertisingIdentifier];
            [deviceOptions setValue:advertisingIdentifier forKey:kNFAdsDeviceIdentifierTypeAdvertisingIdentifier];
        }
        [params setValue:[UIDevice currentDevice].model forKey:@"model"];
        NSString *osVersion = [@"" stringByAppendingFormat:@"%@", [[UIDevice currentDevice] systemVersion]];
        [params setValue:osVersion forKey:@"os_version"];
        [deviceOptions setValue:osVersion forKey:@"os_version"];
        [deviceOptions setValue:[UIDevice currentDevice].model forKey:@"model"];
        
        NSString *countryCode = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
        if(countryCode){
            [params setValue:countryCode forKey:@"country_code"];
            [deviceOptions setValue:countryCode forKey:@"country_code"];
        }
        NSString *screenScale = [@"" stringByAppendingFormat:@"%.2f", [[UIScreen mainScreen] scale]];
        [params setValue:screenScale forKey:@"screen_scale"];
        [deviceOptions setValue:screenScale forKey:@"screen_scale"];
        [params setValue:deviceOptions forKey:@"device"];
        
//        [params setValue:@{
//                           [[DVAdKitWebAPI sharedInstance] availableDeviceIdentifierType]:[[DVAdKitWebAPI sharedInstance] deviceIdentifier],
//                           @"model":[UIDevice currentDevice].model,
//                           @"os_version":osVersion,
//                           @"country_code":countryCode,
//                           @"screen_scale":screenScale
//                           }
//                  forKey:@"device"];
    }
}

-(void)createImpressionWithOptions:(NSDictionary *)options completionHandler:(void (^ )(DVAdKitImpression *impression, NSError *error))completionHandler{
    
    // IMPORTANT! Testing ability to show impression before app id is set.
//    if(!_app || !_app.identifier){
//        completionHandler(nil, nil);
//        DVAdKitLog(@"Warning: _app.identifier is not set.");
//        return;
//    }
//    
//    if(!_app.isKidsApp){
//        if(!_device.identifier){
//            completionHandler(nil, nil);
//            DVAdKitLog(@"Warning: _device.identifier is not set. App still needs to call install api to get its ID values for app and device");
//            return;
//        }
//    }
    
    
    NSString *zone = @"";
    if([options objectForKey:kDVAdKitParameterOptionLocationInAppLabel]){
        zone = [options objectForKey:kDVAdKitParameterOptionLocationInAppLabel];
    }
    
    // todo, make block ad requests based on ad type.
    BOOL overrideLocalBlocking = NO;
    if ([options objectForKey:kDVAdKitParameterOptionOverrideLocalBlocking]) {
        NSNumber *overrideLocalBlockingNumber = [options objectForKey:kDVAdKitParameterOptionOverrideLocalBlocking];
        overrideLocalBlocking = [overrideLocalBlockingNumber boolValue];
    }
    
    
    
    // CODE TO BLOCK IMPRESSIONS..
    // TODO: Move this somewhere else
#ifdef ANDROID
    overrideLocalBlocking = YES;
#endif
    
    if(!overrideLocalBlocking){
        
        if([[DVAdKitManagedObjects sharedInstance] blockAdRequestsUntil]){
            DVAdKitLog(@"inspecting block ad requests until");
            if(![DVDate isDatePast:[[DVAdKitManagedObjects sharedInstance] blockAdRequestsUntil]]){
                DVAdKitLog(@"ad requests are blocked until: %f seconds from now.", ([[[DVAdKitManagedObjects sharedInstance] blockAdRequestsUntil] timeIntervalSince1970] - [[NSDate date] timeIntervalSince1970]));
                completionHandler(nil, nil);
                return;
            }
        }
        
        
        DVAdKitImpression *lastImpression = [[DVAdKitManagedObjects sharedInstance] lastImpression];
        
        if(lastImpression){
            if(lastImpression.maxPerDayReached){
                NSDate *date = [DVDate dateFromString:lastImpression.createdAt];
                int timeInterval = [[NSDate date] timeIntervalSince1970] - [date timeIntervalSince1970];
                if(timeInterval < kDVDateTimeIntervalOneDay){
                    DVAdKitLog(@"Max per day reached.");
                    completionHandler(nil, nil);
                    return;
                }
            }else if(lastImpression.maxPerHourReached){
                NSDate *date = [DVDate dateFromString:lastImpression.createdAt];
                int timeInterval = [[NSDate date] timeIntervalSince1970] - [date timeIntervalSince1970];
                if(timeInterval < kDVDateTimeIntervalOneHour){
                    DVAdKitLog(@"Max per hour reached.");
                    completionHandler(nil, nil);
                    return;
                }
            }else{
                NSDate *date = [DVDate dateFromString:lastImpression.createdAt];
                int timeInterval = [[NSDate date] timeIntervalSince1970] - [date timeIntervalSince1970];
                NSLog(@"time interval: %d", timeInterval);
                
                if(timeInterval < 5){
                    DVAdKitLog(@"Impression shown less than 5 seconds ago.");
                    completionHandler(nil, nil);
                    return;
                }
            }
        }
        
        NSError *maxImpressionsReachedError = nil;
        if([self maxImpressionsReachedForZone:zone error:&maxImpressionsReachedError]){
            if(maxImpressionsReachedError && maxImpressionsReachedError.userInfo && [maxImpressionsReachedError.userInfo objectForKey:@"reason"]){
                if([[maxImpressionsReachedError.userInfo objectForKey:@"reason"] isEqualToString:kDVAdKitErrorNameMaxPerDayReached]){
                    [self blockAdRequestsUntilSecondsFromNow:kDVDateTimeIntervalOneDay];
                }else if([[maxImpressionsReachedError.userInfo objectForKey:@"reason"] isEqualToString:kDVAdKitErrorNameMaxPerHourReached]){
                    [self blockAdRequestsUntilSecondsFromNow:kDVDateTimeIntervalOneHour];
                }
            }
        }
        
    }
    

    


    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:options];
    if(_app.isKidsApp){
        [params addEntriesFromDictionary:@{@"app_id":_app.identifier, @"app":@{@"id":_app.identifier}}];
        if([options objectForKey:@"should_filter"]){
            NSMutableArray *apps_to_block = [[NSMutableArray alloc] init];
            for(DVAdKitApp *app in [[DVAdKitManagedObjects sharedInstance] appsInstalled]){
                NSDictionary *d = @{@"id":app.identifier};
                if([apps_to_block indexOfObject:d] == NSNotFound){
                    [apps_to_block addObject:d];
                }
            }
            
            for(DVAdKitImpression *impression in [[DVAdKitManagedObjects sharedInstance] impressionsShown]){
                NSDictionary *d = @{@"id":impression.ad.app.identifier};
                if([apps_to_block indexOfObject:d] == NSNotFound){
                    [apps_to_block addObject:d];
                }
            }
            
            [params setValue:apps_to_block forKey:@"apps_to_block"];
        }
        
    }else{
        
        if(_app.identifier){
            [params setValue:_app.identifier forKey:@"app_id"];
        }else{
            if(!self.appKey){
                self.appKey = [self createAppKey];
            }
            [params setValue:@{ @"app_key": self.appKey } forKey:@"app"];
        }
        
        
        if(_device.identifier){
            [params setValue:_device.identifier forKey:@"device_id"];
        }else{
            NSString *screenScale = [@"" stringByAppendingFormat:@"%.2f", [[UIScreen mainScreen] scale]];
            NSString *countryCode = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
            NSString *osVersion = [@"" stringByAppendingFormat:@"%@", [[UIDevice currentDevice] systemVersion]];
            
            [params setValue:@{
                               [self availableDeviceIdentifierType]:[self deviceIdentifier],
                               @"model":[UIDevice currentDevice].model,
                               @"os_version":osVersion,
                               @"country_code":countryCode,
                               @"screen_scale":screenScale
                               }
                      forKey:@"device"];
        }
        
    }
    
    // ADDITIONAL LOGIC BEING ADDED FOR NON-INTERSTIAL AD TYPES
    NSString *urlString = @"/impressions/";
    if ([params objectForKey:@"ad_type"]) {
        NSString *adTypeName = @"custom";
        NSDictionary *adType = [params objectForKey:@"ad_type"];
        if([adType isKindOfClass:[NSDictionary class]]){
            if ([adType valueForKey:@"name"]) {
                adTypeName = [adType valueForKey:@"name"];
            }
        }
        urlString = [@"" stringByAppendingFormat:@"/impressions/%@/", adTypeName];
    }
    BOOL shouldBlockIfAdsNotFound = YES;
    if ([params objectForKey:kDVAdKitParameterOptionShouldBlockIfAdsNotFound]) {
        NSNumber *shouldBlockNumber = [params objectForKey:kDVAdKitParameterOptionShouldBlockIfAdsNotFound];
        shouldBlockIfAdsNotFound = [shouldBlockNumber boolValue];
        [params removeObjectForKey:kDVAdKitParameterOptionShouldBlockIfAdsNotFound];
    }
    
    // NFNetworking
    [self webApiCall:urlString params:params httpMethod:@"POST" options:nil NFWebApiResponseHandler:^(id<DVWebApiResponse> webApiResponse){
        
        @try {
            
            if([webApiResponse error]){
                if (!overrideLocalBlocking) {
                    int blockAdRequestsUntilSecondsFromNow = kDVDateTimeIntervalOneMinute * 2;
                    if([webApiResponse error].code == 0){
                        blockAdRequestsUntilSecondsFromNow = kDVDateTimeIntervalOneMinute * 2;
                    }
                    
                    NSDictionary *errorDictionary = [webApiResponse errorDictionary];
                    if(errorDictionary && [errorDictionary isKindOfClass:[NSDictionary class]] && [errorDictionary objectForKey:@"errors"]){
                        NSArray *errors = [errorDictionary objectForKey:@"errors"];
                        
                        for(NSDictionary *errorDictionary in errors){
                            if([errorDictionary isKindOfClass:[NSDictionary class]]){
                                NSString *reason = [errorDictionary objectForKey:@"reason"];
                                if(reason && [reason isKindOfClass:[NSString class]]){
                                    
                                    // TODO: Update this to use stored NSDate objects rather than
                                    // creating last impression objects.
                                    if([reason isEqualToString:kDVAdKitErrorNameMaxPerDayReached]){
                                        blockAdRequestsUntilSecondsFromNow = kDVDateTimeIntervalOneDay;
                                        
                                    }else if([reason isEqualToString:kDVAdKitErrorNameMaxPerHourReached]){
                                        blockAdRequestsUntilSecondsFromNow = kDVDateTimeIntervalOneHour;
                                        
                                    }else if([reason isEqualToString:@"RecordNotFound"]){
                                        DVAdKitLog(@"setting block for RecordNotFound");
                                        if(shouldBlockIfAdsNotFound){
                                            blockAdRequestsUntilSecondsFromNow = kDVDateTimeIntervalOneMinute * 2;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    DVAdKitLog(@"Block Ad request until: %d", blockAdRequestsUntilSecondsFromNow);
                    if(blockAdRequestsUntilSecondsFromNow > 0){
                        DVAdKitLog(@"setting block ad requests until");
                        [self blockAdRequestsUntilSecondsFromNow:blockAdRequestsUntilSecondsFromNow];
                    }
                }
                completionHandler(nil, [webApiResponse error]);
                return;
            }
            
            
            NSDictionary *firstItem;
            if([[[webApiResponse data] items] count] > 0){
                firstItem = [[[webApiResponse data] items] objectAtIndex:0];
            }
            
            DVAdKitImpression *impression;
            
            if(firstItem){
                impression = [DVAdKitImpression instanceFromDictionary:firstItem];
            }
            completionHandler(impression, nil);
            
        }
        @catch (NSException *exception) {
            
        }
    }];
}

-(BOOL)maxImpressionsReachedForZone:(NSString *)zone error:(NSError **)error{
    BOOL maxReached = NO;
    NSString *errorMessage;
    int errorCode = 0;
    NSString *reason = @"";
    
    DVAdKitAdLogic *selectedAdLogic;
    for(DVAdKitAdLogic *adLogic in _app.adLogics){
        if(adLogic.zone && [adLogic.zone isEqualToString:zone]){
            selectedAdLogic = adLogic;
            break;
        }
    }
    if(selectedAdLogic){
        int impressionsShownToday = 0;
        int impressionsShownThisHour = 0;
        
        for(DVAdKitImpression *impression in [[DVAdKitManagedObjects sharedInstance] impressionsShown]){
            NSDate *createdAt = [DVDate dateFromString:impression.createdAt];
            if(([[NSDate date] timeIntervalSince1970] - [createdAt timeIntervalSince1970]) < kDVDateTimeIntervalOneDay){
                impressionsShownToday++;
                if(([[NSDate date] timeIntervalSince1970] - [createdAt timeIntervalSince1970]) < kDVDateTimeIntervalOneHour){
                    impressionsShownThisHour++;
                }
            }
        }
        
        if (impressionsShownToday > [selectedAdLogic.maxPerDay intValue]) {
            maxReached = YES;
            errorMessage = @"Exceeded max impressions per day";
            reason = kDVAdKitErrorNameMaxPerDayReached;
            errorCode = 503;
        }else if (impressionsShownThisHour > [selectedAdLogic.maxPerHour intValue]) {
            maxReached = YES;
            errorMessage = @"Exceeded max impressions per hour";
            errorCode = 503;
            reason = kDVAdKitErrorNameMaxPerHourReached;
        }
    }
    
    if(maxReached){
        if(!errorMessage){
            errorMessage = @"";
        }
        *error = [NSError errorWithDomain:@"" code:errorCode userInfo:@{NSLocalizedDescriptionKey:errorMessage, @"reason":reason}];
    }
    return NO;
}

-(void)blockAdRequestsUntilSecondsFromNow:(int)secondsFromNow{
    NSDate *blockAdRequestsUntil = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970] + secondsFromNow];
    [[DVAdKitManagedObjects sharedInstance] setBlockAdRequestsUntil:blockAdRequestsUntil];
    [[DVAdKitManagedObjects sharedInstance] saveBlockAdRequestsUntil];
}

-(BOOL)validateImpression:(DVAdKitImpression *)impression options:(NSDictionary *)options error:(NSError **)error{
    NSString *errorMessage;
    BOOL isImpressionValid = YES;
    int errorCode = 500;
    
    
    DVAdKitLog(@"Impressions shown");
    // Has app that impression is advertising been recently shown.
    for(int i=[[[DVAdKitManagedObjects sharedInstance] impressionsShown] count]-1; i >= 0; i--){
        
        DVAdKitImpression *shownImpression = [[[DVAdKitManagedObjects sharedInstance] impressionsShown] objectAtIndex:i];
        
        DVAdKitLog(@"%@", [shownImpression dictionaryRepresentation]);
        DVAdKitLog(@"%@", [shownImpression.ad dictionaryRepresentation]);
        DVAdKitLog(@"%@", [shownImpression.ad.app dictionaryRepresentation]);
        
        if(![shownImpression.ad.app isKindOfClass:[DVAdKitApp class]] || ![impression.ad.app isKindOfClass:[DVAdKitApp class]]){
            break;
        }
        
        
        if([shownImpression.ad.identifier intValue] == [impression.ad.identifier intValue]){
            NSDate *createdAt = [DVDate dateFromString:shownImpression.createdAt];
            if(([[NSDate date] timeIntervalSince1970] - [createdAt timeIntervalSince1970]) < kDVDateTimeIntervalOneDay){
                if(([[NSDate date] timeIntervalSince1970] - [createdAt timeIntervalSince1970]) < kDVDateTimeIntervalOneHour){
                    errorMessage = @"Ad already shown this hour";
                    isImpressionValid = NO;
                    break;
                }
            }
        }
    }
    
    
    // Has the impression per day, or per hour limit been reached.
    if(isImpressionValid){
        NSString *zone = @"";
        if([options objectForKey:kDVAdKitParameterOptionLocationInAppLabel]){
            zone = [options objectForKey:kDVAdKitParameterOptionLocationInAppLabel];
        }
        
        NSError *tmpError;
        if([self maxImpressionsReachedForZone:zone error:&tmpError]){
            if(tmpError){
                errorMessage = [tmpError localizedDescription];
            }
            isImpressionValid = NO;
        }
    }
    
    // Is app that impression is advertising this app.
    if (isImpressionValid) {
        if([_app.identifier intValue] == [impression.ad.app.identifier intValue]){
            isImpressionValid = NO;
            errorMessage = @"Ad is for this app";
        }
    }
    
    // Is app that impression is advertising already installed.
    if(isImpressionValid){
        NSString *errorMessageForAppIsAleadyInstalledError = @"App ad is promoting is already installed";
        
        for(DVAdKitApp *app in [[DVAdKitManagedObjects sharedInstance] appsInstalled]){
            
            if ([app.identifier intValue] == [impression.ad.app.identifier intValue]) {
                isImpressionValid = NO;
                errorMessage = errorMessageForAppIsAleadyInstalledError;
                break;
            }
        }
        
#ifndef ANDROID
        if(impression.ad.app.urlScheme){
            BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:impression.ad.app.urlScheme]];
            
            if(canOpen){
                DVAdKitApp *app = impression.ad.app;
                
                [[[DVAdKitManagedObjects sharedInstance] appsInstalled] addObject:app];
                [[DVAdKitManagedObjects sharedInstance] saveAppsInstalled];
                
                isImpressionValid = NO;
                errorMessage = errorMessageForAppIsAleadyInstalledError;
            }
            
        }
#endif
        
    }
    
    if(!isImpressionValid){
        if(!errorMessage){
            errorMessage = @"";
        }
        *error = [NSError errorWithDomain:@"" code:errorCode userInfo:@{NSLocalizedDescriptionKey:errorMessage}];
        return NO;
    }
    
    return YES;
}


// Show an interstitial, optionally takes a location and/or a view argument
- (void)showInterstitial{
    [self showInterstitial:@""];
}

-(void)showInterstitial:(NSString *)label{
    _methodNamedShowInterstitialLastCalledAt = [NSDate date];
    
    @try {
        [self showInterstitialWithOptions:@{kDVAdKitParameterOptionLocationInAppLabel:label, kDVAdKitParameterOptionShouldFilter:[NSNumber numberWithBool:NO]} completionHandler:^(DVAdKitImpression *impression, NSError *error){
        }];
    }
    @catch (NSException *exception) {
        DVAdKitLog(@"Exception");
    }
    @finally {
    }
    
}

-(void)showInterstitial:(NSString *)label completionHandler:(void (^ )(BOOL impressionWasFilled))completionHandler{
    _methodNamedShowInterstitialLastCalledAt = [NSDate date];
    
    @try {
        [self showInterstitialWithOptions:@{kDVAdKitParameterOptionLocationInAppLabel:label, kDVAdKitParameterOptionShouldFilter:[NSNumber numberWithBool:NO]} completionHandler:^(DVAdKitImpression *impression, NSError *error){
            @try {
                if(completionHandler){
                    completionHandler(impression ? YES : NO);
                }
            }
            @catch (NSException *exception) {
                DVAdKitLog(@"Exception");
            }
            
            
        }];
    }
    @catch (NSException *exception) {
        DVAdKitLog(@"Exception");
    }
    @finally {
    }
    
}

- (void)showInterstitialWithOptions:(NSDictionary *)options completionHandler:(void (^ )(DVAdKitImpression *impression, NSError *error))completionHandler{
    
    @try {
        static int numberOfFilteredRequests = 0;
        if([options objectForKey:@"should_filter"] && [[options objectForKey:@"should_filter"] boolValue] == YES){
            numberOfFilteredRequests++;
        }else{
            numberOfFilteredRequests = 0;
        }
        
        [self createImpressionWithOptions:options completionHandler:^(DVAdKitImpression *impression, NSError *error){
            @try {
                if(!impression){
                    if(completionHandler){
                        completionHandler(nil, error);
                    }
                    return;
                }
                
                if(_app.isKidsApp || ([options objectForKey:kDVAdKitParameterOptionShouldFilter] && [[options objectForKey:kDVAdKitParameterOptionShouldFilter] boolValue] == NO)){
                    
                    NSError *impressionValidationError = nil;
                    BOOL impressionIsValid = [self validateImpression:impression options:options error:&impressionValidationError];
                    
                    DVAdKitLog(@"Checking impression is valid: %d", impressionIsValid);;
                    
                    if(!impressionIsValid){
                        [self error:[impressionValidationError localizedDescription] showingImpression:impression];
                        
                        NSMutableDictionary *newOptions = [[NSMutableDictionary alloc] initWithDictionary:options];
                        [newOptions setValue:[NSNumber numberWithBool:YES] forKey:kDVAdKitParameterOptionShouldFilter];
                        
                        DVAdKitLog(@"numberOfFilteredRequests: %d", numberOfFilteredRequests);
                        
                        if(numberOfFilteredRequests < 4){
                            [self showInterstitialWithOptions:newOptions completionHandler:completionHandler];
                        }else{
                            if(completionHandler){
                                completionHandler(nil, impressionValidationError);
                            }
                        }
                        
                        return;
                    }
                }
                
                if (impression){
                    [[DVAdKitManagedObjects sharedInstance] setLastImpression:impression];
                    [[DVAdKitManagedObjects sharedInstance] addImpressionToImpressionsShown:impression];
                    [[DVAdKitManagedObjects sharedInstance] saveLastImpression];
                    [[DVAdKitManagedObjects sharedInstance] saveImpressionsShown];
                }
                if (!_device) {
                    _device = impression.device;
                }
                if (!_app) {
                    _app = impression.app;
                }
                
                
                // Make sure impression.clicked is false (API may default to true).
                impression.clicked = NO;
                
                DVAdKitCreative *selectedCreative;
                for(DVAdKitCreative *creative in impression.ad.creatives){
                    
                    BOOL sameOrientation = [[creative.orientation lowercaseString] isEqualToString:[_app.orientation lowercaseString]];
                    if (!_device.model) {
                        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                            _device.model = @"iPad";
                        }else{
                            _device.model = @"iPhone";
                        }
                    }
                    
                    BOOL sameDeviceGroup = [self deviceModel:creative.model isInTheSameDeviceModelGroupAsDeviceModel:_device.model];
                    
                    NSLog(@"%@ is same device group as: %@, %d", creative.model, _device.model, sameDeviceGroup);
                    
                    if(sameOrientation && sameDeviceGroup){
                        selectedCreative = creative;
                        break;
                    }
                }
                
                if(!selectedCreative){
                    NSString *errorMessage = @"Could not find creative for device model/orientation";
                    NSString *reason = @"NotFound";
                    [self error:errorMessage showingImpression:impression];
                    if(completionHandler){
                        completionHandler(nil, [NSError errorWithDomain:@"" code:404 userInfo:@{NSLocalizedDescriptionKey:errorMessage, @"reason":reason}]);
                    }
                    return ;
                }
                
                __block DVAdViewController *adViewController = [[DVAdViewController alloc] init];
                
                adViewController = [[DVAdViewController alloc] init];
                adViewController.impression = impression;
                
                
                adViewController.delegate = (id<DVAdViewControllerDelegate>)[DVAdKit sharedInstance];
                adViewController.creative = selectedCreative;
                
                
                DVAdKitLog(@"Selected creative: %@", [selectedCreative dictionaryRepresentation]);
                
                [DVImageDownloader downloadImage:selectedCreative.adImageLink completionHandler:^(UIImage *image){
                    
                    adViewController.adImage = image;
                    [DVImageDownloader downloadImage:selectedCreative.frameImageLink completionHandler:^(UIImage *image){
                        
                        @try {
                            adViewController.frameImage = image;
                            if([self validateCreative:selectedCreative adImage:adViewController.adImage frameImage:adViewController.frameImage error:nil]){
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                    @try {
                                        
                                        int minSecondsBetweenImpressions = 5;
                                        static BOOL throttleLock;
                                        if(throttleLock){
                                            DVAdKitLog(@"Throttling");
                                            NSString *errorMessage = [@"" stringByAppendingFormat:@"Another impression was just shown less than %d seconds ago", minSecondsBetweenImpressions];
                                            [self error:errorMessage showingImpression:impression];
                                            
                                            if(completionHandler){
                                                completionHandler(nil, [NSError errorWithDomain:@"" code:429 userInfo:@{NSLocalizedDescriptionKey:errorMessage, @"reason":@"LocallyThrottling"}]);
                                            }
                                            
                                        }else{
                                            throttleLock = YES;
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, minSecondsBetweenImpressions * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
                                                throttleLock = NO;
                                            });
                                            
                                            if(_adViewController && _adViewController.view && _adViewController.view.superview){
                                                [_adViewController.view removeFromSuperview];
                                            }
                                            _adViewController = adViewController;
                                            
                                            [_adViewController show];
                                            
                                            if(completionHandler){
                                                completionHandler(impression,nil);
                                            }
                                        }
                                        
                                    }
                                    @catch (NSException *exception) {
                                        DVAdKitLog(@"Exception");
                                    }
                                    @finally {
                                    }
                                });
                            }else{
                                [self error:@"Invalid frame and/or ad images" showingImpression:impression];
                            }
                        }
                        @catch (NSException *exception){
                            DVAdKitLog(@"Exception");
                        }
                        @finally {
                        }
                        
                        
                        
                    }];
                }];
                
            }
            @catch (NSException *exception) {
                DVAdKitLog(@"Warning: error: %@", [exception description]);
            }
            @finally {
            }
            
        }];
        
    }
    @catch (NSException *exception) {
        DVAdKitLog(@"NSException: %@", [exception description]);
    }
    @finally {
    }
}



-(void)error:(NSString *)error showingImpression:(DVAdKitImpression *)impression{
    [self deleteImpression:impression error:error];
}

-(void)deleteImpression:(DVAdKitImpression *)impression error:(NSString *)error{
    if(!_device.identifier ||!impression.identifier){
        return;
    }
    NSMutableDictionary *params;
    
    NSString *impressionUniqueToken = @"";
    if(impression.uniqueToken){
        impressionUniqueToken = impression.uniqueToken;
    }
    if(_app.isKidsApp){
        params = [[NSMutableDictionary alloc] initWithDictionary: @{@"impression_id":impression.identifier, @"impression":@{@"id":impression.identifier, @"unique_token":impressionUniqueToken}}];
    }else{
        params = [[NSMutableDictionary alloc] initWithDictionary: @{@"device_id":_device.identifier, @"impression_id":impression.identifier, @"impression":@{@"id":impression.identifier, @"unique_token":impressionUniqueToken}}];
    }
    
    if(error){
        [params setValue:error forKey:@"error"];
    }
    
    
    NSString *url = [@"" stringByAppendingFormat:@"/impressions/%@", impression.identifier];
    
    // NFNetworking
    [self webApiCall:url params:params httpMethod:@"DELETE" options:nil NFWebApiResponseHandler:^(id<DVWebApiResponse> webApiResponse){
        DVAdKitLog(@"Impression deleted.");
        
    }];
}


#pragma mark Creatives
-(BOOL)validateCreative:(DVAdKitCreative *)creative adImage:(UIImage *)adImage frameImage:(UIImage *)frameImage error:(NSError **)error{
    
    if(!adImage || !frameImage){
        return NO;
    }
    
    if (adImage.size.width <= 0 || frameImage.size.height <= 0) {
        return NO;
    }
    
    CGSize maxCreativeSize;
    if(creative.orientation && [creative.orientation isEqualToString:@"Landscape"]){
        maxCreativeSize = CGSizeMake([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    }else{
        maxCreativeSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }
    
    if(adImage.size.width > maxCreativeSize.width || adImage.size.height > maxCreativeSize.height || frameImage.size.width > maxCreativeSize.width || frameImage.size.height > maxCreativeSize.height){
        return NO;
    }
    
    return YES;
}

#pragma mark ===== CLICKS =====
-(void)deleteClick:(DVAdKitImpression *)impression{
    if(!_device.identifier ||!impression.identifier){
        return;
    }
    
    NSString *impressionUniqueToken = @"";
    if(impression.uniqueToken){
        impressionUniqueToken = impression.uniqueToken;
    }
    NSMutableDictionary *params;
    if(_app.isKidsApp){
        params = [[NSMutableDictionary alloc] initWithDictionary: @{@"impression_id":impression.identifier, @"impression":@{@"id":impression.identifier, @"unique_token":impressionUniqueToken}}];
    }else{
        params = [[NSMutableDictionary alloc] initWithDictionary: @{@"device_id":_device.identifier, @"impression_id":impression.identifier, @"impression":@{@"id":impression.identifier, @"unique_token":impressionUniqueToken}}];
    }
    
    // NFNetworking
    [self webApiCall:@"/clicks/" params:params httpMethod:@"DELETE" options:nil NFWebApiResponseHandler:^(id<DVWebApiResponse> webApiResponse){
        
    }];
    
    
}

-(void)createClick:(DVAdKitImpression *)impression{
    if(!_device.identifier ||!impression.identifier){
        return;
    }
    
    NSString *impressionUniqueToken = @"";
    if(impression.uniqueToken){
        impressionUniqueToken = impression.uniqueToken;
    }
    NSMutableDictionary *params;
    if(_app.isKidsApp){
        params = [[NSMutableDictionary alloc] initWithDictionary: @{@"impression_id":impression.identifier, @"impression":@{@"id":impression.identifier, @"unique_token":impressionUniqueToken}}];
    }else{
        params = [[NSMutableDictionary alloc] initWithDictionary: @{@"device_id":_device.identifier, @"impression_id":impression.identifier, @"impression":@{@"id":impression.identifier, @"unique_token":impressionUniqueToken}}];
    }
    
    // NFNetworking
    [self webApiCall:@"/clicks/" params:params httpMethod:@"POST" options:nil NFWebApiResponseHandler:^(id<DVWebApiResponse> webApiResponse){
        
    }];
    
}


#pragma mark ====== DEVICES =====
-(BOOL)deviceModel:(NSString *)device1 isInTheSameDeviceModelGroupAsDeviceModel:(NSString *)device2{
    NSArray *deviceModelGroups = @[@[@"iphone", @"ipod"],
                                   @[@"ipad"]
                                   ];
    BOOL device1Found, device2Found = NO;
    
    for(NSArray *deviceModelGroup in deviceModelGroups){
        device1Found = NO;
        device2Found = NO;
        for(NSString *model in deviceModelGroup){
            if([device1.lowercaseString rangeOfString:model].location != NSNotFound){
                device1Found = YES;
            }
            if([device2.lowercaseString rangeOfString:model].location != NSNotFound){
                device2Found = YES;
            }
        }
        if(device1Found && device2Found){
            return YES;
        }
    }
    
    return NO;
}
#pragma mark Device Identifier - move to own class
- (BOOL)isAdvertisingTrackingEnabled
{
    Class identifireManagerClass = NSClassFromString(@"ASIdentifierManager");

    BOOL isAdvertisingTrackingEnabled = NO;
    if (identifireManagerClass) {
        isAdvertisingTrackingEnabled = [[identifireManagerClass sharedManager] isAdvertisingTrackingEnabled];
    }
    
#ifdef ANDROID
    return NO;
#else
    
    return isAdvertisingTrackingEnabled;
#endif
}

-(NSString *)availableDeviceIdentifierType{
    if([self isAdvertisingTrackingEnabled]){
        if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
            return kNFAdsDeviceIdentifierTypeIdentifierForVendor;
        }
        return kNFAdsDeviceIdentifierTypeAdvertisingIdentifier;
    }else if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        return kNFAdsDeviceIdentifierTypeIdentifierForVendor;
    }
    return kNFAdsDeviceIdentifierTypeOpenUDID;
}

-(NSString *)deviceIdentifier{
    NSString *availableDeviceIdentifierType = [self availableDeviceIdentifierType];
#ifdef ANDROID
    return [OpenUDID value];
#else
    if([availableDeviceIdentifierType isEqualToString:kNFAdsDeviceIdentifierTypeAdvertisingIdentifier]){
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }else if([availableDeviceIdentifierType isEqualToString:kNFAdsDeviceIdentifierTypeIdentifierForVendor]){
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return [OpenUDID value];
#endif
}

-(NSString *)openUDID{
    return [OpenUDID value];
}

-(NSString *)identifierForVendor{
    if ([self isAdvertisingTrackingEnabled]) {
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return nil;
}

-(NSString *)advertisingIdentifier{
    if ([self isAdvertisingTrackingEnabled]) {
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    return nil;
}



// TODO: Remove this code as it isn't used.
#pragma mark Queued Invocation
-(void)queueInvocationForSelector:(SEL)selector forClass:(Class)class target:(id)target args:(NSArray *)args{
    if(!_queuedInvocations){
        _queuedInvocations = [[NSMutableArray alloc] init];
    }
    
    // Only allow one invocation per target/selector combo.
    for(NSInvocation *invocation in _queuedInvocations){
        if(invocation.target == target && invocation.selector == selector){
            return;
        }
    }
    
    NSMethodSignature *signature;
    NSInvocation *invocation;
    
    signature = [class instanceMethodSignatureForSelector:selector];
    invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
    [invocation setTarget:target];
    
    for(int i=0; i < [args count]; i++){
        NSObject *obj = [args objectAtIndex:i];
        [invocation setArgument:&obj atIndex:i + 2];
    }
    [_queuedInvocations addObject:invocation];
    
}






#pragma mark ======= PURCHASES =========
-(void)createPurchase:(DVAdKitPurchase *)purchase completionHandler:(void (^ )(DVAdKitPurchase *purchase, NSError *error))completionHandler{
    if(!self.appKey){
        DVAdKitLog(@"Warning: self.appKey is not set.");
        return;
    }
    
    
    NSMutableDictionary *params;
    NSString *deviceId = @"";
    NSString *localizedTitle = @"";
    NSString *price = @"";
    NSString *priceLocale = @"";
    NSString *productIdentifier = @"";

    if(self.device && self.device.identifier){
        deviceId = [@"" stringByAppendingFormat:@"%@", self.device.identifier];
    }
    if(purchase.localizedTitle){
        localizedTitle = purchase.localizedTitle;
    }
    if(purchase.price){
        price = [@"" stringByAppendingFormat:@"%@", purchase.price];
    }
    if(purchase.priceLocale){
        priceLocale = purchase.priceLocale;
    }
    if(purchase.productIdentifier){
        productIdentifier = purchase.productIdentifier;
    }

    // TODO: deprecate app[unique_token]
    params = [[NSMutableDictionary alloc] initWithDictionary:@{@"app_key":self.appKey,
                                                               @"purchase":@{@"device_id":deviceId,
                                                                             @"localized_title":localizedTitle,
                                                                             @"price":price,
                                                                             @"price_locale":priceLocale,
                                                                             @"product_identifier":productIdentifier
                                                                             }
                                                               }];
    



    
    
    
    // NFNetworking
    [self webApiCall:@"/purchases/" params:params httpMethod:@"POST" options:nil NFWebApiResponseHandler:^(id<DVWebApiResponse> webApiResponse){
        
        @try {
            // TOOD: move this to WebApiResponseData class/protocol.
            NSDictionary *firstItem;
            if([[[webApiResponse data] items] count] > 0){
                firstItem = [[[webApiResponse data] items] objectAtIndex:0];
            }
            if(![webApiResponse error]){
                DVAdKitPurchase *purchase = [DVAdKitPurchase instanceFromDictionary:firstItem];
                completionHandler(purchase, nil);
            }else{
                
                completionHandler(nil, [webApiResponse error]);
            }
        }
        @catch (NSException *exception) {
            DVAdKitLog(@"Exception");
        }
        @finally {
        }
        
    }];
    
}





@end
