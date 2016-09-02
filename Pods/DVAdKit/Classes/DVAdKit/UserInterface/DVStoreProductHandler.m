//
//  DVStoreProductViewController.m
//  Pods
//
//  Created by William Locke on 10/3/14.
//
//

#import "DVStoreProductHandler.h"

typedef void (^DVStoreProductHandlerCompletionHandler)(BOOL success);

@interface DVStoreProductHandler (){
    DVStoreProductHandlerCompletionHandler _storeProductViewControllerClosed;
    
}

@end

@implementation DVStoreProductHandler


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




#pragma mark ===== APP STORE =====
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
-(UIView *)newActivityIndicatorViewForViewController:(UIViewController *)viewController{
    UIView *view = viewController.view;
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    //    activityIndicatorView.frame = [NFLayout deviceFrame:CGRectMake(140, 200, 40, 40)];
    activityIndicatorView.frame = CGRectMake(view.frame.size.width * 0.4, view.frame.size.height * 0.4, view.frame.size.width * 0.2, view.frame.size.height * 0.2);
    
    [activityIndicatorView startAnimating];
    return activityIndicatorView;
}



-(void)loadProductDataForAppStoreLink:(NSString *)appStoreLink completionHandler:(void (^ )(BOOL success))completionHandler{
    if(!appStoreLink){
        return;
    }
    self.loaded = NO;
    self.appStoreLink = appStoreLink;
    NSURL *url = [NSURL URLWithString:appStoreLink];
    if (!self.storeViewController) {
        self.storeViewController = [[SKStoreProductViewController alloc] init];        
    }
    
    NSNumber *iTunesItemIdentifier = [self itunesItemIdentifierFromUrlString:[url absoluteString]];
    if([iTunesItemIdentifier intValue] < 0){
        NSLog(@"WARNING: itunes item identifier not found");
        completionHandler(NO);
        return;
    }
    
    
    [self.storeViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:iTunesItemIdentifier, @"at": @"11lLxv" } completionBlock:^(BOOL result, NSError *error){
        
        if(self.appStoreLink && [appStoreLink isEqualToString:self.appStoreLink]){
            if(result){
                self.loaded = YES;
            }else{
                self.loaded = NO;
            }
        }
        if(result){
            if (completionHandler) {
                completionHandler(YES);
            }
        }else{
            if(completionHandler){
                completionHandler(NO);
            }
        }
    }];
}


#pragma mark --Show Interstitial Inside App
-(BOOL)appStoreLinkLoaded:(NSString *)appStoreLink{
    
    if(self.appStoreLink && [self.appStoreLink isEqualToString:appStoreLink] && self.loaded){
        return YES;
    }
    return NO;
}

-(void)openInRootViewController:(UIViewController *)rootViewController completionHandler:(void (^ )(BOOL success))completionHandler{
    _storeProductViewControllerClosed = nil;
    
    if(!self.storeViewController){
        NSLog(@"WARNING: storeViewController is nil");
        completionHandler(NO);
        return;
    }
    
    _storeProductViewControllerClosed = completionHandler;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            self.storeViewController.delegate = (id<SKStoreProductViewControllerDelegate>)self;
            [rootViewController presentViewController:self.storeViewController animated:YES completion:nil];
        }
        @catch (NSException *exception) {
        }
    });
    
}

#pragma mark Data
-(NSNumber *)itunesItemIdentifierFromUrlString:(NSString *)urlString{
    NSNumber *iTunesItemIdentifier = nil;
    if(urlString){
        NSRange appIdRange = [urlString rangeOfString:@"/id"];
        NSRange questionMarkRange = [urlString rangeOfString:@"?"];
        
        if(appIdRange.location != NSNotFound && questionMarkRange.location != NSNotFound){
            NSString *substring = [[urlString substringToIndex:questionMarkRange.location] substringFromIndex:appIdRange.location + 3];
            if([substring intValue] > 0){
                iTunesItemIdentifier = [NSNumber numberWithInt:[substring intValue]];
            }
        }
    }
    return iTunesItemIdentifier;
}

#pragma mark <SKStoreProductViewControllerDelegate>
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    
    [viewController dismissViewControllerAnimated:YES completion:nil];
    self.loaded = NO;
    self.storeViewController = nil;
    
    if (_storeProductViewControllerClosed) {
        _storeProductViewControllerClosed(YES);
        _storeProductViewControllerClosed = nil;
    }
    
}

@end
