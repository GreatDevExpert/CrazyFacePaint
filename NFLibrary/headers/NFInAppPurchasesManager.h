//
//  InAppPurchasesManager.h
//  appledoc
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

extern NSString * const kNFInAppPurchaseFailedNotification;
extern NSString * const kNFInAppPurchaseSucceededNotification;

typedef void (^ InAppPurchasesManagerCompletionHandler)(BOOL succeeded);

typedef enum {
    InAppPurchaseManagerEnvironmentRelease,
    InAppPurchaseManagerEnvironmentSandbox
}InAppPurchaseManagerEnvironment;

@class NFInAppPurchasesManager;
@protocol InAppPurchasesManagerDelegate <NSObject>
@required
- (void)inAppPurchaseFailed:(NSString *)productId;
@required
- (void)inAppPurchaseSucceeded:(NSString *)productId;
@required
- (void)inAppPurchasesRestoreFailed;
@required
- (void)inAppPurchasesRestoreSucceeded:(NSMutableArray *)restoredPurchases;
@end


/** Class for handling in-app purchases.
 
     InAppPurchaseManager *inAppPurchasesManager = [[InAppPurchasesManager alloc] init];
     inAppPurchasesManager.delegate = self;
     inAppPurchasesManager.items = @[@"product_id1", @"product_id2"];
     [inAppPurchasesManager requestProductData];
 
 Then in-app purchases can be initiated with:
 
     [inAppPurchasesManager purchase:@"product_id1"];
 

 */
@interface NFInAppPurchasesManager : NSObject

@property (nonatomic, unsafe_unretained) id <InAppPurchasesManagerDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *items;
@property InAppPurchaseManagerEnvironment environment;

- (void)requestProductData;
- (void)requestProductDataWithCompletionHandler:(InAppPurchasesManagerCompletionHandler)completionHandler;


- (void)purchase:(NSString *)productId;
- (void)restorePurchases;


-(SKProduct *)productWithProductId:(NSString *)productId;

@end