//
//  AppDelegate.h
//  NinjafishStudiosApp
//
//  Created by William Locke on 9/17/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "NFConfig.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) NFConfig *config;



@end
