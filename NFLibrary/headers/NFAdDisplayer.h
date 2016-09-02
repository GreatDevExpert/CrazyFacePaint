//
//  NFAnalytics.h
//
//  Created by William Locke on 3/5/13.
//
//

#import <UIKit/UIKit.h>

typedef void (^ NFAdDisplayerVideoAdCompletionHandler)(BOOL success);


@protocol NFAdDisplayerDeviceProfile <NSObject>
-(NSNumber *)sessionCount;
-(NSNumber *)purchaseAmount;
-(NSNumber *)purchaseLifetimeAmount;
@end


@protocol NFAdDisplayer <NSObject>

@optional
-(void)showInterstitialForObject:(id)object inFunction:(SEL)function;
-(void)showBannerAd;
-(NSArray *)blockedBannerAdViewControllerClasses;
-(void)setDelegate:(id)delegate;
-(void)removeBannerAd;
-(NSArray *)blockedInterstitialControllerClasses;
-(UIView *)bannerAdView;

@end

@protocol NFAdDisplayerSettings <NSObject>

-(BOOL)removeAds;

@end

typedef enum {
    NFAdDisplayerBannerAdPositionTop,
    NFAdDisplayerBannerAdPositionBottom,
}NFAdDisplayerBannerAdPosition;


typedef enum {
    NFAdDisplayerUserTypePurchasesNone,
    NFAdDisplayerUserTypePurchasesSome, // Some > $0
    NFAdDisplayerUserTypePurchasesMany, // Many > $9
    NFAdDisplayerUserTypePurchasesAll,
}NFAdDisplayerUserTypePurchases;

typedef enum {
    NFAdDisplayerUserTypeSessionsNone,
    NFAdDisplayerUserTypeSessionsSome,  // Some > 2
    NFAdDisplayerUserTypeSessionsMany,  // Many > 10
}NFAdDisplayerUserTypeSessions;


@protocol NFAdSdkInstance <NSObject>

-(void)showInterstitial:(NSString *)label;
-(void)showInterstitial:(NSString *)label completionHandler:(void (^ )(BOOL impressionWasFilled))completionHandler;
-(void)showAd:(NSString *)label;
-(void)showInterstitial;
-(void)showBannerAd;
-(void)showBannerAd:(NSString *)label;
-(void)setDelegate:(id)delegate;
-(void)removeBannerAd;
-(void)setBannerAdPosition:(NFAdDisplayerBannerAdPosition)position;

-(void)playVideoAdForZone:(NSString *)zoneID withDelegate:(id)delegate;
-(void)showVideoAd:(NSString *)label;

-(void)showMoreApps;
-(BOOL)moreAppsLoaded;


@end

@protocol NFAdDisplayerStore <NSObject>
-(NSMutableArray *)myPurchases;
-(BOOL)allProductsUnlocked;


@end


@protocol NFAdDisplayerDelegate <NSObject>
@optional
-(void)adSdkInstance:(id<NFAdSdkInstance>)adSdkInstance didDisplayBannerAd:(UIView *)bannerAdView;
@optional
-(void)adSdkInstance:(id<NFAdSdkInstance>)adSdkInstance willDisplayBannerAd:(UIView *)bannerAdView;

@optional
-(void)adSdkInstanceDidDisplayVideoAd:(id<NFAdSdkInstance>)adSdkInstance;

@optional
-(void)adSdkInstanceWillDisplayVideoAd:(id<NFAdSdkInstance>)adSdkInstance;


-(BOOL)shouldShowInterstitial;

-(BOOL)shouldShowBannerAd;


// Called when an interstitial has failed to come back from the server
- (void)didFailToLoadInterstitial:(NSString *)location;

// Called when the user dismisses the interstitial
// If you are displaying the add yourself, dismiss it now.
- (void)didDismissInterstitial:(NSString *)location;

// Same as above, but only called when dismissed for a close
- (void)didCloseInterstitial:(NSString *)location;

// Same as above, but only called when dismissed for a click
- (void)didClickInterstitial:(NSString *)location;


- (void)didPressRemoveAds;


@end



@interface NFAdDisplayer : NSObject<NFAdDisplayer>

@property (nonatomic, strong) NSArray *defaultTags;
@property (nonatomic, strong) id<NFAdDisplayerSettings> settings;
@property (nonatomic, strong) id<NFAdDisplayerStore> store;
@property (nonatomic, strong) NSArray *adSdkInstances;
@property (nonatomic, strong) NSArray *bannerAdSdkInstances;
@property (nonatomic, strong) NSArray *videoAdSdkInstances;
@property (nonatomic, strong) NSArray *moreAppsAdSdkInstances;
@property int minimimTimeInSecondsBetweenInterstitials;
@property (nonatomic, strong) NSArray *blockedBannerAdViewControllerClasses;
@property (nonatomic, unsafe_unretained) id<NFAdDisplayerDelegate> delegate;
@property BOOL interstitialIsVisible;
@property (nonatomic, strong) NSArray *blockedInterstitialControllerClasses;
@property BOOL shouldBlockAllInterstitials;
@property (nonatomic, strong) UIView *bannerAdView;
@property NFAdDisplayerUserTypeSessions userTypeSessions;
@property NFAdDisplayerUserTypePurchases userTypePurchases;
@property (strong) NFAdDisplayerVideoAdCompletionHandler videoAdCompletionHandler;
@property (nonatomic, copy) NSString *defaultVideoAdZoneId;
@property (nonatomic, strong) id<NFAdDisplayerDeviceProfile> deviceProfile;

@property (nonatomic, strong) NSDate *videoAdLastShownAt;

+ (NFAdDisplayer *)sharedInstance;
-(void)showInterstitialForObject:(id)object inFunction:(SEL)function;
-(void)showInterstitial:(NSString *)label;
-(void)showInterstitial:(NSString *)label usingSdkInstanceWithClassName:(NSString *)sdkInstanceClassName;
-(void)removeBannerAd;



#pragma mark ===== VIDEO ADS =====
-(void)showVideoAd:(NFAdDisplayerVideoAdCompletionHandler)completionHandler;
-(void)showVideoAd:(NSString *)label withCompletionHandler:(NFAdDisplayerVideoAdCompletionHandler)completionHandler;
-(void)showVideoAd:(NSString *)label usingSdkInstanceWithClassName:(NSString *)sdkInstanceClassName withCompletionHandler:(NFAdDisplayerVideoAdCompletionHandler)completionHandler;


#pragma mark ===== MORE APPS =====
-(void)showMoreApps;



#pragma mark ===== DEVICE PROFILE =====
-(void)updateAdDisplayerSettingsBasedOnDeviceProfile;

@end
