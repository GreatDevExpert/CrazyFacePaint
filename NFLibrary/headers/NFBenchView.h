//
//  NFBenchView.h
//  MakeupGirls
//
//  Created by William Locke on 2/22/13.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFImageView.h"
#import "NFProductDisplayerView.h"
#import "NFDraggableView.h"
#import "NFScrollViewSelector.h"
#import "NFBenchItemView.h"

@class NFScrollableBenchView;

@protocol NFBenchViewDelegate <NSObject, NFProductDisplayerViewDelegate>

-(void)benchItemViewDidBeginDragging:(NFBenchItemView *)benchItemView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)benchItemViewDidContinueDragging:(NFBenchItemView *)benchItemView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)benchItemViewDidEndDragging:(NFBenchItemView *)benchItemView touches:(NSSet *)touches withEvent:(UIEvent *)event;
@end

/**
 This class is intended to be a component of a scrollable bench system. The most parent class in this system is NFScrollableView which handles a user's left and right scrolling as well as the layout of the various benches (represented by this class) that can be scrolled through in a paginated manner.
 Each instance of NFBenchView holds items that are implemented using this class (NFBenchItemView).
 This class handles the layout of its sub-elements: NFBenchItemViews. And is a intermediary handler of certain events such as when bench items drag or are clicked etc. 
 */
@interface NFBenchView : UIView<NFProductDisplayerView, NFDraggableViewDelegate, NFProductDisplayerViewDelegate, NFBenchItemViewDelegate>


@property (nonatomic, unsafe_unretained) IBOutlet id <NFBenchViewDelegate> delegate;
@property (nonatomic, strong) IBOutletCollection(NFBenchItemView) NSMutableArray *benchItemViews;

/**
 *  Indicates which bench item is selected (selection includes dragging, clicking etc.). This assumes only one bench item can be selected at a time. 
 */
@property int selectedItemIndex;
@property (nonatomic, copy) NSString *identifier;

/**
 *  Reference to containing view that contains a number of NFBenchViews (of which this instance would be one). 
 */
@property (nonatomic, unsafe_unretained) NFScrollableBenchView *scrollableBenchView;


#pragma mark NFProductDisplayerView
/**
 *  Refer to NFProductDisplayerView protocol
 */
@property (nonatomic, copy) NSString *productId;
/**
 *  Refer to NFProductDisplayerView protocol 
 */
@property int lockedIndex;
/**
 *  Refer to NFProductDisplayerView protocol 
 */
@property int downloadingIndex;
/**
 *  Refer to NFProductDisplayerView protocol 
 */
@property int downloadedIndex;

@property (nonatomic, copy) NSString *lockImageName;


#pragma mark STATIC FUNCTIONS
+(void)setLockImageName:(NSString *)lockImageName;


#pragma mark INSTANCE FUNCTIONS
-(void)benchView:(NFBenchView *)benchView didSelectBenchItemView:(NFBenchItemView *)benchItemView;

#pragma mark Data
/**
 *  Returns the bench item view belonging to this bench view with the given identifier. 
 */
-(NFBenchItemView *)benchItemViewWithIdentifier:(NSString *)identifier;



#pragma mark Animation
-(void)stopSelectionAnimations;

#pragma mark Animations
-(void)endSelectionAnimation DEPRECATED_ATTRIBUTE;


-(void)draggableViewDidCancelDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;


#pragma mark Clone
-(NFBenchView *)clone;

@end
