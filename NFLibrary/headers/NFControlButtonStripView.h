//
//  NFControlButtonStripView.h
//  Princess
//
//  Created by William Locke on 1/17/13.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFGeometry.h"

/**
 The possible states for the control strip.
 */
typedef enum {
    NFControlButtonStipViewStateNone,
    NFControlButtonStipViewStateExpandableButtonsVisible,
    NFControlButtonStipViewStateExpandableButtonsHidden
}NFControlButtonStipViewState;


@class NFControlButtonStripView;
@protocol NFControlButtonStripViewDelegate <NSObject>
@required
-(void)controlButtonPressed:(id)sender inControlButtonStripView:(NFControlButtonStripView *)controlButtonStripView;
@optional
-(void)controlButtonStripViewDidExpand:(NFControlButtonStripView *)controlButtonStripView;
@optional
-(void)controlButtonStripViewWillExpand:(NFControlButtonStripView *)controlButtonStripView;
@optional
-(void)controlButtonStripViewDidContract:(NFControlButtonStripView *)controlButtonStripView;
@optional
-(void)controlButtonStripViewWillContract:(NFControlButtonStripView *)controlButtonStripView;

@end

/**
 Creates a strip of buttons using given array of image names. 
 */
@interface NFControlButtonStripView : UIView

@property (nonatomic, unsafe_unretained) id <NFControlButtonStripViewDelegate> delegate;


@property (nonatomic, strong)  NSMutableArray *buttons;

/**
 *  An array of button names. 
 *  TODO: maybe change to items? or buttonImageNames
 */
@property (nonatomic, strong) NSArray *controlButtonNames;

/**
 *  Sets the size of each button view. If this is not set, the size of the image 
 *  associated with the first button is used. 
 */
@property CGSize itemSize;

/**
 *  The amount of spacing in pixels between each button.
 */
@property CGSize spacing;

/**
 *  Dictates direction in which control strip is laid out (e.g. horizontally/vertically).
 */
@property NFDirection direction;

/**
 *  Determines whether control button strip expands upon clicking pivot button.
 */
@property BOOL expandable;

/**
 *  Index of pivot button which expands control strip when pressed
 */
@property int expandablePivotIndex;

/**
 *  Indicates whether button used for expanding control strip in and out is visible.
 */
@property BOOL exandableButtonsVisible;


-(void)layout;


- (id)initWithFrame:(CGRect)frame controlButtonNames:(NSArray *)controlButtonNames itemSize:(CGSize)itemSize spacing:(CGSize)spacing direction:(NFDirection)direction;

-(void)updateControlButtonImageAtIndex:(int)index withImageNamed:(NSString *)imageName;

-(void)setExandablePivotButtonImageName:(NSString *)imageName forState:(NFControlButtonStipViewState)state;


#pragma mark --Exandable Buttons
-(void)toggleExpandableButtons;
-(void)hideExpandableButtons;
-(void)hideExpandableButtonsAnimated:(BOOL)animated;
-(void)showExpandableButtons;




-(NSString *)buttonImageNameAtIndex:(int)index;



-(void)toggleExpandableButtons;
-(void)hideExpandableButtons;
-(void)showExpandableButtons;

@end
