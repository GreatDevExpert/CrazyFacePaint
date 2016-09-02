//
//  NFGameViewController.h
//  App
//
//  Created by William Locke on 2/20/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFViewController.h"
#import "NFPopupViewController.h"
#import "NFCharacterView.h"
#import "NFViewController+soundHandlers.h"
#import "NFViewController+titleHandlers.h"
@class NFGameViewController;

@protocol NFGameViewControllerLayoutComponent <NSObject>

@optional
-(void)gameViewControllerDidLayoutButtons:(NFGameViewController *)gameViewController;

@optional
-(void)gameViewControllerDidLayoutArrowButtons:(NFGameViewController *)gameViewController;

@optional
-(void)gameViewController:(NFGameViewController *)gameViewController didMakeSpaceForBannerAd:(UIView *)bannerAdView;

@end

@protocol NFGameSession <NSObject>

-(NSString *)characterImagesBaseFolderKeyPath;
-(NSString *)clothingImagesBaseFolderKeyPath;
-(NSNumber *)characterIndex;
-(NSMutableDictionary *)clothingIndexesDictionary;
-(void)setClothingIndexesDictionary:(NSMutableDictionary *)clothingIndexesDictionary;

@end

typedef enum {
    NFGameViewControllerAnimationSlideRight,
    NFGameViewControllerAnimationSlideLeft
    }NFGameViewControllerAnimation;

@interface NFGameViewController : NFViewController


@property (nonatomic, strong) id<NFGameSession> sharedSession;  // Static object that holds a bunch of shared data that persists across all game view controllers
@property (nonatomic, strong) id retainedBlock;
@property (nonatomic, strong) NFControlButtonStripView *sideControlButtonStripView;
@property (nonatomic, strong) NFControlButtonStripView *topControlButtonStripView;
@property (nonatomic, strong) UIButton *leftArrowButton;
@property (nonatomic, strong) UIButton *rightArrowButton;
@property (nonatomic, strong) NFScrollViewSelector *bottomScrollViewSelector;
@property BOOL screenHasBeenInteractedWith;
@property (nonatomic, strong) NFCharacterView *characterView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UIButton *homeButton;
@property (nonatomic, strong) NFPopupViewController *popupViewController;
@property (nonatomic, strong) UIView *lockedScreenView;
@property float secondsToDisableArrowButtonsForUponLoad;
@property (nonatomic, strong) NSMutableArray *movingBackgroundImageViews;
@property (nonatomic, strong) NSMutableDictionary *clothingIndexesDictionary;

@property (nonatomic, strong) id<NFGameViewControllerLayoutComponent> layoutComponent;

// View for auto-adjusted view that stays the same proportionate width and height
// and stays vertically centered in the view
@property (nonatomic, strong) IBOutlet UIView *verticallyCenteredContainerView;

+(void)setNFGameViewControllerClasses:(NSArray *)gameViewControllerClasses;
+(void)setPopToViewControllerClass:(Class )viewControllerClass;
+(NSArray *)getNFGameViewControllerClasses;

#pragma mark Layout
-(void)layout;
-(void)layoutControlButtonStripViews;
-(void)layoutArrowButtons;
-(void)layoutButtons;
-(void)layoutBackgroundImageView;


#pragma mark -- Character
-(NSString *)characterImagesBaseFolderKeyPath;
-(NSString *)clothingImagesBaseFolderKeyPath;
-(NSArray *)characterViewIdentifiers;
-(NSMutableArray *)characterImageViewObjects;
-(void)layoutCharacter;


#pragma mark IBActions
-(IBAction)leftArrowButtonPressed:(id)sender;
-(IBAction)rightArrowButtonPressed:(id)sender;

#pragma mark Purchases
-(void)showPopupViewController;
-(void)showPopupViewControllerForLockedDraggableView:(NFDraggableView *)draggableView;
-(void)didUnlockThisViewController;
-(BOOL)shouldShowPurchasePopupViewControllerUponLoad;



-(IBAction)navigateLeft;
-(IBAction)navigateRight;
-(IBAction)homeButtonPressed:(id)sender;

-(void)presentNextActivityViewController;
-(void)presentNextActivityViewControllerWithAnimation:(NFGameViewControllerAnimation)gameViewControllerAnimation;


@end
