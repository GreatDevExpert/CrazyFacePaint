//
//  ViewController.h
//  Cookie Maker
//
//  Created by William Locke on 1/25/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "NFViewController.h"

#import "Sounds.h"
#import "Store.h"
#import "NFViews.h"
#import "AppDelegate.h"
#import "StoreViewController.h"
#import "Images.h"
#import "NFCharacterView.h"
//#import "KSLabel.h"
#import "Session.h"
@class SHKActionSheet;

static const float kViewControllerDefaultAnimationDuration = 0.6;

static UIView *EXTRAS_VIEW;

@interface ViewController : NFViewController

@property (nonatomic, strong) AppDelegate *appDelegate;
//@property (nonatomic, strong) UserSession *userSession;
@property (nonatomic, strong) StoreViewController *storeViewController;

@property (nonatomic, strong) NSString *imageNameForSoundButtonOff;
@property (nonatomic, strong) NSString *imageNameForSoundButtonOn;
@property (nonatomic, strong) IBOutlet UIButton *soundButton;
@property (nonatomic, strong) SHKActionSheet *shareKitActionSheet;
@property (nonatomic, strong) IBOutlet UIImageView *textImageView;

@property (nonatomic, strong) IBOutlet NFCharacterView *characterView;

//@property (nonatomic, strong) KSLabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIButton *unlockThemeButton;

@property (nonatomic, strong) UIView *extrasView;

-(void)playBackgroundMusic;
-(void)playBackgroundMusicForTheme:(NSString *)identifier;
-(void)playClickSoundWithIdentifier:(NSString *)identifier;

#pragma mark Events
-(void)soundButtonPressed:(id)sender;

-(void)closetButtonPressed:(id)sender;

#pragma mark Actions
-(void)share;

#pragma mark Layout
-(void)layoutButtons;
-(void)reset;


#pragma mark IBAction
-(IBAction)unlockThemeButtonPressed:(id)sender;
-(void)updateSoundButton;

#pragma mark Data
-(NSArray *)controlButtonNames;

#pragma mark Show / Hide
-(void)showTitleForTheme:(NSString *)identifier;

-(void)showBackgroundWithIdentifier:(NSString *)identifier;
-(void)showLockButtonWithIdentifier:(NSString *)identifier;



-(void)didSelectClothingItem:(id)sender forImageView:(NFImageView *)imageView andTheme:(NSString *)theme;


@end
