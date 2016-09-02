//
//  NFBenchItemView.h
//  Pods
//
//  Created by William Locke on 3/7/13.
//
//

#import <UIKit/UIKit.h>
#import "NFDraggableView.h"
#import "NFAnimation.h"
@class NFBenchView;


@protocol BenchItem <NSObject>
@optional
-(NSString *)benchItem;
@optional
-(void)setBenchItem:(NSString *)benchItem;
@optional
-(BOOL)clickable;
@optional
-(BOOL)draggable;
@optional
-(NSNumber *)rotateOnDragAngle;
@optional
-(NSString *)identifier;
@optional
-(NSString *)benchItemDraggingImage;

// TODO: create a better name for this.
@optional
-(NSArray *)appliers;
@end


@class NFBenchItemView;
@protocol NFBenchItemViewDelegate <NFDraggableViewDelegate>

@optional
-(void)didSelectBenchItemView:(NFBenchItemView *)benchItemView;


@end

/**
 This class is intended to be a component of a scrollable bench system. The most parent class in this system is NFScrollableView which handles a user's left and right scrolling as well as the layout of the various benches (implemented using NFBenchView) that can be scrolled through in a paginated manner. 
 Each instance of NFBenchView holds items that are implemented using this class (NFBenchItemView). This class defines and implements the various behaviors of bench items such as dragging, clicking, etc. Such behavior can be configured by settings certain properties (such as 'clickable', 'draggable'). 
 A reference to a data object (id<BenchItem> item) that contains relevant associated data can be used to help match up user events interacting with these items and elements outside of the scrollable bench view system (such as applying makeup to a face etc).

 */
@interface NFBenchItemView : NFDraggableView{
    
}

/**
 *  Important: do not set this - instead set delegate of NFBenchView to receive events. 
 *  TODO: make this private somehow. 
 */
@property (nonatomic, unsafe_unretained) id <NFBenchItemViewDelegate> delegate;

@property (nonatomic, unsafe_unretained) NFBenchView *benchView;


/**
 * Determines whether bench item can be dragged
 */
@property BOOL draggable;

/**
 * Determines whether bench item can be clicked
 */
@property BOOL clickable;

/**
 * Although this class should only ever be used to represent a singular item, there may be cases in which the user is able to choose between a number of different appliers (using some UI system separate from the Scrollable Bench Item system. 
 In these cases, an image index for the bench item can be set using this property; e.g. if you have 3 different color eye-liners appliers to choose from this property will indicate which one is currently selected. 
 TODO: May update name of this property to avoid confusion. 
 */
@property int selectedItemIndex;

/**
 * A reference to a data object (id<BenchItem> item) that contains relevant associated data can be used to help match up user events interacting with these items and elements outside of the scrollable bench view system (such as applying makeup to a face etc).
 */
@property (nonatomic, strong) id<BenchItem> item;

@property (nonatomic, copy) NSString *identifier;

/**
 * The icon view is used for such things as adding a lock (if the bench item is puchasable and not yet purchased), download icon (if associated content for purchase needs to be downloaded), or downloading activity view (if associated purchase content is downloading).
 */
@property (nonatomic, strong) UIView *iconView;

/**
 * Handles clicks (e.g. when bench view is clickable). 
 */
@property (nonatomic, strong) UIButton *button;

/**
 * NEW: in progress - determines whether bench item is locked
 */
@property BOOL locked;

/**
 * NEW: lock image name
 */
@property (nonatomic, copy) NSString *lockImageName;




-(void)layout;
-(void)didSelectApplier:(id)sender;

-(void)makeClickable;
-(void)lock;
-(void)unlock;


#pragma mark Clone
-(NFBenchItemView *)clone;

@end
