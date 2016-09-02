//
//  DVAdKitAnimation.m
//  Pods
//
//  Created by William Locke on 10/30/13.
//
//

#import "DVAdKitAnimation.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface DVAdKitAnimation(){
    float _animationDuration;
}

@end

@implementation DVAdKitAnimation

+ (DVAdKitAnimation *)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (id)init
{
    self = [super init];
    if (self) {
        _animationDuration = 0.3;
    }
    return self;
}

-(void)presentViewWithAnimationStyleFlip:(UIView *)view{
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = -1.0/400;
    
    
    CATransform3D startingTranslation = CATransform3DMakeTranslation(-view.frame.size.width * 1.2, 0, 0.0);
    CATransform3D startingRotation = CATransform3DRotate(rotationAndPerspectiveTransform, -0.6, 0.0, 0.6, 0.0);
    
    CATransform3D endingTranslation;
    CATransform3D endingRotation;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone || [UIScreen mainScreen].bounds.size.width == 320){
        endingTranslation = CATransform3DMakeTranslation(view.frame.size.width * 1.5, 0, 0.0);
        endingRotation = CATransform3DRotate(rotationAndPerspectiveTransform, -0.7, 0.0, -0.6, 0.0);
    }else{
        endingTranslation = CATransform3DMakeTranslation(view.frame.size.width * 1.2, 0, 0.0);
        endingRotation = CATransform3DRotate(rotationAndPerspectiveTransform, -0.35, 0.0, -0.6, 0.0);
    }
    
    CATransform3D transformStartingPosition = CATransform3DConcat(startingTranslation, startingRotation);
    CATransform3D transformMiddlePosition = CATransform3DIdentity;
    
    view.layer.transform = transformStartingPosition;
    
    
    [UIView animateWithDuration:_animationDuration delay:0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^{
        view.layer.transform = transformMiddlePosition;
    }completion:^(BOOL finished){
        
    }];
    
}


-(void)presentViewWithAnimationStyleSlide:(UIView *)view{
    view.frame = CGRectMake(-view.frame.size.width, 0, view.frame.size.width, view.frame.size.height);
    [UIView animateWithDuration:_animationDuration delay:0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^{
        view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    }completion:^(BOOL finished){
    }];
}

-(void)dismissView:(UIView *)view withAnimationStyleFlip:(void (^ )(BOOL finished))completionHandler{
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = -1.0/400;
    
    CATransform3D endingTranslation;
    CATransform3D endingRotation;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone || [UIScreen mainScreen].bounds.size.width == 320){
        endingTranslation = CATransform3DMakeTranslation(view.frame.size.width * 1.5, 0, 0.0);
        endingRotation = CATransform3DRotate(rotationAndPerspectiveTransform, -0.7, 0.0, -0.6, 0.0);
    }else{
        endingTranslation = CATransform3DMakeTranslation(view.frame.size.width * 1.2, 0, 0.0);
        endingRotation = CATransform3DRotate(rotationAndPerspectiveTransform, -0.35, 0.0, -0.6, 0.0);
    }
    
    CATransform3D transformEndingPosition = CATransform3DConcat(endingTranslation, endingRotation);
    
    
    
    [UIView animateWithDuration:_animationDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.layer.transform = transformEndingPosition;
    }completion:^(BOOL finished){
        
        if(completionHandler){
            completionHandler(YES);
        }
    }];
    
    
}

-(void)dismissView:(UIView *)view withAnimationStyleSlide:(void (^ )(BOOL finished))completionHandler{
    
    [UIView animateWithDuration:_animationDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.frame = CGRectMake(view.frame.size.width, 0, view.frame.size.width, view.frame.size.height);
    }completion:^(BOOL finished){
        if(completionHandler){
            completionHandler(YES);
        }
    }];
}


@end
