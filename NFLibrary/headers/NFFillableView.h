//
//  NFFillableView.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NFFillableView;
@protocol NFFillableViewDelegate <NSObject>;
@required
-(void)fillableViewDidFinishFilling:(NFFillableView *)fillableView;
@end

static const float kNFFillableViewFillAnimationHeightDelta = 0.016;
static const float kNFFillableViewFillAnimationTimeDelta = 0.04;

/**
 Creates a view that has an image element that can be filled vertically in an animated way. Usually meant to simulate a cup being filled etc.
 
 @warning *Important:* By default this image fill be blank because the fill level defaults to 0%. If you want to start this view as full or half full etc, then call [fillableView fillToPercentageHeight:1.0]; 
 
 Percentages are given as floats between 0-1.
 
 */
@interface NFFillableView : UIView


@property (nonatomic, unsafe_unretained) id <NFFillableViewDelegate> delegate;
@property CGFloat percentFull;
@property (nonatomic, strong) UIImageView *imageView;
@property UIImage *image;
@property BOOL filling;

/***
 *  Speed fills: Doesn't work as should. Is inversely related to speed. 
 *  TODO: Update this. 
 */
@property float speed;

- (id)initWithFrame:(CGRect)frame imageName:(NSString *)imageName;
-(void)layout;



-(void)fillToPercentageHeight:(CGFloat)percentFull;

#pragma mark Animation functions
-(void)startFilling;
-(void)stopFilling;


#pragma mark Getter/Setters
-(void)setFrame:(CGRect)frame;


@end
