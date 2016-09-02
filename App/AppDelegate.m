//
//  AppDelegate.m
//  NinjafishStudiosApp
//
//  Created by William Locke on 9/17/12.
//  Copyright (c) 2014 William Locke. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "Store.h"
#import "NFData.h"
#import "Chartboost.h"
#import "NFStoreViewController.h"
#import "Sounds.h"
#import "NFProduct.h"
#import "NFStore.h"
#import "Appirater.h"
#import "NFConfig.h"
#import "NFDevice.h"
#import "NFDate.h"
#import <AdSupport/AdSupport.h>
#import "NFAnalytics.h"
#import "LocalPushNotificationHandler.h"
#import <FiksuSDK/FiksuSDK.h>
#import "Flurry.h"
#import "NFChartboost.h"
#import "NFAdMob.h"
#import "AdColony.h"
#import "NFAnimatedImageView.h"
#import <VungleSDK/VungleSDK.h>

#if __has_include("DVAdKit.h")
#import "DVAdKit.h"
#import "DVAdKitMoreApps.h"
#endif

@interface AppDelegate()<AdColonyDelegate>{
    NFConfig *_config;
    
    NSDate *_enteredForegroundAt;
    NSDate *_didFinishLaunchingAt;
}

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _config = [NFConfig instanceFromDictionary:[NFData objectFromFile:@"Config.json"]];
    
    // Chartboost used for interstitials and more games screen.
    Chartboost *cb = [Chartboost sharedChartboost];
    cb.appId = _config.chartboostAppId;
    cb.appSignature = _config.chartboostAppSignature;
    
    
    [NFLocalPushNotification setLocalPushNotifications:[NFLocalPushNotification arrayOfInstancesFromArrayOfDictionaries:[NFData objectFromFile:_config.jsonLocalPushNotifications]]];
    
    
    // Used to offer user option of rating the app after a certain number of uses etc.
    [Appirater setAppId:_config.appleId];
    [Appirater setDaysUntilPrompt:2];
    [Appirater setUsesUntilPrompt:0];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];
    //    [Appirater setDebug:YES];
    [Appirater appLaunched:YES];
    
    
    
    NSMutableArray *products = [[NSMutableArray alloc] init];
    for(NSDictionary *d in [NFData objectFromFile:_config.jsonProducts]){
        [products addObject:[NFProduct instanceFromDictionary:d]];
    }
    
    
    NFViewController *sharedViewController = [NFViewController sharedInstance];
    /*
     // Example of setting certain sound names for NFViewController
     sharedViewController.backButtonSoundName = kSoundNameBackChime;
     sharedViewController.nextButtonSoundName = kSoundNameSelectChime;
     */
    
    [NFDownloader configureWithDomainName:_config.cdnDomainName];
    [NFViewController configureWithDownloadsFileName:_config.jsonDownloadConfig];
    
    
    // Example of how to remove HD downloads for certain device types
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [NFDownloader setAllowHighResDownloads:NO];
    }
    
    MasterViewController *masterViewController = [[MasterViewController alloc] initWithNib];
    masterViewController.imagesDictionary = [NFData objectFromFile:_config.jsonImages];
    masterViewController.store = [Store sharedInstance];
    masterViewController.sounds = [Sounds sharedInstance];
    masterViewController.sounds.settings = [NFSettings sharedInstance];
    
    // This was hanging app load on launch screen for a few seconds, so loading asynchronously.
    dispatch_async(dispatch_get_main_queue(), ^{
        // Creates the NFStore object and assigns it to masterViewController.store
        // This .store object will be passed along between view controllers so any
        // subclass of NFViewController will be able to access the store via .store.
        masterViewController.store = [[Store alloc] initWithProducts:products completionHandler:^(BOOL success){
            for(NFProduct *p in [Store sharedInstance].myPurchases){
                NSLog(@"%@", [p dictionaryRepresentation]);
            }
        }];
        
        [NFAdDisplayer sharedInstance].store = (id<NFAdDisplayerStore>)masterViewController.store;

        if([NFAdDisplayer sharedInstance].userTypePurchases != NFAdDisplayerUserTypePurchasesNone){
//            [masterViewController.store disableWatchToUnlockProducts];
        }
        
#ifdef DEBUG
        // Set debug environment
        masterViewController.store.environment = NFStoreEnvironmentSandbox;
#endif
        
    });
    
    
    [LocalPushNotificationHandler sharedInstance].masterViewController = masterViewController;

    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [NFAdMob sharedInstance].bannerAdUnitId = _config.admob320x50PhoneBannerAdUnitId;
    }else{
        [NFAdMob sharedInstance].bannerAdUnitId = _config.admob728x90TabletBannerAdUnitId;
    }
    
    //    [[NativeXSDK sharedInstance] allow
    [NFAdDisplayer sharedInstance].defaultVideoAdZoneId = _config.adcolonyZoneId;
    [NFAdDisplayer sharedInstance].blockedBannerAdViewControllerClasses = @[[MasterViewController class]];
    [NFAdDisplayer sharedInstance].blockedInterstitialControllerClasses = @[];
    [NFAdDisplayer sharedInstance].settings = (id<NFAdDisplayerSettings>)[NFSettings sharedInstance];
    [NFAdDisplayer sharedInstance].bannerAdSdkInstances = @[[NFAdMob sharedInstance]];
    
#if __has_include("DVAdKit.h")
    [NFAdDisplayer sharedInstance].adSdkInstances = @[[DVAdKit sharedInstance], [NFChartboost sharedInstance]];
    [NFAdDisplayer sharedInstance].moreAppsAdSdkInstances = @[ [DVAdKitMoreApps sharedInstance], [Chartboost sharedChartboost]];
    if([[UIDevice currentDevice] systemVersion].floatValue >= 6.0){
        [[DVAdKitMoreApps sharedInstance] preloadMoreApps];
    }
#else
    [NFAdDisplayer sharedInstance].adSdkInstances = @[[NFChartboost sharedInstance]];
    [NFAdDisplayer sharedInstance].moreAppsAdSdkInstances = @[[Chartboost sharedChartboost]];
#endif

    

    
#ifdef DEBUG
    //    [NFAdDisplayer sharedInstance].bannerAdSdkInstances = @[];
//    [NFAdDisplayer sharedInstance].adSdkInstances = nil;
#endif
    
    [FiksuTrackingManager applicationDidFinishLaunching:launchOptions];

    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    self.window.rootViewController = self.navigationController;
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    [self.window makeKeyAndVisible];
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    //note: iOS only allows one crash reporting tool per app; if using another, set to: NO
    [Flurry setCrashReportingEnabled:YES];
    
    // Replace YOUR_API_KEY with the api key in the downloaded package
    [Flurry startSession:_config.flurryAppKey];
    
    [NFAdDisplayer sharedInstance].minimimTimeInSecondsBetweenInterstitials = 5;
    
    [NFImage sharedInstance].useLowResImages = YES;
    
    [FiksuTrackingManager applicationDidFinishLaunching:launchOptions];
    
    if(![NFData objectFromFile:@"LocalPushNotifications.json"]){
        NSAssert(NO, @"LocalPushNotifications.json formatted incorrectly");
    }
    
    _didFinishLaunchingAt = [NSDate date];
    
    [NFAnimatedImageView setAnimationType:NFAnimatedImageViewAnimationTypeSelectorBased];
    
    
    
    // VIDEO ADS
    // Configure each mediated video ad provider.
    // This app uses AdColony and Vungle and uses AdMob for mediation
    // NB: we need to import AdMob adapters for each video ad provider we are
    // using. Usually these take the form AdMobMediationAdapter<AdSdkName>
    // For this app we need: AdMobMediationAdapterVungle, and AdMobMediationAdapterAdColony
    // IMPORTANT: Vungle adapter (AdMobMediationAdapterVungle) has trouble when importing as Cocoapod, therefore must be
    // dragged directly into project
    // IMPORTANT2: At this time Google AdMob Podspec doesn't include custom adapter headers.
    // To fix this: cd ~/.cocoapods/repos/; git clone git clone https://github.com/ninjafishstudios/ninjafish-spec-repo;
    // Then update pods again.
    
    // Configure AdColony video ads
    [AdColony configureWithAppID:_config.adcolonyAppId
                         zoneIDs:@[_config.adcolonyZoneId]
                        delegate:(id<AdColonyDelegate>)[NFAdDisplayer sharedInstance]
                         logging:YES];
    [NFAdDisplayer sharedInstance].defaultVideoAdZoneId = _config.adcolonyZoneId;
    
    // Configure Vungle video ads
    NSString* appID = _config.vungleAppId;
    
    // updated ones
    VungleSDK* sdk = [VungleSDK sharedSDK];
    [sdk startWithAppId:appID];
    
    // Configure AdMob video ads (the mediation)
    [NFAdMob sharedInstance].videoAdUnitId = _config.admobVideoAdUnitId;
    
    // Tell NFAdDisplayer which SDK to use call video ads through (in this case we are using
    // our own wrapper for AdMob)
    [NFAdDisplayer sharedInstance].videoAdSdkInstances = @[[NFAdMob sharedInstance]];
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[LocalPushNotificationHandler sharedInstance] scheduleNotifications];
    
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [Appirater appEnteredForeground:YES];
    _enteredForegroundAt = [NSDate date];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Only trigger code below if application has just entered foreground
    // or it has just loaded
    if(!([[NSDate date] timeIntervalSinceDate:_didFinishLaunchingAt] < 2.0 || [[NSDate date] timeIntervalSinceDate:_enteredForegroundAt] < 2.0)){
        return;
    }
    
    [[NFAnalytics sharedInstance] startSession];
    
#if __has_include("DVAdKit.h")
    [[DVAdKit sharedInstance] start];
    [[NFAdDisplayer sharedInstance] showInterstitial:@"" usingSdkInstanceWithClassName:@"DVAdKit"];
#endif
    
    if ([[[UIApplication sharedApplication] scheduledLocalNotifications] count] > 0){
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    Chartboost *cb = [Chartboost sharedChartboost];
    
    // Notify the beginning of a user session
    [cb startSession];
    
    
    float purchasesBought = [[Store sharedInstance] totalCostOfAllPurchasesBought];
    purchasesBought = purchasesBought + [NFAnalytics sharedInstance].lifetimePurchasesCount;
    if([[Store sharedInstance] allProductsUnlocked]){
        [NFAdDisplayer sharedInstance].userTypePurchases = NFAdDisplayerUserTypePurchasesAll;
    } else if(purchasesBought > 9) {
        [NFAdDisplayer sharedInstance].userTypePurchases = NFAdDisplayerUserTypePurchasesMany;
    } else if(purchasesBought > 0) {
        [NFAdDisplayer sharedInstance].userTypePurchases = NFAdDisplayerUserTypePurchasesSome;
    } else{
        [NFAdDisplayer sharedInstance].userTypePurchases = NFAdDisplayerUserTypePurchasesNone;
    }
    
    if ([NFAnalytics sharedInstance].totalBootUps > 10) {
        [NFAdDisplayer sharedInstance].userTypeSessions = NFAdDisplayerUserTypeSessionsMany;
    } else if ([NFAnalytics sharedInstance].totalBootUps > 2) {
        [NFAdDisplayer sharedInstance].userTypeSessions = NFAdDisplayerUserTypeSessionsSome;
    } else {
        [NFAdDisplayer sharedInstance].userTypeSessions = NFAdDisplayerUserTypeSessionsNone;
        NSLog(@"a");
    }
    
    // Set the default min time between interstitials.
    [NFAdDisplayer sharedInstance].minimimTimeInSecondsBetweenInterstitials = 8;

    // If user hasn't purchased
    if([NFAdDisplayer sharedInstance].userTypePurchases == NFAdDisplayerUserTypePurchasesNone){
        if([NFAdDisplayer sharedInstance].userTypeSessions == NFAdDisplayerUserTypeSessionsMany){
            [NFAdDisplayer sharedInstance].minimimTimeInSecondsBetweenInterstitials = 4;
        }else if([NFAdDisplayer sharedInstance].userTypeSessions == NFAdDisplayerUserTypeSessionsSome){
            [NFAdDisplayer sharedInstance].minimimTimeInSecondsBetweenInterstitials = 5;
        }
        // TURN ON BANNER ADS FOR NON-PAYING USERS
        [NFAdDisplayer sharedInstance].bannerAdSdkInstances = @[[NFAdMob sharedInstance]];
    } else { // If user has made some (dollar amount) purchase
        // TURN OFF BANNER ADS FOR PAYING USERS
        [NFAdDisplayer sharedInstance].bannerAdSdkInstances = @[];
    }
    
    MasterViewController *masterViewController = (MasterViewController *)self.navigationController.topViewController;
    if ([masterViewController isKindOfClass:[MasterViewController class]]) {
        [masterViewController viewWillAppear:NO];
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.

}

// @todo Clean up this function
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    return YES;
}


 
void uncaughtExceptionHandler(NSException *exception) {
    
#ifdef DEBUG
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
#endif
}


#pragma mark Delegate
#pragma mark -- Interface Orientation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if(toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown || toInterfaceOrientation == UIInterfaceOrientationPortrait){
        return YES;
    }
    return NO;
}


#pragma mark Local Notifications
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    if ( application.applicationState == UIApplicationStateActive ){
        NSString *title = @"Surprise!";
        if (![NFLocalPushNotification notificationsEnabledOnDevice]) {
            [NFLocalPushNotification promptUserToTurnOnNotificationsInSettingsWithMessage:@"In order to receive gifts and gift alerts notifications must be enabled" andTitle:title];
            return;
        }
        
        [[LocalPushNotificationHandler sharedInstance] unlockProductsForLocalNotification:notification];
        NFAlertView *alertView = [[NFAlertView alloc] initWithTitle:title message:notification.alertBody cancelButtonTitle:@"OK" otherButtonTitles:@"Open", nil];
        [alertView show:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if ([alertView cancelButtonIndex] == buttonIndex) {
                // Unlock products but don't do anything else.
            }else{
                [[LocalPushNotificationHandler sharedInstance] didReceiveLocalNotification:notification];
            }
        }];
        
        NSString *eventString = [@"" stringByAppendingFormat:@"Did Receive Local Notification Whie App Active: %@", [notification alertBody]];
        [Flurry logEvent:eventString];
        
    }else{
        [[LocalPushNotificationHandler sharedInstance] didReceiveLocalNotification:notification];
        
        NSString *eventString = [@"" stringByAppendingFormat:@"Did Receive Local Notification: %@", [notification alertBody]];
        [Flurry logEvent:eventString];
    }
}



@end
