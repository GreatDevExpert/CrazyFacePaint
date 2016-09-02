//
//  MasterViewController.h
//  NinjafishStudiosApp
//
//  Created by William Locke on 9/17/12.
//  Copyright (c) 2014 William Locke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFViewController.h"
#import "NFPopupViewController.h"
#import "NFTimerView.h"
#import "NFPopupViewController.h"
//#import "kSLabel.h"
@class GiftTimer;

//! Subclasses NFViewController - for faster setup of common UI elements
//  such as loading indicators, background image view, controls layer.
@interface MasterViewController : NFViewController

@property (nonatomic, strong) IBOutlet UIButton *adsButton;
@property (nonatomic, strong) NFPopupViewController *popupViewController;

@property (nonatomic, copy) NSString *imageNameForSoundButtonOff;
@property (nonatomic, copy) NSString *imageNameForSoundButtonOn;
@property (nonatomic, strong) IBOutlet UIButton *moreGamesButton;
@property (nonatomic, strong) IBOutlet UIButton *storeButton;
@property (nonatomic, strong) IBOutlet UIButton *playButton;
@property (nonatomic, strong) IBOutlet UIButton *restorePurchasesButton;
@property (nonatomic, strong) IBOutlet UIImageView *titleImageView;
@property (nonatomic, strong) IBOutlet UIButton *settingsButton;
@property (nonatomic, strong) IBOutlet UIButton *soundButton;

//@property (nonatomic, strong) IBOutlet NFTimerView *timerView;
@property (nonatomic, strong) GiftTimer *giftTimer;

// INTERACTIVE ADS
@property (nonatomic, strong) IBOutletCollection(UIImageView) NSArray *popinInteractiveAds;


-(IBAction)soundButtonPressed:(id)sender;
-(IBAction)settingButtonPressed:(id)sender;

@end
