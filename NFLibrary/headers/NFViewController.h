//
//  NFViewController.h
//  Cupcake
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//
//  For faster setup of common UI elements
//  such as loading indicators, background image view, controls layer.
//
//  Additional common elements can be added on a per app basis by further
//  subclassing.

#import <UIKit/UIKit.h>
#import "NFLayout.h"
#import "NFStore.h"
#import "NFStoreViewController.h"
#import "NFData.h"
#import "NFAnimation.h"
#import "NFImage.h"
#import "NFCategories.h"
#import "NFSounds.h"
#import "NFDownloader.h"
#import "NFData.h"
#import "NFStore.h"
#import "NFUIKit.h"
#import "NFAdDisplayer.h"


extern NSString * const kNFViewControllerNotificationDownloadComplete;

/** This class is designed to be subclassed such that common elements, data properties, and functions of a view controller that uses NFLibrary are available from the get go. 
 
 It may be convenient to create a further subclass that will itself be subclassed in order that custom app objects and functions that are needed by all view controllers of an app are available without code duplication.
 
 
 */
@interface NFViewController : UIViewController<NFStoreViewControllerDelegate>{
    
}

@property (nonatomic, strong) id sharedSession;  // Static object that holds a bunch of shared data that persists across all view controllers
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIView *controlsView;
@property (strong, nonatomic) UIView *activityIndicatorView;
@property (strong, nonatomic) NSMutableDictionary *imagesDictionary;
@property (strong, nonatomic) NFViewController *nextViewController;

@property (strong, nonatomic) NFData *data DEPRECATED_ATTRIBUTE;
@property Class nextViewControllerClass;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) NSMutableArray *loopedAnimations;
@property (strong, nonatomic) NSString *backButtonSoundName;
@property (strong, nonatomic) NSString *nextButtonSoundName;
@property (strong, nonatomic) NSString *backNavigationSoundName;
@property (strong, nonatomic) NSString *nextNavigationSoundName;
@property (getter = state, setter = setState:) int state;
@property BOOL releaseImagesOnPush;
@property NSMutableDictionary *downloadImages;
@property NSMutableArray *downloadImageSections;
@property NFDownloader *downloader;
@property NFStore *store;
@property NFStoreViewController *storeViewController;
@property (strong, nonatomic) id userSession;
@property NFSounds *sounds;
@property (nonatomic, strong) AppDelegate *appDelegate;
@property BOOL shouldUseStoreViewControllerForPurchases;
@property (nonatomic, strong) IBOutlet UIButton *fullScreenButton;
@property (nonatomic, strong) UIWindow *applicationWindow;
@property BOOL nonPhotographicElementsHidden;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, unsafe_unretained) id<NFAdDisplayer> adDisplayer;
@property UIDeviceOrientation deviceOrientation;
@property (nonatomic, strong) NSString *baseFolderKeyPath;
@property (nonatomic, strong) UIView *loadingScreen;

+(NFViewController *)sharedInstance;
+(void)configureWithDownloadsFileName:(NSString *)downloadsConfigurationFileName;


- (id)initWithNib;

-(NSString *)nibName;

#pragma mark NFAdDisplayer
-(BOOL)shouldShowBannerAd;

#pragma mark Created UI Elements
-(UIView *)newActivityIndicatorView;
-(UIView *)createLoadingScreen;

#pragma mark Data Functions
-(NFViewController *)instantiateNextViewController;
-(NFViewController *)previousViewController;

#pragma mark Navigation Functions
-(void)presentNextViewController;
-(void)presentNextViewControllerWithLoadingScreen;
-(void)popThisViewController;
-(void)pushNextViewController;

-(void)transferAttributesToNextViewController;


#pragma mark Events / IBAction Functions
-(IBAction)backButtonPressed:(id)sender;
-(IBAction)nextButtonPressed:(id)sender;
-(IBAction)shareButtonPressed:(id)sender;

#pragma mark Animation
-(void)stopAllLoopedAnimations;


#pragma mark Purchase functions
-(void)purchase:(NSString *)productId responseHandler:(NFStoreResponseHandler)responseHandler __attribute__((deprecated));
-(void)restorePurchases:(NFStoreResponseHandler)responseHandler;
-(void)storeViewControllerPurchaseSucceeded:(NFProduct *)product;
-(void)handleSuccessfulPurchaseForProduct:(NFProduct *)product callback:(NFDownloaderCallback)callback;
-(void)downloadContentForProduct:(NSString *)productId callback:(NFDownloaderCallback)callback;


#pragma mark Download
-(void)showDownloader:(NFDownloader *)downloader inWindow:(UIWindow *)window withDownloadKey:(NSString *)downloadKey callback:(NFDownloaderCallback)callback;
-(NFDownloader *)downloaderForProduct:(NFProduct *)product shouldUseSharedDownloader:(BOOL)shouldUseSharedDownloader;


#pragma mark Identifiers
-(NSString *)stringByConvertingUnderscoreStringToCamelcaseString:(NSString *)camelcaseString;
-(NSString *)stringByConvertingCamelcaseStringToUnderscoreString:(NSString *)underscoreString;
-(Class)viewControllerClassForIdentifier:(NSString *)identifier;
-(NSString *)identifierForViewControllerClass:(Class )viewControllerClass;
-(NSString *)productIdForViewControllerClass:(Class )viewControllerClass;
-(NFProduct *)productForViewController:(UIViewController *)viewController;
-(BOOL)thisViewControllerIsLocked;
-(BOOL)thisViewControllerHasBeenUnlocked;
-(NSString *)randomActivityProductIdExcludingProductIds:(NSArray *)excludedProductIds;
-(NSArray *)viewControllerClassesInThisAppThatAreASubclassOfAnyOfTheseParentClasses:(NSArray *)parentClasses;
-(NSArray *)viewControllerClassNibWithName:(NSString *)wantedNibName;


#pragma mark Memory
-(void)releaseImages;


#pragma mark iPhone 5 layout
-(void)nudgeDownViewForIPhone5:(UIView *)view;
-(void)adjustLayoutForIPhone5;
-(void)adjustLayoutForIPhone5WithMoveDownThreshold:(CGFloat)percentageOfHeightAtWhichToNudgeSubviewsDownward;

#pragma mark Migrated Functions From ViewController
// NFProductDisplayerView
-(void)updateProductPropertiesForProductDisplayerView:(id<NFProductDisplayerView>)productDisplayerView;

-(NFDownloader *)downloadContentForProduct:(NFProduct *)product withAssociatedProductDisplayerView:(id<NFProductDisplayerView>)productDisplayerView callback:(NFDownloaderCallback)callback;

-(NFDownloader *)storePurchaseOfProduct:(NFProduct *)product didCompleteWithSuccess:(BOOL)success withAssociatedProductDisplayerView:(id<NFProductDisplayerView>)productDisplayerView completionHandler:(void (^ )(NFDownloaderStatus downloaderStatus, NSError *error))completionHandler;

-(void)purchase:(NFProduct *)product completionHandler:(NFStoreResponseHandler)completionHandler;

// TODO: Make this DRYer.
-(void)purchase:(NFProduct *)product shouldHandleDownloads:(BOOL)shouldHandleDownloads completionHandler:(void (^ )(NFProduct *purchasedProduct, NFDownloader *downloader, NSError *error))completionHandler;


-(void)purchase:(NFProduct *)product shouldShowAlertViewPrompt:(BOOL)shouldShowAlertViewPrompt completionHandler:(NFStoreResponseHandler)completionHandler;

-(void)productDisplayerView:(id<NFProductDisplayerView>)productDisplayerView didSelectItem:(id)sender;

-(void)productDisplayerView:(id<NFProductDisplayerView>)productDisplayerView didSelectItem:(id)sender completionHandler:(void (^ )(NFProduct *purchasedProduct, NFDownloader *downloader, NSError *error))completionHandler;

-(int)pollFreeMemory;

-(void)makeSpaceForBannerAd:(UIView *)bannerAdView animated:(BOOL)animated;
-(void)showBannerAd;




@end
