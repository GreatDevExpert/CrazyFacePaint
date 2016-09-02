//
//  ViewControllerLayoutComponent.h
//  BestFriendsMakeover
//
//  Created by William Locke on 10/15/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFGameViewController.h"


@interface ViewControllerComponent : NSObject


@property (nonatomic, strong) NFGameViewController *viewController;


- (instancetype)initWithViewController:(NFGameViewController *)viewController;

-(void)presentUnlockThemeButtonWithImageName:(NSString *)imageName productId:(NSString *)productId;

-(void)controlButtonPressed:(id)sender inControlButtonStripView:(NFControlButtonStripView *)controlButtonStripView;

-(void)showTitleForTheme:(NSString *)theme;

@end
