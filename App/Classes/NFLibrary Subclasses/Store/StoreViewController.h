//
//  StoreViewController.h
//  Ice Pop & Popsicle Maker
//
//  Created by William Locke on 10/18/12.
//
//

#import <UIKit/UIKit.h>
#import "NFStoreViewController.h"
@class Store;
@class NFAlertView;
@class NFProduct;

@class StoreViewController;
@protocol StoreViewControllerDelegate <NSObject>
@required
-(void)storeViewControllerPurchaseSucceeded:(NFProduct *)product;
@optional
-(void)storeViewControllerPurchaseFailed:(NFProduct *)product;

@end

@interface StoreViewController : NFStoreViewController



//@property (nonatomic, unsafe_unretained) id <StoreViewControllerDelegate> delegate;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *restorePurchasesImageName;
@property (nonatomic, strong) NFStore *store;

@property (strong, nonatomic) NSString *backButtonSoundName;
@property (strong, nonatomic) NSString *backNavigationSoundName;

@property (strong, nonatomic) NSString *presentThisViewControllerSoundName;

typedef void (^ StoreViewControllerCallback)(NFProduct *product, NSError *error);


+(StoreViewController *)sharedInstanceWithStore:(Store *)store;
+(StoreViewController *)sharedInstance;

//-(NFAlertView *)storeAlertView;
//-(void)showInViewController:(UIViewController *)viewController ;
//-(void)showInViewController:(UIViewController *)viewController afterPromptForProduct:(NSString *)productId;
//
//-(void)showInViewController:(UIViewController *)viewController afterPromptForProduct:(NSString *)productId callback:(StoreViewControllerCallback)callback;
//
//
//-(IBAction)backButtonPressed:(id)sender;
//-(void)presentThisViewController;


@end
