//
//  NFShrinkingScrollViewSelector.h
//  Pods
//
//  Created by William Locke on 3/8/13.
//
//

#import <UIKit/UIKit.h>
@class NFShrinkingScrollViewSelector;
@protocol NFShrinkingScrollViewSelectorDelegate <NSObject>
-(void)shrinkingScrollViewSelector:(NFShrinkingScrollViewSelector *)shrinkingScrollViewSelector didSelectItem:(id)sender;

@end

@interface NFShrinkingScrollViewSelector : UIView

@property (nonatomic, unsafe_unretained) id<NFShrinkingScrollViewSelectorDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIScrollView *scrollView;
@property CGSize viewSize;
@property int page;
@property (nonatomic, strong) NSMutableArray *itemViews;

/**
 *  Right now is functions somewhat in reverse and is not really a percentage. Basically 0.88 is the default and larger numbers make views more spread out, smaller numbers make closer together. 
 */
@property CGFloat percentageCondensed;

@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

-(void)layout;


@end
