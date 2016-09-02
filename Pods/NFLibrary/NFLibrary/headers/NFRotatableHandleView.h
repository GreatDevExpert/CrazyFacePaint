//
//  NFRotatableHandleView.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NFGeometry.h"

@class NFRotatableHandleView;
@protocol NFRotateHandleViewDelegate <NSObject>
@optional
- (void)rotateHandleDidTurnOn __attribute__((deprecated));
@optional
- (void)rotateHandleDidTurnOff __attribute__((deprecated));


@required
- (void)rotateHandleDidTurnOn:(NFRotatableHandleView *)rotatableHandleView;
@required
- (void)rotateHandleDidTurnOff:(NFRotatableHandleView *)rotatableHandleView;

@end

/**
 Creates a view that can be rotated. Can be used for handles etc.
 
 Usually rotate view contains an image, so currently common ways to initialize an object of this class is to call:
 [NFDraggableView makeRotatable:myImageView];
 
 This type of view can also be set up in interface builder by creating a UIView then setting its class to NFRotatableHandleView. Add a UIImageView to the UIView in interface builder and set its outlet to 'handleImageView' property. 
 
 // Shows both ways of creating an object of this class described above.
 Example: https://github.com/ninjafishstudios/WaffleMaker/blob/develop/App/Classes/ViewControllers/CookerViewController.m

 */
@interface NFRotatableHandleView : UIView

@property (nonatomic, unsafe_unretained) IBOutlet id <NFRotateHandleViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *handleImageView;
@property NFAngleRange allowableAngleRange;
@property float startingPositionAngle;
@property NFAngleRange turnedOnAngleRange;
@property BOOL rotationEnabled;
@property float currentHandleAngle;
@property CGPoint anchorPoint;

@property float maxRotationAngle DEPRECATED_ATTRIBUTE;
@property float minRotationAngle DEPRECATED_ATTRIBUTE;
@property BOOL shouldRotateClockwise DEPRECATED_ATTRIBUTE;
@property float turnedOnAngle DEPRECATED_ATTRIBUTE;



+(NFRotatableHandleView *)makeRotatable:(UIView *)view withAnchorPoint:(CGPoint)anchorPoint;

- (id)initWithFrame:(CGRect)frame handleImage:(UIImage *)handleImage anchorPercentagePoint:(CGPoint)anchorPercentagePoint;

-(void)rotateHandleToAngle:(float)radians;
-(double)angleBetweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2;

-(void)animateHandleBackToStartingPosition;

-(void)beginDragRotationForTouchPointInSuperview:(CGPoint)touchPoint;
-(void)continueDragRotationForTouchPointInSuperview:(CGPoint)touchPoint;

-(void)showAnchorPointGuide;

@end
