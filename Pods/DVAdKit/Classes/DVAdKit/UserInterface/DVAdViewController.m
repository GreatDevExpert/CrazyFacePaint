//
//  DVAdViewController.m
//
//  Created by William Locke on 5/20/13.
//
//

// TODO: Add try catch blocks to all blocks. 

#import "DVAdViewController.h"
#import "DVAdKitApp.h"
#import "DVAdKitAd.h"
#import "DVAdKitImpression.h"
#import "DVAdKitAnimation.h"
#import "DVAdKitAdDisplaySettings.h"
#import <QuartzCore/QuartzCore.h>
#import <StoreKit/StoreKit.h>
#import "DVStoreProductHandler.h"

typedef enum {
    DVAdKitViewControllerAnimationStyleDefault,
    DVAdKitViewControllerAnimationStyleFlipInFromLeft,
    DVAdKitViewControllerAnimationStyleSlideInFromLeft
    } DVAdKitViewControllerAnimationStyle;

@interface DVAdViewController ()<SKStoreProductViewControllerDelegate>{
    UIView *_backgroundView;
    
    UIView *_adView;
    UIImageView *_frameImageView;
    UIButton *_adButton;
    UIButton *_closeButton;
    float _animationDuration;
    UIButton *_removeAdsButton;
    
    CATransform3D _transformStartingPositionForFlipInFromLeftAnimation;
    CATransform3D _transformMiddlePositionForFlipInFromLeftAnimation;
    CATransform3D _transformEndingPositionForFlipInFromLeftAnimation;

    int _animationStyle;
    
    UIView *_activityIndicatorView;
}

@end

@implementation DVAdViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        
        // Custom initialization
        _animationDuration = 0.3;
        _animationStyle = DVAdKitViewControllerAnimationStyleFlipInFromLeft;

        [self layout];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layout{

    CGRect zeroedFullScreenFrame = CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    
    if (self.creative.orientation && [self.creative.orientation isEqualToString:@"Landscape"]) {
        zeroedFullScreenFrame = CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    }
    
    self.view = [[UIView alloc] initWithFrame:zeroedFullScreenFrame];
    
    if(!self.frameImage){
//        self.frameImage = [UIImage imageNamed:@"iphone-portrait-frame.png"];
    }
    
    CGSize frameSize = self.frameImage.size;
//    frameSize = CGSizeMake(self.view.frame.size.width * 0.9, self.view.frame.size.width * (self.frameImage.size.height / self.frameImage.size.width));
    
    _frameImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - frameSize.width) / 2.0, (self.view.frame.size.height - frameSize.height) / 2.0, frameSize.width, frameSize.height)];
    
    _frameImageView.image = self.frameImage;
    
    CGSize adSize = self.adImage.size;
    CGRect frame = CGRectMake((self.view.frame.size.width - adSize.width) / 2.0, (self.view.frame.size.height - adSize.height) / 2.0, adSize.width, adSize.height);
    _adButton = [[UIButton alloc] initWithFrame:frame];
    
    
    if(self.adImage != nil){
        [_adButton setImage:self.adImage forState:UIControlStateNormal];
    }
    
    
    [_adButton addTarget:self action:@selector(adPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *bundleName = @"NFAdKit";
    NSString *bundleLocation = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundleLocation];
    
    NSString *deviceSpecificImageName = @"close~iphone.png";
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad || [[UIScreen mainScreen] bounds].size.width == 768){
        deviceSpecificImageName = @"close~ipad.png";
    }
    
    UIImage *closeButtonImage = [UIImage imageNamed:@"DVAdKit.bundle/close.png"];
    
    
#ifdef ANDROID
    NSString *fileLocation = [bundle pathForResource:[deviceSpecificImageName stringByDeletingPathExtension] ofType:[deviceSpecificImageName pathExtension]];
    closeButtonImage = [UIImage imageWithContentsOfFile:fileLocation];
#endif
    

    
    CGSize closeButtonSize = closeButtonImage.size;
    CGRect closeButtonFrame = CGRectMake(_frameImageView.frame.origin.x + _frameImageView.frame.size.width - closeButtonSize.width * 0.7, _frameImageView.frame.origin.y - closeButtonSize.height * 0.3, closeButtonSize.width, closeButtonSize.height);
    _closeButton = [[UIButton alloc] initWithFrame:closeButtonFrame];
    
    if(closeButtonImage != nil){
        [_closeButton setImage:closeButtonImage forState:UIControlStateNormal];
    }
    
    [_closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _adView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_adView];
    [_adView addSubview:_frameImageView];
    [_adView addSubview:_adButton];
    [_adView addSubview:_closeButton];

    

    // REMOVE ADS CODE
//    if(_removeAdsButton){
//        [_removeAdsButton removeFromSuperview];
//    }
//    _removeAdsButton = [[UIButton alloc] initWithFrame:CGRectMake(_adButton.frame.origin.x, _adButton.frame.origin.y + _adButton.frame.size.height * 0.85, _adButton.frame.size.width * 0.2, _adButton.frame.size.height * 0.15)];
//    [_removeAdsButton addTarget:self action:@selector(removeAdsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    _removeAdsButton.backgroundColor = [UIColor redColor];
//    [_adView addSubview:_removeAdsButton];

}

#pragma mark Retrieve Application's UIElements
-(UIViewController *)applicationsCurrentRootViewController{
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];

    if (self.creative && self.creative.orientation && [[self.creative.orientation lowercaseString] isEqualToString:@"portrait"]) {
        
    }else{
        while ([rootViewController isKindOfClass:[UITabBarController class]] || [rootViewController isKindOfClass:[UINavigationController class]]) {
            if ([rootViewController isKindOfClass:[UITabBarController class]]){
                rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
            }else if ([rootViewController isKindOfClass:[UINavigationController class]]){
                rootViewController = ((UINavigationController *)rootViewController).topViewController;
            }
        }
    }

    return rootViewController;
}


-(UIView *)newActivityIndicatorView{
    UIViewController *rootViewController = [self applicationsCurrentRootViewController];
    UIView *view;
    if(rootViewController){
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rootViewController.view.frame.size.width, rootViewController.view.frame.size.height)];
    }else{
        view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    //    activityIndicatorView.frame = [NFLayout deviceFrame:CGRectMake(140, 200, 40, 40)];
    activityIndicatorView.frame = CGRectMake(view.frame.size.width * 0.4, view.frame.size.height * 0.4, view.frame.size.width * 0.2, view.frame.size.height * 0.2);
    
    
    
    [activityIndicatorView startAnimating];
    
    if(self){
        if(self.interfaceOrientation == UIDeviceOrientationLandscapeLeft || self.interfaceOrientation == UIDeviceOrientationLandscapeRight){
            NSLog(@"DVAdKit interface orientation landscape");
        }
    }
    [view addSubview:activityIndicatorView];
    return view;
}


#pragma mark Show / Hide

#pragma mark -- Show Elements
-(void)show{
    UIViewController *rootViewController = [self applicationsCurrentRootViewController];
    id appDelegate = [[UIApplication sharedApplication] delegate];
    UIWindow *window = nil;
    if([appDelegate respondsToSelector:@selector(window)]){
//        window = [appDelegate window];
    }
    
    UIView *view = rootViewController.view;
    
    if(window){
        [self showInView:window];
    }else{
        [self showInView:view];
    }
}

-(void)showInView:(UIView *)view{
    if(self.adImage && self.adImage.size.width > 0 && self.frameImage && self.frameImage > 0){
        [self layout];
    }else{
        return;
    }
    
    [self showInView:view withAnimationStyle:_animationStyle];
}

-(void)showInView:(UIView *)view withAnimationStyle:(DVAdKitViewControllerAnimationStyle)animationStyle{
    
    if (self.impression.adDisplaySettings.shouldPresentAppStoreInsideApp) {
        [[DVStoreProductHandler sharedInstance] loadProductDataForAppStoreLink:self.impression.ad.app.appStoreLink completionHandler:^(BOOL success) {
        }];
    }
    
    
    [self showBackgroundViewInView:view];
    CGSize size = view.frame.size;
//    self.view.frame = CGRectMake(0, 0,size.width, size.height);
    [view addSubview:self.view];
    
    NSLog(@"current VC view: %f, %f, %f, %f", view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    
    NSLog(@"current VC view: %f, %f, %f, %f", view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    
    NSLog(@"DVAdKit: show in view: %@", view);
    
    switch (animationStyle) {
        case DVAdKitViewControllerAnimationStyleFlipInFromLeft:
//            [self presentAdViewWithAnimationStyleFlipInFromLeft];
            [[DVAdKitAnimation sharedInstance] presentViewWithAnimationStyleFlip:_adView];
            break;
        case DVAdKitViewControllerAnimationStyleSlideInFromLeft:
//            [self presentAdViewWithAnimationStyleSlideInFromLeft];
            [[DVAdKitAnimation sharedInstance] presentViewWithAnimationStyleSlide:_adView];
            break;
        default:
//            [self presentAdViewWithAnimationStyleSlideInFromLeft];
            [[DVAdKitAnimation sharedInstance] presentViewWithAnimationStyleSlide:_adView];
            break;
    }
}


-(void)presentAdViewWithAnimationStyleSlideInFromLeft DEPRECATED_ATTRIBUTE{
    _adView.frame = CGRectMake(-self.view.frame.size.width, 0, _adView.frame.size.width, _adView.frame.size.height);
    [UIView animateWithDuration:_animationDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _adView.frame = CGRectMake(0, 0, _adView.frame.size.width, _adView.frame.size.height);
    }completion:^(BOOL finished){
    }];
}

-(void)presentAdViewWithAnimationStyleFlipInFromLeft DEPRECATED_ATTRIBUTE{
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = -1.0/400;
    
    
    CATransform3D startingTranslation = CATransform3DMakeTranslation(-self.view.frame.size.width * 1.2, 0, 0.0);
    CATransform3D startingRotation = CATransform3DRotate(rotationAndPerspectiveTransform, -0.6, 0.0, 0.6, 0.0);
    
    
    CATransform3D endingTranslation;
    CATransform3D endingRotation;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone || [UIScreen mainScreen].bounds.size.width == 320){
        endingTranslation = CATransform3DMakeTranslation(self.view.frame.size.width * 1.5, 0, 0.0);
        endingRotation = CATransform3DRotate(rotationAndPerspectiveTransform, -0.7, 0.0, -0.6, 0.0);
    }else{
        endingTranslation = CATransform3DMakeTranslation(self.view.frame.size.width * 1.2, 0, 0.0);
        endingRotation = CATransform3DRotate(rotationAndPerspectiveTransform, -0.35, 0.0, -0.6, 0.0);
    }
    _transformStartingPositionForFlipInFromLeftAnimation = CATransform3DConcat(startingTranslation, startingRotation);
    _transformMiddlePositionForFlipInFromLeftAnimation = CATransform3DIdentity;
    _transformEndingPositionForFlipInFromLeftAnimation = CATransform3DConcat(endingTranslation, endingRotation);
    
    _adView.layer.transform = _transformStartingPositionForFlipInFromLeftAnimation;

    
    [UIView animateWithDuration:_animationDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _adView.layer.transform = _transformMiddlePositionForFlipInFromLeftAnimation;
    }completion:^(BOOL finished){
        
    }];
    
}


-(void)showBackgroundViewInView:(UIView *)view{
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.view.frame];
    backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [view addSubview:backgroundView];
    UIColor *backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    backgroundView.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:_animationDuration animations:^{
        backgroundView.backgroundColor = backgroundColor;
    }completion:^(BOOL finished){
        [backgroundView removeFromSuperview];
        self.view.backgroundColor = backgroundColor;
    }];
}



#pragma mark -- Dismiss Elements
-(void)dismissBackgroundView{
    UIView *view = self.view.superview;
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.view.frame];
    backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    UIColor *backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    backgroundView.backgroundColor = backgroundColor;
    
    [view insertSubview:backgroundView belowSubview:self.view];
    self.view.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.5 animations:^{
        backgroundView.backgroundColor = [UIColor clearColor];
    }completion:^(BOOL finished){
        [backgroundView removeFromSuperview];
    }];
}

-(void)dismissAdViewWithAnimationStyleFlipInFromLeft:(void (^ )(BOOL finished))completionHandler DEPRECATED_ATTRIBUTE{

    [UIView animateWithDuration:_animationDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _adView.layer.transform = _transformEndingPositionForFlipInFromLeftAnimation;
    }completion:^(BOOL finished){
        
        if(completionHandler){
            completionHandler(YES);
        }
    }];
    

}

-(void)dismissAdViewWithAnimationStyleSlideInFromLeft:(void (^ )(BOOL finished))completionHandler DEPRECATED_ATTRIBUTE{

    [UIView animateWithDuration:_animationDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _adView.frame = CGRectMake(self.view.frame.size.width, 0, _adView.frame.size.width, _adView.frame.size.height);
    }completion:^(BOOL finished){
        if(completionHandler){
            completionHandler(YES);
        }
    }];
}

-(void)dismissAdViewWithAnimationStyle:(DVAdKitViewControllerAnimationStyle)animationStyle completionHandler:(void (^ )(BOOL finished))completionHandler{
    
    
    switch (animationStyle) {
        case DVAdKitViewControllerAnimationStyleFlipInFromLeft:
//            [self dismissAdViewWithAnimationStyleFlipInFromLeft:completionHandler];
            [[DVAdKitAnimation sharedInstance] dismissView:_adView withAnimationStyleFlip:completionHandler];
            break;
        case DVAdKitViewControllerAnimationStyleSlideInFromLeft:
//            [self dismissAdViewWithAnimationStyleSlideInFromLeft:completionHandler];
            [[DVAdKitAnimation sharedInstance] dismissView:_adView withAnimationStyleSlide:completionHandler];
            break;
        default:
            [self dismissAdViewWithAnimationStyleSlideInFromLeft:completionHandler];
            break;
    }
    
    
}


-(void)dismiss{
    UIView *view = self.view.superview;
    if(!view){
        return;
    }
    
    [self dismissBackgroundView];
        
    [self dismissAdViewWithAnimationStyle:_animationStyle completionHandler:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
    
}


#pragma mark --Show Interstitial Inside App
//-(void)openUrlWithProductViewController:(NSURL *)url completionHandler:(void (^ )(BOOL success))completionHandler{
//    
//    SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:storeViewController];
//    [navigationController setNavigationBarHidden:YES];
//    storeViewController.delegate = self;
//    
//    UIViewController *rootViewController = [self applicationsCurrentRootViewController];
//    if(_activityIndicatorView){
//        [_activityIndicatorView removeFromSuperview];
//    }
//    _activityIndicatorView = [self newActivityIndicatorView];
//    
//    
//    NSNumber *iTunesItemIdentifier = [self itunesItemIdentifierFromUrlString:[url absoluteString]];
//    
//    if(iTunesItemIdentifier && rootViewController){
//        
//        [rootViewController.view addSubview:_activityIndicatorView];
//        [storeViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:iTunesItemIdentifier, @"at": @"11lLxv" } completionBlock:^(BOOL result, NSError *error){
//            [_activityIndicatorView removeFromSuperview];
//            
//            if(result){
//                [rootViewController.navigationController presentModalViewController:navigationController animated:YES];
//                completionHandler(YES);
//            }else{
//                completionHandler(NO);
//            }
//
//        }];
//
//    }else{
//        completionHandler(NO);
//    }
//
//}

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

#pragma mark IBActions
-(IBAction)closeButtonPressed:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(willCloseImpression:)]){
        [self.delegate willCloseImpression:self.impression];
    }
    
    [self dismiss];
}

-(IBAction)adPressed:(id)sender{
    if(self.impression){
        self.impression.clicked = YES;
        
        NSLog(@"ad pressed");
        
        NSLog(@"delegate: %@", self.delegate);
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(didClickImpression:)]){
            [self.delegate didClickImpression:self.impression];
        }
        
        UIViewController *rootViewController = [self applicationsCurrentRootViewController];
//        UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        
        
        NSURL *url = [NSURL URLWithString:self.impression.ad.app.appStoreLink];
        // Note! Opening URL in app store inside app happens inside the conditional!
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && self.impression.adDisplaySettings.shouldPresentAppStoreInsideApp){
            
            
            if([[DVStoreProductHandler sharedInstance] appStoreLinkLoaded:self.impression.ad.app.appStoreLink]){
                [[DVStoreProductHandler sharedInstance] openInRootViewController:rootViewController completionHandler:^(BOOL success) {
                }];
            }else{
                [[UIApplication sharedApplication] openURL:url];
            }

        }else{
            [[UIApplication sharedApplication] openURL:url];
        }

    }
    
    
    [self dismiss];
}

-(IBAction)removeAdsButtonPressed:(id)sender{
    NSLog(@"remove ads");
    if(self.delegate && [self.delegate respondsToSelector:@selector(willCloseImpression:)]){
        [self.delegate willCloseImpression:self.impression];
    }
    [self dismiss];
    
    if([self.delegate respondsToSelector:@selector(didPressRemoveAds)]){
        [self.delegate didPressRemoveAds];
    }
}

#pragma mark Delegates
#pragma mark --SKStoreProductViewController
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [viewController.navigationController dismissModalViewControllerAnimated:YES];
    
}



@end
