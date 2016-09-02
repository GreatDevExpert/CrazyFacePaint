//
//  NFAnalytics.h
//
//  Created by William Locke on 3/5/13.
//
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "NFAnalyticsHelper.h"


extern NSString * const kNFAnalyticsEventIdentifierInAppPurchaseBegan;
extern NSString * const kNFAnalyticsEventIdentifierInAppPurchaseCanceled;
extern NSString * const kNFAnalyticsEventIdentifierInAppPurchaseSucceeded;
extern NSString * const kNFAnalyticsGoogleAnalyticsID;
extern NSString * const kNFAnalyticsTotalBootUps;


@protocol NFAnalyticsSdkInstance <NSObject>

-(id)trackerWithTrackingId:(NSString *)trackingId;
-(void)setDebug:(BOOL)debug;
-(void)setDispatchInterval:(int)dispatchInterval;
-(void)setTrackUncaughtExceptions:(BOOL)trackUncaughtExceptions;
-(void)startSession:(NSString *)trackingId;
-(void)logEvent:(NSString *)event;
-(void)logEvent:(NSString *)event withParameters:(NSDictionary *)params;

@end


// TODO: implement better way of removing Google Analytics,
// E.g. conditional compilation.
@interface NFAnalytics : NSObject

@property BOOL disabled;

@property (nonatomic, strong) NSArray *analyticsSdkInstances;
@property (nonatomic, strong) NSDictionary *config;
@property int dispatchInterval;
@property BOOL debug;
@property BOOL trackUncaughtExceptions;
@property int lifetimePurchasesCount;


+ (NFAnalytics *)sharedInstance;

#pragma mark Configuration
-(void)configureGoogleAnalyticsWithTrackingId:(NSString *)trackingId;

#pragma mark Purchase tracking
- (void)recordPaymentTransaction:(SKPaymentTransaction *)transaction forProduct:(SKProduct *)product meta:(NSDictionary *)meta;


#pragma mark Event Tracking
- (void)trackEvent:(NSString *)eventIdentifier;
- (void)trackEvent:(NSString *)eventIdentifier withMetadata:(NSDictionary *)metadata;
- (void)trackEvent:(NSString *)eventIdentifier withValue:(NSNumber *)value;
- (void)trackEvent:(NSString *)eventIdentifier withValue:(NSNumber *)value andMetadata:(NSDictionary *)metadata;


-(void)startSession;
-(int)totalBootUps;

@end
