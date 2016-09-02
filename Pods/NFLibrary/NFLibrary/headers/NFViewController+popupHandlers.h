//
//  ViewController+popupHandlers.h
//  PrincessFashionResort
//
//  Created by William Locke on 6/16/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFViewController.h"

@interface NFViewController (popupHandlers)

-(UIView *)presentLockedThemeWithThemeLockedImageName:(NSString *)themeLockedImageName positionBelowView:(UIView *)positionBelowView lockButtonClicked:(void (^ )())lockButtonClicked;

@end
