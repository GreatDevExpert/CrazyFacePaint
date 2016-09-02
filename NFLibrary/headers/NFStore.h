//
//  NFStore.h
//  appledoc
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
@class AppDelegate;
@class NFInAppPurchasesManager;
#import "NFProduct.h"
#import "NFData.h"                  // If possible, use regular NSKeyedArchiver/NSKeyedUnarchiver instead.
#ifndef ANDROID
    #import "NFDownloader.h"            // Should remove or replace with something inside NFStore module.
#endif

#import "NFCategories.h"            // Should remove or replace with something inside NFStore module.

@protocol NFStoreDownloader <NSObject>
-(NSString *)imageSectionKeyForSection:(NSString *)section;

-(NSMutableArray *)downloadsForItems:(NSMutableDictionary *)items;
-(BOOL)imagesForSectionAreDownloaded:(NSString *)section;

@end


@protocol NFStoreParentalGateProtocol <NSObject>

@required
-(void)show:(void (^ )(BOOL verified))completionHandler;

@end

typedef void (^ NFStoreResponseHandler)(BOOL success);

typedef enum {
    NFStoreEnvironmentRelease,
    NFStoreEnvironmentSandbox
}NFStoreEnvironment;

extern NSString * const kNFPurchaseFailedNotification;
extern NSString * const kNFPurchaseSucceededNotification;
extern NSString * const kNFStoreMyPurchasesKey;
extern NSString * const kNFStoreImagesKeyPathsKey;
extern NSString * const kNFStoreDownloadOnPurchaseKey;

extern int kNFStoreUnlockedIndex;

/** Class for handling all manner of things related to implementing in-app purchases.
 
 It can be convenient to subclass this class in order to store app-specific information
 such as static product IDs as string constants, to avoid hard-coded string variables around.
 
     // Product Ids such as .identifierUnlockPumpkinFeature constants may be listed in NFStore class 'Store'.
     Store *store = (Store *)[[NFStore alloc] initWithProducts:productsArray];
     [store purchase:.identifierUnlockPumpkinFeature responseHandler:^(BOOL success) {
         if(success){
            // do success action
         }else{
            // do fail action
         }
     }];
    Store should be a gateway to backend that contains all product info. The store is initialized according to a particular user, such that user specific information can be requested through this class. 
        
        if([Store productWithIdentifier:.identifierUnlockPumpkinFeature].isBought){
            // 
        }
  Dependencies:
    - NFLibrary/NFData
    - NFLibrary/NFCategories
    - NFLibrary/NFDownloader
 
 */
@interface NFStore : NSObject

@property (strong, nonatomic) NSArray *products;
@property (strong, nonatomic) NSMutableArray *myPurchases;
@property (strong, nonatomic) NSMutableArray *coinPackages;
@property (strong, nonatomic) NSMutableArray *restoredPurchases;
@property (strong, nonatomic) NFInAppPurchasesManager *inAppPurchasesManager;
@property (getter = environment, setter = setEnvironment:) NFStoreEnvironment environment;
@property (nonatomic, strong) id<NFStoreParentalGateProtocol> parentalGate;
@property BOOL shouldParentalGatePurchases;

@property (strong, nonatomic) id<NFStoreDownloader> storeDownloader;

+(NFStore *)sharedInstanceWithProducts:(NSArray *)products;
+(NFStore *)sharedInstance;

- (id)initWithProducts:(NSArray *)products;


/** @warning *Important:* Initialized object should not be a local variable or a variable that
 * might be dereferenced before the completionHandler has time to finish.
 */
// TODO: add a timeout on completionHandler.
- (id)initWithProducts:(NSArray *)products completionHandler:(NFStoreResponseHandler)completionHandler;


-(void)purchase:(NSString *)productId responseHandler:(NFStoreResponseHandler)responseHandler __attribute__ ((deprecated));

-(void)purchase:(NFProduct *)product completionHandler:(NFStoreResponseHandler)completionHandler;

-(void)restorePurchases:(NFStoreResponseHandler)responseHandler;


#pragma mark Data Functions
-(void)insertProductIntoMyPurchases:(NFProduct *)product;
-(void)unlockAllProducts;
-(void)unlockProduct:(NFProduct *)product;
-(NFProduct *)productWithProductId:(NSString *)productId;
-(NFProduct *)unlockEverythingProduct;
-(NFProduct *)productPackThatContainsProduct:(NFProduct *)product;
-(BOOL)allProductsUnlocked;

-(SKProduct *)skproductWithProductId:(NSString *)productId;


#pragma mark Download functions
// TODO: update these to remove any reference to NFDownloader.
// Move functions to NFProduct. 
-(NSMutableArray *)downloadItemsForProduct:(NSString *)productId fromContentDictionary:(NSMutableDictionary *)contentDictionary __attribute__ ((deprecated));

-(NSMutableArray *)downloadKeysForProduct:(NSString *)productId  __attribute__ ((deprecated));
-(int)lockedIndexForKeyPath:(NSString *)keyPath  __attribute__ ((deprecated));
-(NSString *)productIdForKeyPath:(NSString *)keyPath;
-(BOOL)shouldDownloadImagesUponPurchase:(NSString *)productId;

// TODO: update these to be attributes of NFProduct.
-(BOOL)productHasAlreadyBeenBought:(NSString *)productId;
-(int)lockedIndexForProduct:(NSString *)productId;
-(int)downloadedIndexForProduct:(NSString *)productId;
-(BOOL)productDownloaded:(NFProduct *)product;
-(NSString *)productNameForProductId:(NSString *)productId;

-(int)downloadingIndexForProduct:(NSString *)productId;

-(void)assignDownloadingPropertiesForPurchasedProduct:(NFProduct *)product downloading:(BOOL)downloading;

-(float)totalCostOfAllPurchasesBought;

-(void)disableWatchToUnlockProducts;
-(void)disableWatchToUnlockProductsThatHaveDirectInAppPurchaseOption;


@end