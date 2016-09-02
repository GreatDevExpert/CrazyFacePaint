//
//  AnimatedImageView.h
//  DentistOffice
//
//  Created by William Locke on 4/2/13.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFImageView.h"
#import <QuartzCore/QuartzCore.h>
@class NFAnimatedImageView;

typedef void (^ NFAnimatedImageViewCompletionHandler)();

typedef enum {
    NFAnimatedImageViewAnimationTypeCAKeyFrameAnimation,
    NFAnimatedImageViewAnimationTypeSelectorBased,
}NFAnimatedImageViewAnimationType;


@protocol NFAnimationImageViewDelegate <NSObject>
@optional
-(void)animatedImageViewDidCompleteAnimation:(NFAnimatedImageView *)animatedImageView;
@optional
-(void)animatedImageViewDidContinueAnimating:(NFAnimatedImageView *)animatedImageView;

@end

@interface NFAnimatedImageView : NFImageView


@property (unsafe_unretained, nonatomic) id<NFAnimationImageViewDelegate> delegate;

@property (nonatomic, strong) NSArray *items;

/**
 *  An array of NSNumbers that holds the amount of time to stay on each image. 
 */
@property (nonatomic, strong) NSArray *timing;

/**
 *  An array of NSNumbers that holds the amount (as a percentage) to randomize the timing corresponding
 *  to the given array slot. If you don't want timing randomization at a giving slot, just add an NSNumber 
 *  with the value of zero. 
 */
@property (nonatomic, strong) NSArray *timingRanges;

/**
 *  The number of times to repeat frame animation. Defaults to HUGE_VALF (infinite)
 */
//TODO: DEPRECATE AND CHANGE TO animationRepeatCount.
@property int repeatCount;

@property BOOL animating;


/**
 *  Dictates how frame animation is implemented. 
 */
@property NFAnimatedImageViewAnimationType animationType;

@property (nonatomic, strong) CAKeyframeAnimation *animation;


-(void)startAnimatingWithCompletionHandler:(NFAnimatedImageViewCompletionHandler)completionHandler;
    
+(void)setAnimationType:(NFAnimatedImageViewAnimationType)animationType;
-(void)reset;

@end
