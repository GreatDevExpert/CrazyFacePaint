//
//  NFAnalytics.h
//
//  Created by William Locke on 3/5/13.
//
//

#import <Foundation/Foundation.h>
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

extern NSString * const kNFAdsDeviceIdentifierTypeOpenUDID;
extern NSString * const kNFAdsDeviceIdentifierTypeAdvertisingIdentifier;
extern NSString * const kNFAdsDeviceIdentifierTypeIdentifierForVendor;
extern NSString * const kNFAdsSecureKey;

extern NSString * const kDVAdKitParameterOptionShouldFilter;
extern NSString * const kDVAdKitParameterOptionLocationInAppLabel;
extern NSString * const kDVAdKitParameterOptionShouldBlockIfAdsNotFound;
extern NSString * const kDVAdKitParameterOptionOverrideLocalBlocking;

extern NSString * const kDVAdKitErrorNameMaxPerHourReached;
extern NSString * const kDVAdKitErrorNameMaxPerDayReached;
extern NSString * const kDVAdKitErrorNameRecordNotFound;

extern NSString * const kDVAdKitPasteboardName;

@class DVAdKitWebAPI;

// TODO: remove from .h
@class DVAdViewController;




@interface DVAdKitWebAPI : NSObject


@property (nonatomic, copy) NSString *appKey;
//@property (nonatomic, unsafe_unretained) id <DVAdKitDelegate> delegate;
@property (nonatomic, strong) DVAdViewController *adViewController;
@property (nonatomic, strong) DVWebApiClient *webApi;
@property (nonatomic, strong)NSString *deviceIdentifier;
@property (nonatomic, strong)NSString *deviceIdentifierType;

@property (nonatomic, strong) DVAdKitDevice *device;
@property (nonatomic, strong) DVAdKitApp *app;
@property (nonatomic, strong) NSMutableArray *queuedInvocations;
@property (nonatomic, strong) NSDate *methodNamedShowInterstitialLastCalledAt;


+ (DVAdKitWebAPI *)sharedInstance;

- (void)showInterstitial;
- (void)showInterstitial:(NSString *)label;
-(void)showInterstitial:(NSString *)label completionHandler:(void (^ )(BOOL impressionWasFilled))completionHandler;

// This function replaces startSession
-(void)start;

-(void)startSession __attribute__((deprecated));
-(void)startSessionUsingApiKey:(NSString *)apiKey __attribute__((deprecated));


#pragma mark Web Api
-(void)webApiCall:(NSString *)url
           params:(NSMutableDictionary *)params
       httpMethod:(NSString *)httpMethod
          options:(NSMutableDictionary *)options NFWebApiResponseHandler:(NFWebApiResponseHandler)NFWebApiResponseHandler;


-(NSString *)createAppKey;


#pragma mark ===== IMPRESSIONS =====
-(void)addAppToParams:(NSMutableDictionary *)params;
-(void)addDeviceToParams:(NSMutableDictionary *)params;
-(void)createImpressionWithOptions:(NSDictionary *)options completionHandler:(void (^ )(DVAdKitImpression *impression, NSError *error))completionHandler;


#pragma mark PASTEBOARD
-(void)addClickEventToPasteboardForImpression:(DVAdKitImpression *)impression;


#pragma mark ===== CLICKS =====
-(void)deleteClick:(DVAdKitImpression *)impression;
-(void)createClick:(DVAdKitImpression *)impression;


#pragma mark ====== DEVICES =====
-(BOOL)deviceModel:(NSString *)device1 isInTheSameDeviceModelGroupAsDeviceModel:(NSString *)device2;
-(NSString *)availableDeviceIdentifierType;
-(NSString *)deviceIdentifier;


#pragma mark ======= PURCHASES =========
-(void)createPurchase:(DVAdKitPurchase *)purchase completionHandler:(void (^ )(DVAdKitPurchase *purchase, NSError *error))completionHandler;


#pragma mark ===== APP STORE =====
-(void)openUrlWithProductViewController:(NSURL *)url inRootViewController:(UIViewController *)rootViewController completionHandler:(void (^ )(BOOL success))completionHandler;

@end



