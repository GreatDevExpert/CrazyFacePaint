//
//  ViewController+popupHandlers.h
//  PrincessFashionResort
//
//  Created by William Locke on 6/16/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFViewController.h"

@protocol NFViewControllerTitleHandlersLabel <NSObject>
-(void)setDrawOutline:(BOOL)drawOutline;
-(void)setOutlineColor:(UIColor *)outlineColor;
-(void)setDrawGradient:(BOOL)drawGradient;
-(void)setOutlineWidth:(CGFloat )outlineWidth;
-(void)setDropShadow:(BOOL)drawDropShadow;
-(void) setGradientColors: (CGFloat [8]) colors;
@end

@interface NFViewController (titleHandlers)


-(UILabel<NFViewControllerTitleHandlersLabel> *)viewControllerTitleHandlersTitleLabel;

-(UILabel *)showTitleWithText:(NSString *)text;
-(UILabel *)showTitleWithText:(NSString *)text usingLabelSubclass:(Class)labelSubclass;
-(void)showCongratulationTitle;
-(void)showTryAgainTitle;

@end
