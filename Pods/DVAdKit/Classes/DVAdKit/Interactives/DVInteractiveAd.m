//
//  DVInteractiveAd.m
//
//  Created by William Locke on 10/2/14.
//

#import "DVInteractiveAd.h"
#import "DVAdKitAd.h"
#import "DVAdKitApp.h"
#import "DVAdKitWebAPI.h"
#import "DVAdKitAdDisplaySettings.h"
#import "DVStoreProductHandler.h"
#import "DVInteractiveAdManager.h"

@interface DVInteractiveAd(){
    NSDate *_openedAppStoreAt;
}

@end

@implementation DVInteractiveAd


- (instancetype)initWithViews:(NSArray *)views
{
    self = [super init];
    if (self) {
        _views = views;
        _storeProductHandler = [[DVStoreProductHandler alloc] init];
    }
    return self;
}


-(void)shouldShow:(void (^ )(BOOL shouldShowInteractiveAd))completionHandler{
    @try {
        NSString *appStoreLink = @"https://itunes.apple.com/us/app/kids-face-paint/id708947444?ls=1&mt=8";
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:appStoreLink]];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 1;
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            NSLog(@"error: %@", connectionError);
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            int code = 0;
            if([httpResponse respondsToSelector:@selector(statusCode)]){
                code = [httpResponse statusCode];
            }
            
            if(response && !connectionError && (code >= 200 && code < 300) ){
                if (completionHandler) {
                    completionHandler(YES);
                }
            }else{
                if (completionHandler) {
                    completionHandler(NO);
                }
            }
        }];
    }
    @catch (NSException *exception) {
        NSLog(@"DV ERROR: %@", exception );
    }
    
}


-(void)displayInteractiveAdWithOptions:(NSMutableDictionary *)options withCompletionHandler:(void (^ )(DVInteractiveAd *interactiveAd))interactiveAdLoaded{

    [self setViewHidden:YES];
    
    
    
    [self createImpressionWithOptions:options completionHandler:^(DVAdKitImpression *impression, NSMutableArray *adImages) {

        @try {
            if(impression && adImages && [adImages count] > 0){
                self.impression = impression;
                self.adImages = adImages;
                
                [self.storeProductHandler loadProductDataForAppStoreLink:self.impression.ad.app.appStoreLink completionHandler:^(BOOL success) {
                    
                }];
                
                [self layoutViews];
                
                if (interactiveAdLoaded) {
                    interactiveAdLoaded(self);
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"DV ERROR: %@", exception );
        }
    }];
    
}

-(void)layoutViews{
    
    
    
    @try {
        int i=-1;
        for (UIView *view in self.views){
            i++;
            UIImage *adImage = nil;
            if(i < [self.adImages count]){
                adImage = [self.adImages objectAtIndex:i];
            }
            if(!adImage){
                continue;
            }
            if ([view isKindOfClass:[UIImageView class]]) {
                [((UIImageView *)view) setImage:adImage];
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
                [button addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:button];
                view.userInteractionEnabled = YES;
            }else if([view isKindOfClass:[UIButton class]]) {
                [((UIButton *)view) setImage:adImage forState:UIControlStateNormal];
                [((UIButton *)view) addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
                
            }else{
                if (view.subviews && [view.subviews count] > 0) {
                    UIImageView *imageView = [view.subviews objectAtIndex:0];
                    if([imageView isKindOfClass:[UIImageView class]]){
                        imageView.image = adImage;
                    }
                }
            }
        }
        
        [self setViewHidden:NO];
    }
    @catch (NSException *exception) {
        NSLog(@"DV ERROR: %@", exception );
    }
    
}

-(void)setViewHidden:(BOOL)hidden{
    for(UIView *view in self.views){
        view.hidden = hidden;
    }
}

// Make this only function
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

-(void)open{
    @try {
        
        [self recordClick];
        
        if(!self.impression.ad.app.appStoreLink){
            [self dismiss];
            return;
        }
        
        if (_openedAppStoreAt && [[NSDate date] timeIntervalSinceDate:_openedAppStoreAt] < 1.0) {
            NSLog(@"ERROR: Already opened app store. ");
            return;
        }
        
        _openedAppStoreAt = [NSDate date];
        
        if (self.impression.ad.app.urlScheme) {
            NSURL *localAppUrl = [NSURL URLWithString:self.impression.ad.app.urlScheme];
            if(localAppUrl && [[UIApplication sharedApplication] canOpenURL:localAppUrl]){
                [[UIApplication sharedApplication] openURL:localAppUrl];
                return;
            }
        }
        
        
        NSURL *appStoreUrl = [NSURL URLWithString:self.impression.ad.app.appStoreLink];
        
        UIViewController *rootViewController = [self applicationsCurrentRootViewController];

        // Note! Opening URL in app store inside app happens inside the conditional!
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && self.impression.adDisplaySettings.shouldPresentAppStoreInsideApp && [rootViewController.navigationController respondsToSelector:@selector(presentModalViewController:animated:)]){
            
            if([self.storeProductHandler appStoreLinkLoaded:self.impression.ad.app.appStoreLink]){
                [self.storeProductHandler openInRootViewController:rootViewController completionHandler:^(BOOL success) {
                    if (self.views.firstObject && ((UIView *)self.views.firstObject).superview ) {
                        [self.storeProductHandler loadProductDataForAppStoreLink:self.impression.ad.app.appStoreLink completionHandler:nil];
                    }
                }];
            }else{
                [[UIApplication sharedApplication] openURL:appStoreUrl];
            }
            
        }else{
            [[UIApplication sharedApplication] openURL:appStoreUrl];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"DV ERROR: %@", exception );
    }

    //[self dismiss];
}


-(void)recordClick{
    if(self.clicked){
        return;
    }
    
    if (self.impression) {
        self.clicked = YES;
        [[DVAdKitWebAPI sharedInstance] createClick:self.impression];
    }
}


-(void)createImpressionWithOptions:(NSMutableDictionary *)options completionHandler:(void (^ )(DVAdKitImpression *impression, NSMutableArray *adImages ) )completionHandler{
    
    [self shouldShow:^(BOOL shouldShow) {

        if (!shouldShow) {
            completionHandler(nil, nil);
        }
        
        NSMutableDictionary *supplementedOptions = [NSMutableDictionary new];
        if (options) {
            [supplementedOptions addEntriesFromDictionary:options];
        }
        [supplementedOptions setValue:@{@"name":@"interactives"} forKey:@"publishing_campaign_type"];
        [supplementedOptions setValue:@{@"name":@"interactives"} forKey:@"ad_type"];
        [supplementedOptions setValue:@(NO) forKey:kDVAdKitParameterOptionShouldBlockIfAdsNotFound];
        [supplementedOptions setValue:@(YES) forKey:kDVAdKitParameterOptionOverrideLocalBlocking];
        [supplementedOptions setValue:@(NO) forKey:kDVAdKitParameterOptionShouldFilter];
        
        if (self.label && [self.label isKindOfClass:[NSString class]]) {
            [supplementedOptions setValue:self.label forKey:kDVAdKitParameterOptionLocationInAppLabel];
        }
        
        
        @try {
            [[DVAdKitWebAPI sharedInstance] createImpressionWithOptions:supplementedOptions completionHandler:^(DVAdKitImpression *impression, NSError *error) {
                
                @try {
                    if(impression){
                        NSMutableArray *adImages = [[NSMutableArray alloc] init];
                        int numberOfAdImages = 0;
                        DVAdKitDevice *device = [DVAdKitWebAPI sharedInstance].device;
                        if(!device){
                            if(impression.device){
                                device = impression.device;
                            }else{
                                device = [[DVAdKitDevice alloc] init];
                            }
                        }
                        // todo: device.model is sometimes set to null.
                        // make sure it is set.
                        if (!device.model) {
                            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                                device.model = @"ipad";
                            }else{
                                device.model = @"iphone";
                            }
                        }

                        NSMutableArray *selectedCreatives = [NSMutableArray new];
                        for(DVAdKitCreative *creative in impression.ad.creatives){
                            if([[DVAdKitWebAPI sharedInstance] deviceModel:device.model isInTheSameDeviceModelGroupAsDeviceModel:creative.model]){
                                numberOfAdImages++;
                                [selectedCreatives addObject:creative];
                            }
                        }
                        
                        NSLog(@"Selected creatives for device model: %@", device.model);
                        for(DVAdKitCreative *creative in selectedCreatives){
                            NSLog(@"id: %@, model: %@", creative.identifier, creative.model);
                        }
                        
                        int i = -1;
                        for(DVAdKitCreative *creative in impression.ad.creatives){
                            //DVAdKitDevice *device = [DVAdKitWebAPI sharedInstance].device;
                            
                            
                            
                            if([[DVAdKitWebAPI sharedInstance] deviceModel:device.model isInTheSameDeviceModelGroupAsDeviceModel:creative.model]){
                                i++;
                                [adImages addObject:[UIImage new]];
                                [DVImageDownloader downloadImage:creative.adImageLink completionHandler:^(UIImage *image) {
                                    if (image) {
                                        [adImages replaceObjectAtIndex:i withObject:image];
                                        int numberOfFilledAdImages = 0;
                                        for(UIImage *tmpAdImage in adImages){
                                            if(tmpAdImage.size.width > 0){
                                                numberOfFilledAdImages++;
                                            }
                                        }
                                        if([adImages count] > 0 && numberOfFilledAdImages == numberOfAdImages){
                                            completionHandler(impression, adImages);
                                        }
                                    }
                                }];
                            }
                        }
                    }
                    
                }@catch (NSException *exception) {
                    NSLog(@"DV ERROR: %@", exception );
                }
            
            }];
            
        }@catch (NSException *exception) {
            NSLog(@"DV ERROR: %@", exception );
        }

                
    
    }];
}


// Add animation option
-(void)dismiss{
    for(UIView *view in self.views){
        [view removeFromSuperview];
    }
    
    [[[DVInteractiveAdManager sharedInstance] interactiveAds] removeObject:self];
}


#pragma mark ===== ACTIONS ======
-(void)popin{
    
    for(UIView *view in self.views){
        if(!view.superview){
            continue;
        }
        CGRect onScreenFrame = view.frame;
        CGRect offscreenFrame;
        if(view.frame.origin.x <= 0){
            offscreenFrame = CGRectMake(-view.frame.size.width, onScreenFrame.origin.y, onScreenFrame.size.width, onScreenFrame.size.height);
            
        }else if(view.frame.origin.x >= view.superview.frame.size.width * 0.5){
            offscreenFrame = CGRectMake(view.superview.frame.size.width, onScreenFrame.origin.y, onScreenFrame.size.width, onScreenFrame.size.height);
        }else if(view.frame.origin.y <= 0){
            offscreenFrame = CGRectMake(onScreenFrame.origin.x, -view.frame.size.height, onScreenFrame.size.width, onScreenFrame.size.height);
        }else if(view.frame.origin.y >= view.superview.frame.size.height * 0.5){
            offscreenFrame = CGRectMake(onScreenFrame.origin.x, view.superview.frame.size.height, onScreenFrame.size.width, onScreenFrame.size.height);
        }
        
        UIViewController *viewController = [self applicationsCurrentRootViewController];
        if(!view.superview){
            [viewController.view addSubview:view];
        }
        view.frame = offscreenFrame;
        [UIView animateWithDuration:0.8 animations:^{
            view.frame = onScreenFrame;
        } completion:^(BOOL finished) {
        }];
    }
    
    
}




@end
