//
//  DVEasterEggs.h
//  HalloweenDressUp
//
//  Created by William Locke on 10/1/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVAdKitMoreApps : NSObject

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) UIWebView *webview;
@property BOOL moreAppsLoaded; 
@property BOOL loadingMoreApps;
@property (nonatomic, strong) UIButton *moreAppsButton;
@property int impressionCount;


+ (DVAdKitMoreApps *)sharedInstance;



-(void)preloadMoreApps;
-(void)showMoreApps;


#pragma mark ===== MORE APPS BUTTON ======
-(void)displayMoreAppsButton;
-(void)displayMoreAppsButtonWithImageName:(NSString *)imageName action:(int)action;


@end
