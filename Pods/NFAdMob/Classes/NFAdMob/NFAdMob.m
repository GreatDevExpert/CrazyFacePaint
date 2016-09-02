//
//  NFAdMob.m
//
//  Created by William Locke on 3/5/13.
//
//

#import "NFAdMob.h"

#import "GADBannerView.h"
//#import "AdMobMediationAdapterVungle.h"

@interface NFAdMob()<GADBannerViewDelegate>{
    GADBannerView *_bannerView;
    NSDate *_lastInterstitialShownAt;
}
@end

@implementation NFAdMob

+ (NFAdMob *)sharedInstance
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

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}



-(UIViewController *)applicationsCurrentTopViewController{
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    UIViewController *topViewController = rootViewController;
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]){
        topViewController = ((UITabBarController *)rootViewController).selectedViewController;
    }else if ([rootViewController isKindOfClass:[UINavigationController class]]){
        topViewController = ((UINavigationController *)rootViewController).topViewController;
    }
    return topViewController;
}

- (void)showBannerAd{
    [self showBannerAd:nil];
}


- (void)showBannerAd:(NSString *)label{
    [self.adView removeFromSuperview];
    
    if(label && [label isEqualToString:@"Remove Ads"]){
        return;
    }
    
    
    CGSize bannerSize;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        bannerSize = CGSizeMake(728, 90);
    }else{
        bannerSize = CGSizeMake(320, 50);
    }
    
    self.adView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    
    
    self.adView.delegate = self;
    
    self.adView.adUnitID = self.bannerAdUnitId;
    

    
    UIViewController *topViewController = [self applicationsCurrentTopViewController];
    UIView *view = topViewController.view;
    
    self.adView.rootViewController = topViewController;
    
    
    if(self.bannerAdPosition == NFAdMobBannerAdPositionBottom){
        self.bannerAdFrame = CGRectMake((view.bounds.size.width - bannerSize.width) * 0.5, view.bounds.size.height - bannerSize.height,
                                        bannerSize.width, bannerSize.height);
        self.adView.frame = CGRectOffset(self.bannerAdFrame, 0, self.bannerAdFrame.size.height);
        
        
    }else if(self.bannerAdPosition == NFAdMobBannerAdPositionTop){
        self.bannerAdFrame = CGRectMake((view.bounds.size.width - bannerSize.width) * 0.5, 0,
                                        bannerSize.width, bannerSize.height);
        self.adView.frame = CGRectOffset(self.bannerAdFrame, 0, -self.bannerAdFrame.size.height);
    }
    [view addSubview:self.adView];
    
    GADRequest *request =[GADRequest request];
//    [request tagForChildDirectedTreatment:YES];
    [self.adView loadRequest:request];
}


-(void)removeBannerAd{
    [self.adView removeFromSuperview];
    
}


#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return [self applicationsCurrentTopViewController];
}




- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    if(self.shouldAnimateBannerAdPresentation){
        [UIView animateWithDuration:0.7 animations:^{
            self.adView.frame = self.bannerAdFrame;
        }completion:^(BOOL finished){
            if(self.delegate && [self.delegate respondsToSelector:@selector(adSdkInstance:didDisplayBannerAd:)]){
                [self.delegate adSdkInstance:self didDisplayBannerAd:self.adView];
            }
        }];
    }else{
        self.adView.frame = self.bannerAdFrame;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(adSdkInstance:willDisplayBannerAd:)]){
        [self.delegate adSdkInstance:self willDisplayBannerAd:self.adView];
    }
    
//    [self makeSpaceForBannerAd:self.adView animated:self.shouldAnimateBannerAdPresentation];
}





- (void)showInterstitial{
    [self showInterstitial:nil];
}


- (void)showInterstitial:(NSString *)label{
    if(label && [label isEqualToString:@"Remove Ads"]){
        return;
    }
    
    if (self.interstitial && self.interstitialIsVisible) {
        // If interstitials haven't been shown for a minute, assume there is
        // some bug and just show another one.
        int timeOutSeconds = 60;
        if (!_lastInterstitialShownAt || [[NSDate date] timeIntervalSinceDate:_lastInterstitialShownAt] > timeOutSeconds) {
            self.interstitialIsVisible = NO;
            NSLog(@"WARNING: NFAdMob is saying interstitial is already visible, but the last interstitial was shown over %d minute ago.", timeOutSeconds);
            return;
        }else{
            NSLog(@"ERROR: NFAdMob interstitial is already visible");
            return;
        }
    }
    
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = self.interstialAdUnitId;
    self.interstitial.delegate = (id<GADInterstitialDelegate>) self;
    
    GADRequest *request = [GADRequest request];
    // Requests test ads on simulators.
//    request.testDevices = @[ GAD_SIMULATOR_ID ];
//#ifdef DEBUG
//    request.testDevices = @[ GAD_SIMULATOR_ID ];
//#endif
    
    [self.interstitial loadRequest:request];
    
}


- (void)showVideoAd{
    [self showVideoAd:nil];
}

- (void)showVideoAd:(NSString *)label{
    
    if(label && [label isEqualToString:@"Remove Ads"]){
        return;
    }
    self.videoAd = [[GADInterstitial alloc] init];
    self.videoAd.adUnitID = self.videoAdUnitId;
    self.videoAd.delegate = (id<GADInterstitialDelegate>) self;
    
    GADRequest *request = [GADRequest request];
    // Requests test ads on simulators.
    //    request.testDevices = @[ GAD_SIMULATOR_ID ];
    //#ifdef DEBUG
    //    request.testDevices = @[ GAD_SIMULATOR_ID ];
    //#endif
    
    [self.videoAd loadRequest:request];
}


-(UIViewController *)applicationsCurrentRootViewController{
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while ([rootViewController isKindOfClass:[UITabBarController class]] || [rootViewController isKindOfClass:[UINavigationController class]]) {
        if ([rootViewController isKindOfClass:[UITabBarController class]]){
            rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
        }else if ([rootViewController isKindOfClass:[UINavigationController class]]){
            rootViewController = ((UINavigationController *)rootViewController).topViewController;
        }
    }
    
    return rootViewController;
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    
    if (interstitial == self.interstitial) {
        self.interstitialIsVisible = YES;
    }
    _lastInterstitialShownAt = [NSDate date];
    
    NSLog(@"interstitial: %@", interstitial);
    
    [interstitial presentFromRootViewController:[self applicationsCurrentRootViewController] ];
//    if (interstitial && interstitial != self.videoAd) {
//        [interstitial presentFromRootViewController:[self applicationsCurrentRootViewController] ];
//    }

    

}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
    NSLog(@"failed to receive ad");
    [self.delegate didFailToLoadInterstitial:nil];
    
    
}



/// Called just before presenting an interstitial. After this method finishes the interstitial will
/// animate onto the screen. Use this opportunity to stop animations and save the state of your
/// application in case the user leaves while the interstitial is on screen (e.g. to visit the App
/// Store from a link on the interstitial).
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad{
    
}

/// Called before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad{
    if (ad == self.interstitial) {
        self.interstitialIsVisible = NO;
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(didDismissInterstitial:)]) {
        [self.delegate didDismissInterstitial:nil];
    }

}

/// Called just after dismissing an interstitial and it has animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    if (ad == self.interstitial) {
        self.interstitialIsVisible = NO;
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(didDismissInterstitial:)]) {
        [self.delegate didDismissInterstitial:nil];
    }
    if (self.videoAd == ad) {
        if ([self.delegate respondsToSelector:@selector(adSdkInstanceDidDisplayVideoAd:)]) {
            [self.delegate adSdkInstanceDidDisplayVideoAd:(id<NFAdSdkInstance>)self];
        }
    }
}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store). The normal
/// UIApplicationDelegate methods, like applicationDidEnterBackground:, will be called immediately
/// before this.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didClickInterstitial:)]) {
        [self.delegate didClickInterstitial:nil];
    }
}


@end
