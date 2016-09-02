//
//  DVAdKitAnimation.h
//  Pods
//
//  Created by William Locke on 10/30/13.
//
//

#import <Foundation/Foundation.h>

@interface DVAdKitAnimation : NSObject

@property float animationDuration;

+ (DVAdKitAnimation *)sharedInstance;

-(void)presentViewWithAnimationStyleFlip:(UIView *)view;
-(void)presentViewWithAnimationStyleSlide:(UIView *)view;
-(void)dismissView:(UIView *)view withAnimationStyleFlip:(void (^ )(BOOL finished))completionHandler;
-(void)dismissView:(UIView *)view withAnimationStyleSlide:(void (^ )(BOOL finished))completionHandler;
@end
