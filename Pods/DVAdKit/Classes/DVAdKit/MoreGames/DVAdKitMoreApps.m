//
//  DVEasterEggs.m
//  HalloweenDressUp
//
//  Created by William Locke on 10/1/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "DVAdKitMoreApps.h"
#import "DVHttpRequest.h"
#import "DVAdKitWebAPI.h"
#import "DVStoreProductHandler.h"
#import "DVAdKitWebViewBlockDelegate.h"
#import "DVDataStore.h"

typedef void (^DVAdKitMoreAppsLoadedCompletionHandler)();

@interface DVAdKitMoreApps()<UIWebViewDelegate>{
    DVAdKitWebViewBlockDelegate *_retainedBlock;
    DVAdKitMoreAppsLoadedCompletionHandler _moreAppsLoadedShowMoreAppsCompletionHandlerHook;
}

@end

@implementation DVAdKitMoreApps


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (DVAdKitMoreApps *)sharedInstance
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


-(UIViewController *)applicationsCurrentRootViewController{
    return [[DVStoreProductHandler sharedInstance] applicationsCurrentRootViewController];
}


-(void)preloadMoreApps{
    
    [self loadMoreGamesWithCompletionHandler:^{
        //[self displayMoreApps];
    }];
    
}


// TODO: Handle loadingMoreApps also
-(void)showMoreApps{
    if(self.moreAppsLoaded){
        [self displayMoreApps];
    }else{
        if(self.loadingMoreApps){
            DVAdKitMoreApps *selfObject = self;
            _moreAppsLoadedShowMoreAppsCompletionHandlerHook = ^{
                [selfObject displayMoreApps];
            };
        }else{
            [self loadMoreGamesWithCompletionHandler:^{
                [self displayMoreApps];
            }];
        }
        
    }
}

-(BOOL)validateResponse:(NSHTTPURLResponse *)response{
    if (!response.statusCode || response.statusCode < 200 || response.statusCode > 300) {
        return NO;
    }
    return YES;
}

-(void)loadMoreGamesWithCompletionHandler:(void (^ ) ())completionHandler{
    @try {
        

        
        self.moreAppsLoaded = NO;
        self.loadingMoreApps = YES;

        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [[DVAdKitWebAPI sharedInstance] addDeviceToParams:params];
        [[DVAdKitWebAPI sharedInstance] addAppToParams:params];
        [params setValue:@{@"name":@"more_apps"} forKey:@"ad_type"];
        

        [[DVAdKitWebAPI sharedInstance] webApiCall:@"/impressions/more_apps" params:params httpMethod:@"POST" options:nil NFWebApiResponseHandler:^(id<DVWebApiResponse> webApiResponse) {
            
            @try {
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)[webApiResponse response];
                if ([self validateResponse:response] == NO) {
                    self.loadingMoreApps = NO;
                    self.moreAppsLoaded = NO;
                    completionHandler();
                    return;
                }
                if([[webApiResponse data] data]){
                    NSString *htmlString = [[NSString alloc] initWithData:[[webApiResponse data] data] encoding:NSUTF8StringEncoding];
                    
                    [self loadMoreGamesViewControllerWithHtmlString:htmlString completionHandler:^{
                        self.moreAppsLoaded = YES;
                        self.loadingMoreApps = NO;
                        if(_moreAppsLoadedShowMoreAppsCompletionHandlerHook){
                            _moreAppsLoadedShowMoreAppsCompletionHandlerHook();
                        }
                        
                        if (completionHandler) {
                            completionHandler();
                        }
                    }];
                    
                }
            }
            @catch (NSException *exception) {
                
            }
            
        }];
            
            
        
    }
    @catch (NSException *exception) {
    }

}

-(void)loadMoreGamesViewControllerWithHtmlString:(NSString *)htmlString completionHandler:(void (^ ) ())completionHandler{
    
    @try {
        NSString *urlString = [@"" stringByAppendingFormat:@"%@%@", [[DVAdKitWebAPI sharedInstance] webApi].baseUrl, @"/impressions/more_apps"];
        
        UIViewController *rootViewController = [self applicationsCurrentRootViewController];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, rootViewController.view.frame.size.width, rootViewController.view.frame.size.height)];
            [_webview setDelegate:(_retainedBlock = [DVAdKitWebViewBlockDelegate blockDelegateWithDidFailLoadWithError:^(UIWebView *webView, NSError *error) {
            } didStartLoad:^(UIWebView *webView) {
            } didFinishLoad:^(UIWebView *webView) {
                if(completionHandler){
                    completionHandler();
                }
            } shouldStartLoadWithRequest:^(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType) {
            }])];
            _retainedBlock.delegate = self;
            
            [_webview loadHTMLString:htmlString baseURL:[NSURL URLWithString:urlString]];
        });
    }
    @catch (NSException *exception) {
        
    }
    

    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"FINISHED LOADING");
    

    [self displayMoreApps];
    
}

-(void)displayMoreApps{
    
    @try {
        
        self.impressionCount++;
        
        if(_viewController){
            [_viewController.view removeFromSuperview];
        }
        if (_webview) {
            [_webview removeFromSuperview];
        }
        if (_navigationController) {
            [_navigationController.view removeFromSuperview];            
        }

        if(!_viewController){
            _viewController = [[UIViewController alloc] init];
        }
        
        UIViewController *rootViewController = [self applicationsCurrentRootViewController];
        CGRect viewFrame = CGRectMake(0, 0, rootViewController.view.frame.size.width, rootViewController.view.frame.size.height);
        
        _viewController.view = [[UIView alloc] initWithFrame:viewFrame];
        [_viewController.view addSubview:_webview];
        
        
        if(!_navigationController) {
            _navigationController = [[UINavigationController alloc] initWithRootViewController:_viewController];
        }
        
        //set up the toolbar
        [_navigationController setToolbarHidden:YES];
        [_navigationController setNavigationBarHidden:YES];
        [_navigationController.toolbar setBarStyle:UIBarStyleDefault];  //for example
        UIBarButtonItem* button1 = [[UIBarButtonItem alloc] initWithTitle:@"Button Text" style:UIBarButtonItemStyleBordered target:self action:@selector(closeButtonPressed)];
        
        self.navigationController.toolbar.tintColor = [UIColor whiteColor];
        self.navigationController.toolbar.alpha = 0.1f;
        self.navigationController.toolbar.translucent = YES;
        //set the toolbar buttons
        [_navigationController setToolbarItems:[NSArray arrayWithObjects:button1, nil]];
        [self presentNavigationController];
        
    }
    @catch (NSException *exception) {
    }
    
}

-(void)presentNavigationController{
    UIViewController *rootViewController = [self applicationsCurrentRootViewController];
    CGRect viewFrame = CGRectMake(0, 0, rootViewController.view.frame.size.width, rootViewController.view.frame.size.height);
    
    CGRect offScreenFrame = CGRectMake(0, viewFrame.size.height, viewFrame.size.width, viewFrame.size.height);
    CGRect onScreenFrame = viewFrame;
    
    [rootViewController.view addSubview:_navigationController.view];
    
    _navigationController.view.frame = offScreenFrame;
    
    [UIView animateWithDuration:0.3 animations:^{
        _navigationController.view.frame = onScreenFrame;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissNavigationController{
    CGRect offScreenFrame = CGRectMake(0, _navigationController.view.frame.size.height, _navigationController.view.frame.size.width, _navigationController.view.frame.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        _navigationController.view.frame = offScreenFrame;
    } completion:^(BOOL finished) {
        [_navigationController.view removeFromSuperview];
    }];
}

-(void)closeButtonPressed{
    
}

#pragma mark ===== MORE APPS BUTTON ======
-(void)moreAppsButtonPressed:(id)sender{
    
    [self showMoreApps];
    
}

-(void)displayMoreAppsButton{
    [self displayMoreAppsButtonWithImageName:nil action:0];
}

-(void)displayMoreAppsButtonWithImageName:(NSString *)imageName action:(int)action{
    static BOOL displayMoreAppsButtonLocked;
    if (displayMoreAppsButtonLocked) {
        return;
    }
    displayMoreAppsButtonLocked = YES;
    
    UIImage *image;
    if (imageName) {
        image = [UIImage imageNamed:imageName];
    }else{
        image = [UIImage imageNamed:@"DVAdKit.bundle/more_apps"];
    }

    if(image.size.width < 1){
        return;
    }

    if(!self.moreAppsButton){
        self.moreAppsButton = [[UIButton alloc] init];
    }
    [self.moreAppsButton setImage:image forState:UIControlStateNormal];
    [self.moreAppsButton addTarget:self action:@selector(moreAppsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self presentMoreAppsButton];
    
    float duration = 8.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissMoreAppsButton:^{
            displayMoreAppsButtonLocked = NO;
        }];
    });
}

-(void)presentMoreAppsButton{
    UIViewController *rootViewController = [self applicationsCurrentRootViewController];
    UIImage *image = [self.moreAppsButton imageForState:UIControlStateNormal];
    CGSize buttonSize = CGSizeMake(rootViewController.view.frame.size.width * 0.15, rootViewController.view.frame.size.width * 0.15);
    CGRect bottomLeftRect = CGRectMake(0,rootViewController.view.frame.size.height - buttonSize.height, buttonSize.width, buttonSize.height);
    CGRect onScreenFrame = bottomLeftRect;
    CGRect offScreenFrame = CGRectMake(onScreenFrame.origin.x, onScreenFrame.origin.y + onScreenFrame.size.height, onScreenFrame.size.width, onScreenFrame.size.height);
    
    self.moreAppsButton.frame = offScreenFrame;
    [rootViewController.view addSubview:self.moreAppsButton];
    
    [UIView animateWithDuration:0.7 animations:^{
        self.moreAppsButton.frame = onScreenFrame;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissMoreAppsButton:(void (^ )())completionHandler{
    CGRect offScreenFrame = CGRectMake(self.moreAppsButton.frame.origin.x, self.moreAppsButton.frame.origin.y + self.moreAppsButton.frame.size.height, self.moreAppsButton.frame.size.width, self.moreAppsButton.frame.size.height);
    [UIView animateWithDuration:0.7 animations:^{
        self.moreAppsButton.frame = offScreenFrame;
    } completion:^(BOOL finished) {
        if(completionHandler){
            completionHandler();
        }
    }];
    
}



#pragma mark <UIWebViewDelegate>
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request  navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"request: %@", [[request URL] absoluteString]);
    NSString *urlAbsoluteString = [[request URL] absoluteString];
    NSRange rangeOfCloseString = [urlAbsoluteString rangeOfString:@"#close"];
    if(rangeOfCloseString.location != NSNotFound){
        [self dismissNavigationController];
        return NO;
    }
    
    NSRange rangeOfPreloadAppStoreLink = [urlAbsoluteString rangeOfString:@"#preload_app_store_link"];
    if(rangeOfPreloadAppStoreLink.location != NSNotFound){
        NSArray *components = [urlAbsoluteString componentsSeparatedByString:@"#preload_app_store_link="];
        NSString *appStoreLink = [components lastObject];
        NSLog(@"app store link: %@", appStoreLink);
        if(appStoreLink){
            [[DVStoreProductHandler sharedInstance] loadProductDataForAppStoreLink:appStoreLink completionHandler:^(BOOL success) {
                NSLog(@"LOADED: %d", success);
            }];
        }
    }
    
    NSRange rangeOfNavigateToAppStoreLink = [urlAbsoluteString rangeOfString:@"#open_app_store_link"];
    if(rangeOfNavigateToAppStoreLink.location != NSNotFound){
        NSArray *components = [urlAbsoluteString componentsSeparatedByString:@"#open_app_store_link="];
        NSString *appStoreLink = [components lastObject];
        NSLog(@"app store link: %@", appStoreLink);
        if(appStoreLink){
//            NSString *jsonAsString = [webView stringByEvaluatingJavaScriptFromString:@"myJavaScript"]
//            id jsonObject = nil;
//            if (jsonAsString) {
//                id jsonObject = [DVDataStore jsonObjectFromString:jsonAsString];
//            }
            
//            [self dismissNavigationController];
            if([[DVStoreProductHandler sharedInstance] appStoreLinkLoaded:appStoreLink]){
                [[DVStoreProductHandler sharedInstance] openInRootViewController:[self applicationsCurrentRootViewController] completionHandler:^(BOOL success) {
                    NSLog(@"LOADED..");
                }];
            }else{
                NSURL *url = [NSURL URLWithString:appStoreLink];
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
    
    
    return YES;
}



@end
