//
//  NFAnalytics.h
//
//  Created by William Locke on 3/5/13.
//
//

#import <Foundation/Foundation.h>

@class DVAdKit;

// TODO: remove from .h
@class DVAdViewController;


@protocol DVAdKitDelegate <NSObject>

// Same as above, but only called when dismissed for a close
@optional
- (void)didCloseInterstitial:(NSString *)location;

// Same as above, but only called when dismissed for a click
@optional
- (void)didClickInterstitial:(NSString *)location;

@optional
-(void)didPressRemoveAds;

//-(void)dvadkit:(DVAdKit *)dvadkit removeAdsButtonPressed:(id)removeAdsButton;
//-(void)dvadkit:(DVAdKit *)dvadkit didPressInterstitial:(NSString *)interstitial;
//-(void)dvadkit:(DVAdKit *)dvadkit didCloseInterstitial:(NSString *)interstitial;

@end


@interface DVAdKit : NSObject

@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, strong) id <DVAdKitDelegate> delegate;


// TODO: remove from .h
@property (nonatomic, strong) DVAdViewController *adViewController;



+ (DVAdKit *)sharedInstance;


- (void)showInterstitial;
- (void)showInterstitial:(NSString *)label;
-(void)showInterstitial:(NSString *)label completionHandler:(void (^ )(BOOL impressionWasFilled))completionHandler;

// This function replaces startSession
-(void)start;





@end



