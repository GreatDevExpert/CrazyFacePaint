//
//  MasterViewController.m
//  NinjafishStudiosApp
//
//  Created by William Locke on 9/17/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//

#import "MasterViewController.h"
#import "Chartboost.h"
#import "NFData.h"
#import "NFImage.h"
#import "NFLayout.h"
#import "NFSettings.h"
#import "Sounds.h"
#import "Store.h"
#import "NFStoreViewController.h"
#import "NFGameViewController.h"
#import "ChooseCharacterViewController.h"
#import "NFTimerView.h"
#import "LocalPushNotificationHandler.h"
#import "GiftTimer.h"
#import "MakeUpViewController.h"
#import "FacepaintViewController.h"
#import "NFPopupViewController.h"

#if __has_include("DVAdKit.h")
#import "DVInteractiveAdManager.h"
#import "DVInteractiveAd.h"
#endif


@interface MasterViewController ()<ChartboostDelegate>{
    
}

@end

@implementation MasterViewController

- (id)initWithNib
{
    self = [super initWithNib];
    if (self) {
        
        self.releaseImagesOnPush = NO;
        
        self.imageNameForSoundButtonOff = @"home-buttons-sound-off";
        self.imageNameForSoundButtonOn = @"home-buttons-sound-on";
        
        self.nextViewControllerClass = [ChooseCharacterViewController class];

        [NFGameViewController setNFGameViewControllerClasses:@[ [FacepaintViewController class], [MakeUpViewController class] ]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Play music when view loads (implemented in parent class)
    [self playBackgroundMusic];
    
    [self layout];
    
    [NFAnimation sequentiallyPopInViews:@[self.soundButton, _restorePurchasesButton, _moreGamesButton, _playButton] eachPopinDuration:0.4 completionHandler:nil];

    self.giftTimer = [[GiftTimer alloc] initWithViewController:self];
        
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setupGiftTimer];
    });
    

#if __has_include("DVAdKit.h")
    [[DVInteractiveAdManager sharedInstance] displayEmbeddedInteractive:self.popinInteractiveAds withLabel:@"popin" completionHandler:^(DVInteractiveAd *interactiveAd) {
        [interactiveAd popin];
    }];
#endif
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.giftTimer resume];
    
    if (![self.giftTimer hasTimeLeft]) {
        [self setupGiftTimer];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];    // Call the super class
    
    [self.giftTimer silence];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [NFAnimation endLoopedAnimationForView:_playButton];
    [NFAnimation pulseSizeOfView:_playButton];

    self.nextViewControllerClass = [ChooseCharacterViewController class];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [NFAnimation endLoopedAnimationForView:_playButton];
}



#pragma mark Gift Timer
-(void)setupGiftTimer{
    NSMutableArray *notifications =
    [LocalPushNotificationHandler UILocalNotificationsFromNFLocalPushNotifications:[[LocalPushNotificationHandler sharedInstance] remainingProductGiveawayNotifications]];
    if ([notifications count] == 0) {
        return;
    }
    
    int seconds = 300;

    [self.giftTimer displayWithCountdownLenthInSeconds:seconds notifications:notifications timerBackgroundImageName:@"home-timer_background" completionHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setupGiftTimer];
        });
        
    } timerPressedCallback:^{
        if (![NFLocalPushNotification notificationsEnabledOnDevice]) {
            [NFLocalPushNotification promptUserToTurnOnNotificationsInSettingsWithMessage:@"In order to receive gifts and gift alerts notifications must be enabled" andTitle:@"Surprise!"];
            return;
        }else{
            NFAlertView *alertView = [[NFAlertView alloc] initWithTitle:@"Surprise!" message:@"\ue112 Your treat isn't ready yet \ue112" cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
            }];
        }
    }];
    
    [self.giftTimer.timerView updateLabel];
    
    [self.view insertSubview:self.giftTimer.timerView belowSubview:_playButton];
    
    [self styleGiftTimerLabel];
    self.giftTimer.timerView.label.frame = CGRectMake(-self.giftTimer.timerView.frame.size.width * 0.08, self.giftTimer.timerView.frame.size.height * 0.1, self.giftTimer.timerView.label.frame.size.width, self.giftTimer.timerView.label.frame.size.height);
}

-(void)styleGiftTimerLabel{
    [self.giftTimer.timerView.label removeFromSuperview];
    self.giftTimer.timerView.label = [[KSLabel alloc] initWithFrame:self.giftTimer.timerView.label.frame];
    self.giftTimer.timerView.label.font = [UIFont fontWithName:@"Plasma Drip (BRK)" size:self.giftTimer.timerView.label.font.pointSize];

    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self.giftTimer.timerView.label.font = [UIFont fontWithName:@"Marker Felt" size:40];
    }else{
        self.giftTimer.timerView.label.font = [UIFont fontWithName:@"Marker Felt" size:20];
    } 
    
    self.giftTimer.timerView.label.textAlignment = UITextAlignmentCenter;
    [self.giftTimer.timerView addSubview:self.giftTimer.timerView.label];
    
    [((KSLabel *)self.giftTimer.timerView.label) setDrawOutline:YES];
    [((KSLabel *)self.giftTimer.timerView.label) setOutlineColor:[UIColor colorWithRed:175/255.0 green:81/255.0 blue:15/255.0 alpha:1.0]];

    [((KSLabel *)self.giftTimer.timerView.label) setDrawGradient:YES];
    CGFloat colors [] = {
        1, 1, 1, 1.0,
        1, 1, 1, 0.5,
    };
    [((KSLabel *)self.giftTimer.timerView.label) setGradientColors:colors];
    ((KSLabel *)self.giftTimer.timerView.label).outlineWidth = NFGeometryUniversalDistance(2);
    
}

#pragma mark Layout Functions
-(void)layout{
    [self.view addSubview:_restorePurchasesButton];
    [self.view addSubview:_moreGamesButton];
    [self.view addSubview:self.soundButton];
    
    [_restorePurchasesButton setImage:[NFImage imageForName:@"home-buttons-restore"] forState:UIControlStateNormal];


    self.backgroundImageView.image = [NFImage imageForName:@"home-background.jpg"];
    [_playButton setImage:[NFImage imageForName:@"home-buttons-play"] forState:UIControlStateNormal];
    [_moreGamesButton setImage:[NFImage imageForName:@"home-buttons-more_games"] forState:UIControlStateNormal];
    [_restorePurchasesButton setImage:[NFImage imageForName:@"home-buttons-restore"] forState:UIControlStateNormal];
    if ([NFSettings sharedInstance].removeAds) {
        [self.adsButton setImage:[NFImage imageForName:@"home-buttons-ads-off"] forState:UIControlStateNormal];
    }else{
        [self.adsButton setImage:[NFImage imageForName:@"home-buttons-ads-on"] forState:UIControlStateNormal];
    }
    if ([NFSettings sharedInstance].soundsOn) {
        [self.soundButton setImage:[NFImage imageForName:@"home-buttons-sound-on"] forState:UIControlStateNormal];
    }else{
        [self.soundButton setImage:[NFImage imageForName:@"home-buttons-sound-off"] forState:UIControlStateNormal];
    }
    self.soundButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.adsButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.moreGamesButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.restorePurchasesButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _playButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleImageView.image = [NFImage imageForName:@"home-logo"];
}


#pragma mark IBActions / Events
-(IBAction)restorePurchasesButtonPressed:(id)sender{
    [[Sounds sharedInstance] playShortSound:kSoundNameclick];
    
    [self.view addSubview:self.activityIndicatorView];
    [self.store restorePurchases:^(BOOL success){
        [self.activityIndicatorView removeFromSuperview];
        if(success){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Purchases Restored" message:@"Your purchases have been restored" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            // Perform other actions.
        }
    }];
}


-(IBAction)moreGamesButtonPressed:(id)sender{
    [sender setEnabled:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender setEnabled:YES];
    });
    
    [[Sounds sharedInstance] playShortSound:kSoundNameclick];
    [[NFAdDisplayer sharedInstance] showMoreApps];
    
}


-(IBAction)soundButtonPressed:(id)sender{
    [super soundButtonPressed:sender];
}

-(IBAction)storeButtonPressed:(id)sender{
    [[Sounds sharedInstance] playShortSound:kSoundNameclick];
    NSArray *productIds = [self.popupViewController productIdsForViewController:self];
    
    [self.popupViewController showInViewController:self withProductIds:productIds withPurchaseCompletedHandler:^(NFProduct *product){
        
        [self.popupViewController.view removeFromSuperview];
        
    } andViewClosedHandler:^{
        
    }];
    
}


-(IBAction)playButtonPressed:(id)sender{
    [[Sounds sharedInstance] playShortSound:kSoundNameclick];
    
    [self presentNextViewController];
}


-(IBAction)adsButtonPressed:(id)sender{
    
    NSString *productId = [@"" stringByAppendingString:[@"" stringByAppendingFormat:@"%@.remove_ads", [[NSBundle mainBundle] bundleIdentifier]]];
    BOOL optionAvailable = NO;
    
    if([NFSettings sharedInstance].removeAds == NO){
        if(productId){
            if([self.store respondsToSelector:@selector(productHasAlreadyBeenBought:)]){
                BOOL alreadyPurchased = [self.store productHasAlreadyBeenBought:productId];
                NSArray *freeWithProductsContaining = @[@"_pack", @"unlock_everything"];
                
                if(alreadyPurchased){
                    optionAvailable = YES;
                }else{
                    NSArray *myPurchases = @[];
                    if([self.store respondsToSelector:@selector(myPurchases)]){
                        myPurchases = [self.store myPurchases];
                        
                        for(NSString *productIdFragment in freeWithProductsContaining){
                            for(NFProduct *product in myPurchases){
                                if([product respondsToSelector:@selector(identifier)]){
                                    NSString *tmpProductId = [product identifier];
                                    if([tmpProductId rangeOfString:productIdFragment].location != NSNotFound){
                                        optionAvailable = YES;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if(!optionAvailable){
                if([self.store respondsToSelector:@selector(productWithProductId:)] && [self.store respondsToSelector:@selector(purchase:completionHandler:)]){
                    NFProduct *product = [self.store productWithProductId:productId];

                    [self purchase:product completionHandler:^(BOOL success){
                        if (success) {
                            if([self.store productHasAlreadyBeenBought:productId]){
                                [NFSettings sharedInstance].removeAds = YES;
                                [self.adsButton setImage:[NFImage imageForName:@"home-buttons-ads-off"] forState:UIControlStateNormal];
                                [self.adDisplayer removeBannerAd];
                            }
                        }
                    }];
                    return;
                }
            } 
        }
        [NFSettings sharedInstance].removeAds = YES;
        [self.adsButton setImage:[NFImage imageForName:@"home-buttons-ads-off"] forState:UIControlStateNormal];
        
        [self.adDisplayer removeBannerAd];
    }else{
        [NFSettings sharedInstance].removeAds = NO;
        [self.adsButton setImage:[NFImage imageForName:@"home-buttons-ads-on"] forState:UIControlStateNormal];
    }
    
}


#pragma mark Navigation Functions
#pragma mark Delegates
// Blocking parent call
-(void)releaseImages{
    
}

// Blocking parent call
-(void)makeSpaceForBannerAd:(UIView *)bannerAdView animated:(BOOL)animated{
    
}

// Blocking parent call
-(void)adjustLayoutForIPhone5{
    
}

@end
