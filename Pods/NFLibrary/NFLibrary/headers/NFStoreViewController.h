//
//  NFStoreViewController.h
//
//
//

#import <UIKit/UIKit.h>
#import "NFStoreViewController.h"
@class NFStore;
@class NFAlertView;
@class NFProduct;

@class NFStoreViewController;
@protocol NFStoreViewControllerDelegate <NSObject>
@required
-(void)storeViewControllerPurchaseSucceeded:(NFProduct *)product;
@optional
-(void)storeViewControllerPurchaseFailed:(NFProduct *)product;

@end

@interface NFStoreViewController : UIViewController



//@property (nonatomic, unsafe_unretained) id <NFStoreViewControllerDelegate> delegate;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *restorePurchasesImageName;
@property (nonatomic, strong) NFStore *store;

@property (strong, nonatomic) NSString *backButtonSoundName;
@property (strong, nonatomic) NSString *backNavigationSoundName;
@property (strong, nonatomic) NSString *presentThisViewControllerSoundName;

@property (strong, nonatomic) NSMutableArray *products;

@property BOOL shouldInitiatePurchaseUponStoreOpen;

typedef void (^ NFStoreViewControllerCallback)(NFProduct *product, NSError *error);

@property (strong, nonatomic) UIView *activityIndicatorView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property CGSize productImageSize;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIImageView *canopyImageView;
@property CGPoint currentScrollViewOffest;
@property BOOL storeAlreadyPreviewed;

@property (strong, nonatomic) NFAlertView *storeAlertView;
//@property NFStoreViewControllerCallback callback;
@property (strong, nonatomic) NSMutableArray *productViews;




#pragma mark Navigation Functions
-(void)showInViewController:(UIViewController *)viewController;
-(void)showInViewController:(UIViewController *)viewController afterPromptForProduct:(NSString *)productId callback:(NFStoreViewControllerCallback)callback;


-(NFAlertView *)storeAlertViewForProduct:(NFProduct *)product;



@end
