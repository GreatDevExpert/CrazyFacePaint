//
//  NFAdMob.h
//
//  Created by William Locke on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "NFAdDisplayer.h"
#import "GADBannerView.h"
#import "GADInterstitial.h"

@class NFAdMob;

@protocol NFAdMobDelegate <NFAdDisplayerDelegate>
@optional
-(void)adSdkInstance:(NFAdMob *)adSdkInstance didDisplayBannerAd:(UIView *)bannerAdView;
@optional
-(void)adSdkInstance:(NFAdMob *)adSdkInstance willDisplayBannerAd:(UIView *)bannerAdView;

@end



typedef enum {
    NFAdMobBannerAdPositionTop,
    NFAdMobBannerAdPositionBottom,
    }NFAdMobBannerAdPosition;

@interface NFAdMob : NSObject

@property (nonatomic, copy) NSString *interstialAdUnitId;
@property (nonatomic, copy) NSString *bannerAdUnitId;
@property (nonatomic, copy) NSString *videoAdUnitId;
@property (nonatomic, retain) GADBannerView *adView;
@property NFAdMobBannerAdPosition bannerAdPosition;
@property CGRect bannerAdFrame;
@property BOOL shouldAnimateBannerAdPresentation;

@property(nonatomic, strong) GADInterstitial *interstitial;
@property(nonatomic, strong) GADInterstitial *videoAd;

@property BOOL interstitialIsVisible;


@property (nonatomic, unsafe_unretained) id<NFAdMobDelegate> delegate;


+ (NFAdMob *)sharedInstance;

- (void)showBannerAd;
- (void)showBannerAd:(NSString *)label;

- (void)showInterstitial;
- (void)showInterstitial:(NSString *)label;


- (void)showVideoAd;
- (void)showVideoAd:(NSString *)label;

@end
