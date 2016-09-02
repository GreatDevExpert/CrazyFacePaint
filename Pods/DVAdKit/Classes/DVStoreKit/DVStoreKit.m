//
//  DVStoreKit.m
//
//
//  Created by ___FULLUSERNAME___ on 5/31/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "DVStoreKit.h"
//#import <StoreKit/StoreKit.h>

#import "DVAdKitPurchase.h"
#import "DVAdKitWebAPI.h"
#import "RRVerificationController.h"

#define MY_SHARED_SECRET   @"c248ff204c4d3daaf2c2fce6"

#if __has_include(<StoreKit/StoreKit.h>)
#define __STORE_KIT_FRAMEWORK_LINKED__
#endif

#ifdef __STORE_KIT_FRAMEWORK_LINKED__
#import <StoreKit/StoreKit.h>

typedef void (^ DVStoreKitRequestProductCompletionHandler)(SKProduct *product);
@interface DVStoreKit() <SKPaymentTransactionObserver, SKProductsRequestDelegate, RRVerificationControllerDelegate>  {
    DVStoreKitRequestProductCompletionHandler _requestProductCompletionHandler;
}
@end

#endif


@implementation DVStoreKit


+ (id)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}


// IMPORTANT!
// Only performs this code if StoreKit framework is found
#ifdef __STORE_KIT_FRAMEWORK_LINKED__
- (instancetype)init
{
    self = [super init];
    if (self) {
        @try {
            [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        }
        @catch (NSException *exception) {
        }
        
    }
    return self;
}


- (void)productForProductIdentifier:(NSString *)productIdentifier withCompletionHandler:(DVStoreKitRequestProductCompletionHandler)completionHandler
{
    @try {
        NSSet *productsSet = [[NSSet alloc] initWithObjects:productIdentifier, nil];
        SKProductsRequest* request = [[SKProductsRequest alloc] initWithProductIdentifiers:productsSet];
        //IMPORTANT!
        //TODO: Change to inline.
        request.delegate = self;
        [request start];
        _requestProductCompletionHandler = completionHandler;
    }
    @catch (NSException *exception) {
    }

}

#pragma mark <SKProductsRequestDelegate>
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    @try {
        if(response.products && [response.products count] > 0){
            _requestProductCompletionHandler([response.products firstObject]);
        }
    }
    @catch (NSException *exception) {
        
        
    }
    
}

- (void)recordPurchaseForProduct:(SKProduct *)product{
    
    NSLog(@"%@", [product description]);
    NSLog(@"product price: %@", product.price);
    NSLog(@"product price local: %@", [product.priceLocale localeIdentifier]);
    NSLog(@"product title: %@", product.localizedTitle);
    DVAdKitPurchase *purchase = [[DVAdKitPurchase alloc] init];
    purchase.price = product.price;
    purchase.priceLocale = product.priceLocale.localeIdentifier;
    purchase.productIdentifier = product.productIdentifier;
    purchase.localizedTitle = product.localizedTitle;
    
    @try {
        [[DVAdKitWebAPI sharedInstance] createPurchase:purchase completionHandler:^(DVAdKitPurchase *purchase, NSError *error) {
            NSLog(@"created purchase");
        }];
    }@catch (NSException *exception) {
        
    }
    
}

-(void)didPurchaseProductWithIdentifier:(NSString *)productIdentifier{
    @try {
        [self productForProductIdentifier:productIdentifier withCompletionHandler:^(SKProduct *product) {
            [self recordPurchaseForProduct:product];
        }];
    }
    @catch (NSException *exception) {
    }
}

#pragma mark -
#pragma mark <SKPaymentTransactionObserver> methods
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    [RRVerificationController sharedInstance].itcContentProviderSharedSecret = MY_SHARED_SECRET;

    
    NSLog(@"Product did receive response");
    for (SKPaymentTransaction *transaction in transactions)
    {
        SKPaymentTransaction *originalTransaction = transaction.originalTransaction;
        NSLog(@"original transaction: %@", originalTransaction);
        NSLog(@"original transaction product id: %@", originalTransaction.payment.productIdentifier);
        
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                if (!originalTransaction) {
                    
                    if ([[RRVerificationController sharedInstance] verifyPurchase:transaction
                                                                     withDelegate:nil
                                                                            error:NULL] == FALSE) {
                        // Purchase failed validation.
                        //[self failedTransaction:transaction];
                    }else{
                        [self didPurchaseProductWithIdentifier:transaction.payment.productIdentifier];
                    }
                    
                }
                break;
            case SKPaymentTransactionStateFailed:
                
                break;
            case SKPaymentTransactionStateRestored:
                
                break;
            case SKPaymentTransactionStatePurchasing:
                
                break;
            default:
                NSLog(@"Error: transationStateUnknown: %d", transaction.transactionState);
                break;
        }
    }
}

/*!
 * @brief The attempt at verification could not be completed
 *
 * This does not mean that Apple reported the transaction was invalid, but
 * rather indicates a communication failure, a server error, or the like.
 *
 * @param transaction The transaction being verified
 * @param error An NSError describing the error. May be nil if the cause of the error was unknown (or if nobody has written code to report an NSError for that failure...)
 */
- (void)verificationControllerDidFailToVerifyPurchase:(SKPaymentTransaction *)transaction error:(NSError *)error
{
    
    NSLog(@"Verification controller did fail to verify purchase");
    
    
//    NSString *message = NSLocalizedString(@"Your purchase could not be verified with Apple's servers. Please try again later.", nil);
//    if (error) {
//        message = [message stringByAppendingString:@"\n\n"];
//        message = [message stringByAppendingFormat:NSLocalizedString(@"The error was: %@.", nil), error.localizedDescription];
//    }
//    
//    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Purchase Verification Failed", nil)
//                                message:message
//                               delegate:nil
//                      cancelButtonTitle:NSLocalizedString(@"Dismiss", nil)
//                      otherButtonTitles:nil] show];
}

#endif




@end
