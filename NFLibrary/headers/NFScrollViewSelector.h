//
//  NFScrollViewSelector.h
//
//
//

#import <UIKit/UIKit.h>
#import "NFProductDisplayerView.h"

@class NFDraggableView;

@class NFScrollViewSelector;
@protocol NFScrollViewSelectorDelegate <NFProductDisplayerViewDelegate>

@optional
-(void)scrollViewSelectorDidUpdateLayout:(NFScrollViewSelector *)scrollViewSelector;

@optional
-(void)didSelectScrollViewSelectorItem:(id)sender __attribute__((deprecated));
@optional
- (void)scrollViewSelectorViewDidScroll:(UIScrollView *)scrollView;
@optional
-(void)scrollViewSelectorDraggableViewDidBeginDragging:(NFDraggableView *)draggableView;
@optional
-(void)scrollViewSelectorDraggableViewDidContinueDragging:(NFDraggableView *)draggableView;
@optional
-(void)scrollViewSelectorDraggableViewDidEndDragging:(NFDraggableView *)draggableView;
@optional
-(void)scrollViewSelectorDraggableViewDidCancelDragging:(NFDraggableView *)draggableView;
@end

@class NFStore;
@class NFStoreViewController;
@class NFViewController;


@interface NFScrollViewSelector : UIView<NFProductDisplayerView>

/** @warning *Important:* When draggable, the view in which the selector sits needs to make itself the delegate and
 * handle drag begin/continue/end/cancel events with code to place draggable view on itself and then back to selector view.
 * Example: https://github.com/ninjafishstudios/cookiemaker/blob/develop/App/Classes/ViewControllers/CutOutShapesViewController.m
 */
@property BOOL draggable;

@property (nonatomic, unsafe_unretained) id <NFScrollViewSelectorDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIScrollView *scrollView;
@property int page;
@property int lockedIndex;
@property CGSize itemSize;
@property (nonatomic, copy) NSString *lockImageName;
@property (nonatomic, copy) NSString *backgroundImageName;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, strong, setter = productId:) NSString *productId;
@property (nonatomic, copy) NSString *swipeSoundName;
@property (setter = setDownloadedIndex:, getter = downloadedIndex) int downloadedIndex;
@property (nonatomic, copy) NSString *downloadImageName;
@property (nonatomic, strong, setter = viewController:) NFViewController *viewController;
@property (nonatomic, strong) NSMutableArray *draggableViews;
@property (nonatomic, strong) NSMutableArray *draggingImages;
@property (nonatomic, strong) NSMutableArray *itemViews;
@property BOOL shouldLayoutVertically;
@property BOOL scrollViewPreviewed;
@property CGFloat radiansToRotateViewBy;
@property BOOL isVisible;
@property CGRect originalFrame;
@property int downloadingIndex;
@property CGFloat spacing;
@property UIImageOrientation itemImageOrientation;

@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, strong) NSArray *itemsHighlightedState;

// TODO: clean this up.
@property (nonatomic, strong) NSMutableArray *buttons;


@property BOOL shouldDisplayItemsUsingButtonsOnly;

@property BOOL shouldHandleStorePurchasing __attribute__((deprecated));
@property (nonatomic, strong) NFStore *store __attribute__((deprecated));;
@property (nonatomic, strong, setter = storeViewController:) NFStoreViewController *storeViewController __attribute__((deprecated));



+(NFScrollViewSelector *)sharedInstance;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items lockedIndex:(int)lockedIndex;
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items store:(NFStore *)store storeViewController:(NFStoreViewController *)storeViewController productId:(NSString *)productId viewController:(NFViewController *)viewController shouldHandleStorePurchasing:(BOOL)shouldHandleStorePurchasing itemSize:(CGSize)itemSize;

#pragma mark Animations
-(void)previewScrollView;


#pragma mark Layout
-(void)layout;
-(CGRect)itemFrameForIndex:(int)index;
-(UIImageView *)iconImageViewWithImageName:(NSString *)imageName forView:(UIView *)view;

-(UIImageView *)iconImageViewWithImageName:(NSString *)imageName forView:(UIView *)view;

#pragma mark Events
-(void)itemSelected:(id)sender;

#pragma mark Data Functions
-(BOOL)doesSenderStillNeedToBeDownloaded:(id)sender;
-(BOOL)isSenderLocked:(id)sender;
-(BOOL)isSenderStillDownloading:(id)sender;
-(BOOL)isSenderAvailable:(id)sender;


-(BOOL)itemAtIndexStillNeedsToBeDownloaded:(int)index;
-(BOOL)isItemAtIndexLocked:(int)index;
-(BOOL)itemAtIndexIsDownloading:(int)index;
-(BOOL)isItemAtIndexAvailable:(int)index;

@end
