//
//  NFAnimation.h
//  Cupcake
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFEmitterLayer.h"
#import "NFAnimatedImageView.h"
#import "NFGeometry.h"

/** This library holds and will hold animation related classes and functions.
 Thus far, mainly consists of various View animations that might animate a view onto or off from a particular view controller as well as a collection of particle emitters that will be stored as plist resource files in future versions.
 
 Things like sliding in a view, zoom pulsing a view, spinning a view off screen, fading view in or out, etc. can be added to this class. 
 
 */
@interface NFAnimation : NSObject

typedef void (^ NFAnimationCompletionHandler)(BOOL finished);


@property BOOL animating;
@property float period;
@property (nonatomic, strong) NSMutableArray *loopedAnimations;
@property (nonatomic, strong) UIView *view;
@property CGFloat pulseHeight;
@property CGFloat pulseMagnitude;
@property int repeatCount;


+(void)fadeInView:(UIView *)view completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(void)fadeInView:(UIView *)view duration:(float)duration completionHandler:(NFAnimationCompletionHandler)completionHandler;
    
+(void)fadeOutView:(UIView *)view duration:(float)duration completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(void)slideInView:(UIView *)view direction:(CGPoint)direction completionHandler:(NFAnimationCompletionHandler)completionHandler;
+(void)slideInView:(UIView *)view duration:(float)duration direction:(CGPoint)direction completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(void)slideOutView:(UIView *)view direction:(CGPoint)direction completionHandler:(NFAnimationCompletionHandler)completionHandler;
+(void)slideOutView:(UIView *)view duration:(float)duration direction:(CGPoint)direction completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(void)rotateView:(UIView *)view radians:(CGFloat)radians duration:(CGFloat)duration completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(void)rotateView:(UIView *)view radians:(CGFloat)radians duration:(CGFloat)duration useConcatenation:(BOOL)useConcatenation completionHandler:(NFAnimationCompletionHandler)completionHandler;


+(void)fadeInNewImage:(UIImage *)image forImageView:(UIImageView *)imageView duration:(CGFloat)duration completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(void)fadeReplaceImageView:(UIImageView *)imageView1 forImageView:(UIImageView *)imageView2 duration:(CGFloat)duration completionHandler:(NFAnimationCompletionHandler)completionHandler;


+(void)spinAndSlideOutView:(UIView *)view duration:(float)duration direction:(CGPoint)direction completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(void)showViewWithBouncingZoom:(UIView *)view completionHandler:(NFAnimationCompletionHandler)completionHandler;
+(void)showViewWithBouncingZoom:(UIView *)view duration:(CGFloat)duration completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(void)showViewWithSpinAndGrow:(UIView *)view duration:(CGFloat)duration completionHandler:(NFAnimationCompletionHandler)completionHandler;
+(void)hideViewWithSpinAndShrink:(UIView *)view duration:(CGFloat)duration completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(void)halloweenOffScreen:(UIView *)view completionHandler:(NFAnimationCompletionHandler)completionHandler;
+(void)halloweenOffScreen:(UIView *)view duration:(float)duration completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(NFAnimation *)pulseSizeOfView:(UIView *)view;
+(NFAnimation *)pulseSizeOfView:(UIView *)view period:(float)period;
+(NFAnimation *)pulseSizeOfView:(UIView *)view period:(float)period pulseMagnitude:(float)pulseMagnitude;
+(NFAnimation *)pulseVerticalOriginOfView:(UIView *)view period:(float)period pulseHeight:(CGFloat)pulseHeight;

-(void)beginPulsingSizeOfView:(UIView *)view;
-(void)endPulsingSizeOfView:(UIView *)view;



+(NFAnimation *)pulseVerticalOriginOfView:(UIView *)view;
+(NFAnimation *)pulseVerticalOriginOfView:(UIView *)view period:(float)period pulseHeight:(CGFloat)pulseHeight;


+(void)showViewWithGrowingAnimation:(UIView *)view duration:(float)duration completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(void)endLoopedAnimationForView:(UIView *)view;
+(void)endAllLoopedAnimations;


+ (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;


+(void)shakeView:(UIView *)view duration:(CGFloat)duration completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(void)animateViewAcrossScreen:(UIView *)view withDuration:(float)duration direction:(NFDirection)direction completionHandler:(NFAnimationCompletionHandler)completionHandler;


-(NFAnimation *)bounce:(UIView *)view;

+(void)bob:(UIView *)view duration:(CGFloat)duration completionHandler:(NFAnimationCompletionHandler)completionHandler;
+(void)block:(UIView *)view duration:(float)duration  completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(void)rotateAndBack:(UIView *)view duration:(CGFloat)duration radians:(CGFloat)radians completionHandler:(NFAnimationCompletionHandler)completionHandler;

+(void)flickerView:(UIView *)view;

+ (void)twitchtView:(UIView*)view magnification:(float)magnification repeat:(float)repeat;




+ (void)sequentiallyPopInViews:(NSArray *)views eachPopinDuration:(float)duration completionHandler:(NFAnimationCompletionHandler)completionHandler;


@end
