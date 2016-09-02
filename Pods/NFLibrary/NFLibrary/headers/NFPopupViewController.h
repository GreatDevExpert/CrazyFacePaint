//
//  NFPopupViewController.h
//  BabyParkFun
//
//  Created by William Locke on 1/7/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFViewController.h"

@class NFPopupViewController;
@protocol NFPopupViewControllerDelegate <NSObject>

-(void)themeUnlocked;
-(void)didUnlockAllCharacters;

@end


typedef void (^ NFPopupViewControllerPurchaseCompletionHandler)(NFProduct *product);
typedef void (^ NFPopupViewControllerViewClosedHandler)();

@interface NFPopupViewController : UIViewController


@property (nonatomic, strong) UIViewController<NFPopupViewControllerDelegate> *parentViewController;
@property (nonatomic, strong) IBOutlet UIButton *closeButton;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, strong) NFStore *store;
@property (strong, nonatomic) UIView *activityIndicatorView;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *productButtons;
@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *productLabels;
@property (nonatomic, strong) NSMutableArray *productIds;

@property (nonatomic, strong) IBOutlet UIButton *removeAdsButton;


#pragma mark IBActions
-(IBAction)xButtonPressed:(id)sender;
-(IBAction)unlockEverythingButtonPressed:(id)sender;
-(IBAction)removeAdsButtonPressed:(id)sender;


-(void)updateActivityButton;
-(BOOL)showInViewController:(NFViewController *)viewController withProductIds:(NSArray *)productIds withPurchaseCompletedHandler:(NFPopupViewControllerPurchaseCompletionHandler)purchaseCompletionHandler andViewClosedHandler:(NFPopupViewControllerViewClosedHandler)viewClosedHandler;
-(BOOL)showInViewController:(NFViewController *)viewController withProductIds:(NSArray *)productIds withPurchaseCompletedHandler:(NFPopupViewControllerPurchaseCompletionHandler)purchaseCompletionHandler andViewClosedHandler:(NFPopupViewControllerViewClosedHandler)viewClosedHandler showOnlyIfTopProductIsLocked:(BOOL)showOnlyIfTopProductIsLocked;
-(NSArray *)productIdsForViewController:(NFViewController *)viewController;
-(NSArray *)productIdsForViewController:(NFViewController *)viewController purchasableUserInterfaceElements:(NSArray *)purchasableUserInterfaceElements;
-(NSString *)activityProductIdForViewControllerClass:(Class )viewControllerClass;

@end
