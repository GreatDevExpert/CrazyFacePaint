//
//  DVEasterEggs.m
//  HalloweenDressUp
//
//  Created by William Locke on 10/1/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "DVInteractiveAdManager.h"
#import "DVInteractiveAd.h"
#import <objc/runtime.h>
#import "DVStoreProductHandler.h"

@interface DVInteractiveAdManager(){

}

@end

@implementation DVInteractiveAdManager


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.storeProductHandler = [[DVStoreProductHandler alloc] init];
    }
    return self;
}

+ (DVInteractiveAdManager *)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
        
        // Listen to this to remove interactives when screens change.
        // [[NSNotificationCenter defaultCenter] addObserver:_sharedObject selector:@selector(navigationControllerDidShowViewController:) name:@"UINavigationControllerDidShowViewControllerNotification" object:nil];
    });
    
    // returns the same object each time
    return _sharedObject;
}

-(void)navigationControllerDidShowViewController:(NSNotification*)notification {
    UIViewController *rootViewController = [self applicationsCurrentRootViewController];
    
    NSMutableArray *interactiveAdsToRemove = [[NSMutableArray alloc] init];
    for(DVInteractiveAd *interactiveAd in self.interactiveAds){
        if(interactiveAd.views && [interactiveAd.views count] > 0){
            UIView *view = [interactiveAd.views firstObject];
            if(view.superview && view.superview != rootViewController.view){
                [interactiveAdsToRemove addObject:interactiveAd];
            }
        }
    }
    for(DVInteractiveAd *interactiveAd in interactiveAdsToRemove){
        [interactiveAd dismiss];
    }
}


#pragma mark Retrieve Application's UIElements
-(UIViewController *)applicationsCurrentRootViewController{
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while ([rootViewController isKindOfClass:[UITabBarController class]] || [rootViewController isKindOfClass:[UINavigationController class]]) {
        if ([rootViewController isKindOfClass:[UITabBarController class]]){
            rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
        }else if ([rootViewController isKindOfClass:[UINavigationController class]]){
            rootViewController = ((UINavigationController *)rootViewController).topViewController;
        }
    }
    return rootViewController;
}

-(void)clearEggs{
    for(DVInteractiveAd *easterEgg in self.interactiveAds){
        [easterEgg dismiss];
    }
}



-(void)displayEmbeddedInteractive:(NSArray *)interactiveAdViews{
    [self displayEmbeddedInteractive:interactiveAdViews withCompletionHandler:nil];
    
}

-(void)displayEmbeddedInteractive:(NSArray *)interactiveAdViews withCompletionHandler:(void (^ )(DVInteractiveAd *interactiveAd))interactiveAdLoaded{
    [self displayEmbeddedInteractive:interactiveAdViews withLabel:nil completionHandler:interactiveAdLoaded];
}

-(void)displayEmbeddedInteractive:(NSArray *)interactiveAdViews withLabel:(NSString *)label completionHandler:(void (^ )(DVInteractiveAd *interactiveAd))interactiveAdLoaded{
    
    // UIViewController *viewController = [self applicationsCurrentRootViewController];
    // [self clearEggs];
    @try {
        if (!self.interactiveAds) {
            self.interactiveAds = [NSMutableArray new];
        }
        
        DVInteractiveAd *newInteractiveAd;
        for(DVInteractiveAd *interactiveAd in self.interactiveAds){
            if([interactiveAd.views count] > 0 && [interactiveAdViews count] > 0){
                if([interactiveAdViews firstObject] == [interactiveAd.views firstObject]){
                    newInteractiveAd = interactiveAd;
                }
            }
        }
        if(!newInteractiveAd){
            newInteractiveAd = [[DVInteractiveAd alloc] initWithViews:interactiveAdViews];
            [self.interactiveAds addObject:newInteractiveAd];
        }
        
        for(UIView *tmpView in newInteractiveAd.views){
            tmpView.hidden = YES;
            if(!tmpView.superview){
//                [viewController.view addSubview:tmpView];
            }
        }
        
        NSMutableDictionary *options = [NSMutableDictionary new];
        if (label) {
            [options setValue:@{@"label":label} forKey:@"ad"];
        }
        
        [newInteractiveAd displayInteractiveAdWithOptions:options withCompletionHandler:interactiveAdLoaded];
        
    }@catch (NSException *exception){
        NSLog(@"DV ERROR: %@", exception);
    }
    
}



@end
