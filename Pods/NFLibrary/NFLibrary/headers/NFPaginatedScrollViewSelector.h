//
//  NFPaginatedScrollViewSelector.h
//
//
//

#import <UIKit/UIKit.h>
#import "NFProductDisplayerView.h"

@class NFPaginatedScrollViewSelector;
@protocol NFPaginatedScrollViewSelectorDelegate <NFProductDisplayerViewDelegate>

@optional
-(void)paginatedScrollViewSelector:(NFPaginatedScrollViewSelector *)paginatedScrollViewSelector didSelectPaginatedViewSelectorItem:(id)sender __attribute__((deprecated));
@optional
-(void)didSelectPaginatedViewSelectorItem:(id)sender __attribute__((deprecated));
@optional
- (void)paginatedViewSelectorViewDidScroll:(UIScrollView *)scrollView;
@optional
- (void)paginatedViewSelectorViewDidScrollLeftToNewPage:(UIScrollView *)scrollView;
@optional
- (void)paginatedViewSelectorViewDidScrollRightToNewPage:(UIScrollView *)scrollView;

@optional
- (void)paginatedViewSelectorRightArrowButtonPressed:(id)sender;
@optional
- (void)paginatedViewSelectorLeftArrowButtonPressed:(id)sender;
@end


@class NFStore;
// Should make NFStoreViewController -> NFNFStoreViewController
@class NFStoreViewController;
@class NFViewController;

/** 
 Creates a paginated scroll view with an array of image names. The user can swipe through, and select one of the items. Lock can be added, and purchasing can be handled by this class. 
 
 This object can be laid out in interface build with a UIView (change class name to this class), with
 things such as arrow buttons placed on the view and connected to IBOutlets of this class. 
 
 Then in code you can set the desired properties (items is required) then call [_paginatedScrollViewSelector layout].
 
     _paginatedScrollViewSelector.items = [self.imagesDictionary valueForKeyPath:@"select_flavor"];
     _paginatedScrollViewSelector.lockedIndex = [[[Store sharedInstance] productWithProductId:kProductIdNameUnlockAllFlavors].lockedIndex intValue];
     _paginatedScrollViewSelector.productId = kProductIdNameUnlockAllFlavors;
     _paginatedScrollViewSelector.downloadedIndex = [[Store sharedInstance] downloadedIndexForProduct:_paginatedScrollViewSelector.productId];
 
     // Delegate can be set either in code or in Interface Builder
     _paginatedScrollViewSelector.delegate = self;
     [_paginatedScrollViewSelector layout];
 
 
 Example: https://github.com/ninjafishstudios/Milkshake/blob/develop/App/Classes/ViewControllers/SelectCupViewController.m
 
 TODO: decouple this from purchasing system. Have a purchase handler or something. 

 */
@interface NFPaginatedScrollViewSelector : UIView<NFProductDisplayerView>{
    
}

@property (nonatomic, unsafe_unretained) IBOutlet id <NFPaginatedScrollViewSelectorDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIScrollView *scrollView;
@property int page;
@property (nonatomic, strong) IBOutlet UIButton *leftArrowButton;
@property (nonatomic, strong) IBOutlet UIButton *rightArrowButton;
@property (nonatomic, copy) NSString *lockImageName;
@property (nonatomic, copy) NSString *backgroundImageName;
@property (nonatomic, copy) NSString *swipeSoundName;
@property (nonatomic, copy) NSString *downloadImageName;

@property int lockedIndex;
@property int downloadingIndex;
@property (nonatomic, strong, setter = productId:) NSString *productId;
@property (setter = setDownloadedIndex:, getter = downloadedIndex) int downloadedIndex;

@property (nonatomic, strong) NFStore *store;
@property (nonatomic, strong, setter = storeViewController:) NFStoreViewController *storeViewController;
@property (nonatomic, strong, setter = viewController:) NFViewController *viewController;
@property BOOL shouldHandleStorePurchasing;
@property CGSize viewSize;

@property (nonatomic, strong) NSMutableArray *itemViews;


+(NFPaginatedScrollViewSelector *)sharedInstance;

-(void)layout;
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items lockedIndex:(int)lockedIndex;

#pragma mark Data Functions
-(BOOL)doesSenderStillNeedToBeDownloaded:(id)sender;
-(BOOL)isSenderStillDownloading:(id)sender;
-(BOOL)isSenderLocked:(id)sender;
-(BOOL)isSenderAvailable:(id)sender;


-(BOOL)itemAtIndexStillNeedsToBeDownloaded:(int)index;
-(BOOL)isItemAtIndexLocked:(int)index;
-(BOOL)itemAtIndexIsDownloading:(int)index;
-(BOOL)isItemAtIndexAvailable:(int)index;



-(void)layoutItems;
-(void)layoutItemAtIndex:(int)index;
-(UIView *)viewForIndex:(int)index;

@end
