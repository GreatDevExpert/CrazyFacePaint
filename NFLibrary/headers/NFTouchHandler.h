//
//  NFTouchHandler.h
//  Cupcake
//
//  Created by William Locke on 1/7/13.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFTouchHandler : NSObject


+(UIView *)touchedSubviewForView:(UIView *)view withSubviews:(NSArray *)subviews touches:(NSSet *)touches;


+(CGRect)frameOfView:(UIView *)view relativeToIndirectSuperview:(UIView *)indirectSuperview;
+(CGFloat)distanceToSubview:(UIView *)subview fromTouchPoint:(CGPoint)touchPoint inView:(UIView *)view;

+(CGFloat)distanceToSubview:(UIView *)subview fromTouchPoint:(CGPoint)touchPoint inView:(UIView *)view partOfSubviewToMeasureTo:(UIViewContentMode)partOfSubviewToMeasureTo;


+(UIView *)closestSubview:(NSArray *)subviews toTouchPoint:(CGPoint)touchPoint inView:(UIView *)view partOfSubviewToMeasureTo:(UIViewContentMode)partOfSubviewToMeasureTo;

+(UIView *)closestSubview:(NSArray *)subviews toTouchPoint:(CGPoint)touchPoint inView:(UIView *)view;



@end
