//
//  NFScrollableBenchView.h
//  MakeupGirls
//
//  Created by William Locke on 2/22/13.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFProductDisplayerView.h"
#import "NFBenchView.h"
#import "NFBenchItemView.h"


@class NFScrollableBenchView;
@protocol NFScrollableBenchViewDelegate <NFProductDisplayerViewDelegate, NFBenchViewDelegate>

@required
-(void)benchView:(NFBenchView *)benchView didSelectBenchItemView:(NFBenchItemView *)benchItemView;
@optional
-(void)scrollableBenchView:(NFScrollableBenchView *)scrollableBenchView scrollViewDidScroll:(UIScrollView *)scrollView;

@optional
-(void)scrollableBenchViewWillChangePage:(NFScrollableBenchView *)scrollableBenchView;

@end


/**
 Creates designed for displaying a bench type along the bottom of the screen that may have items
 on it that behave in certain ways. This view manages an array of NFBenchViews that can swiped
 through with pagination.
  
 */
@interface NFScrollableBenchView : UIView<UIScrollViewDelegate, NFProductDisplayerView>

@property (nonatomic, unsafe_unretained) IBOutlet id <NFScrollableBenchViewDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, strong) IBOutletCollection(NFBenchView) NSMutableArray *benchViews;
@property int page;
@property (nonatomic, strong) IBOutlet UIButton *leftArrowButton;
@property (nonatomic, strong) IBOutlet UIButton *rightArrowButton;


#pragma mark --NFProductDisplayerView
@property (nonatomic, copy) NSString *productId;
@property int lockedIndex;
@property int downloadingIndex;
@property int downloadedIndex;

@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

@property (nonatomic, copy) NSString *swipeSoundName;

@property (nonatomic, copy) NSString *identifier;

#pragma mark Layout
-(void)layout;
-(void)layoutBenchViews;
-(void)sizeScrollView;
-(void)layoutBenchViewFrameAtIndex:(int)index;
-(void)layoutBenchViewAtIndex:(int)index;
-(void)layoutPageControl;
-(void)layoutArrowButtons;

-(void)updateArrowButtons;

#pragma mark Events
-(void)benchView:(NFBenchView *)benchView didSelectBenchItemView:(NFBenchItemView *)benchItemView;
-(NFBenchItemView *)benchItemViewWithIdentifier:(NSString *)identifier;
-(IBAction)leftArrowButtonPressed:(id)sender;
-(IBAction)rightArrowButtonPressed:(id)sender;

#pragma mark Animations
-(void)previewScrollView:(void (^ )(BOOL finished))completionHandler;
-(void)previewScrollView:(void (^ )(BOOL finished))completionHandler shouldOnlyPreviewOnce:(BOOL)shouldOnlyPreviewOnce;
-(void)stopSelectionAnimations;

// TODO: add animated 
-(void)scrollToPage:(int)page animated:(BOOL)animated;

#pragma mark Data
-(NFBenchView *)benchViewWithIdentifier:(NSString *)identifier;



-(void)endSelectionAnimations;

@end
