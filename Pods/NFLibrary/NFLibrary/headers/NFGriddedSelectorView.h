//
//  NFGriddedSelectorView.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NFProductDisplayerView.h"

@class NFStore;
@class NFStoreViewController;
@class NFViewController;

extern int const kNFGriddedSelectorViewDefaultNumberOfColumns;


@class NFGriddedSelectorView;
@protocol NFGriddedSelectorViewDelegate <NFProductDisplayerViewDelegate>
@optional
-(void)griddedSelectorView:(NFGriddedSelectorView *)griddedSelectorView didSelectItem:(id)sender;

@end

typedef void (^ NFGriddedSelectorViewAnimationCompletionHandler)(BOOL finished);

typedef enum NFGriddedSelectorViewAnimation : NSInteger NFGriddedSelectorViewAnimation;

typedef NS_ENUM(NSInteger, NFGriddedSelectorViewAnimation) {
    NFGriddedSelectorSlideInFromTop,
    NFGriddedSelectorSlideInFromBottom
};

// TODO: add a backgroundImageName property.
/**
 Creates a gridded view with an array of image names, where the user can select the item they want. Locks can be added, and items that need downloading can be specified.

     griddedSelectorView = [[NFGriddedSelectorView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height * 0.3, self.view.frame.size.width,self.view.frame.size.height * 0.7)];
     
     griddedSelectorView.productId = kProductIdUnlockPumpkinFeature;
     griddedSelectorView.items = @[@"image_name1", @"image_name2"];
     
     [griddedSelectorView layout];
     [_griddedSelectorView showInView:self.view animtionComplete:^(BOOL finished){
     
     }];
 
 
 Example: https://github.com/ninjafishstudios/Milkshake/blob/develop/App/Classes/ViewControllers/DecorateViewController.m
 
 TODO: decouple this from purchasing system. Have a purchase handler or something.
 
 */
@interface NFGriddedSelectorView : UIView<NFProductDisplayerView>


@property (nonatomic, unsafe_unretained) id <NFGriddedSelectorViewDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property int numberOfColumns;
@property int lockedIndex;
@property CGPoint marginPercentage;
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property BOOL isVisible;
@property BOOL shouldCrop;
@property CGRect croppingPercentageFrame;
@property (strong, nonatomic) NSString *productId;
@property (nonatomic, copy) NSString *downloadImageName;
@property (nonatomic, copy) NSString *lockImageName;
@property int downloadedIndex;

@property (nonatomic, strong) NFStore *store __attribute__((deprecated));;
@property (nonatomic, strong, setter = storeViewController:) NFStoreViewController *storeViewController __attribute__((deprecated));;
@property (nonatomic, strong, setter = viewController:) NFViewController *viewController;
@property BOOL shouldHandleStorePurchasing __attribute__((deprecated));;

@property BOOL shouldUseThumb;
@property int downloadingIndex;
@property BOOL shouldMakeItemSizeSquare;

@property BOOL shouldDrawBackground;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items numberOfColumns:(int)numberOfColumns;
-(void)layout;


-(void)showInView:(UIView *)view;
-(void)showInView:(UIView *)view animtionComplete:(NFGriddedSelectorViewAnimationCompletionHandler)animationCompleteHandler;
-(void)showInView:(UIView *)view animtionComplete:(NFGriddedSelectorViewAnimationCompletionHandler)animationCompleteHandler withAnimation:(NFGriddedSelectorViewAnimation)NFGriddedSelectorViewAnimation;

-(void)dismiss;
-(void)dismiss:(NFGriddedSelectorViewAnimationCompletionHandler)animationCompleteHandler;
-(void)dismiss:(NFGriddedSelectorViewAnimationCompletionHandler)animationCompleteHandler withAnimation:(NFGriddedSelectorViewAnimation)NFGriddedSelectorViewAnimation;

-(BOOL)isSenderLocked:(id)sender;
-(BOOL)isSenderStillDownloading:(id)sender;
-(BOOL)doesSenderStillNeedToBeDownloaded:(id)sender;
-(BOOL)isItemAtIndexLocked:(int)index;


-(BOOL)isSenderAvailable:(id)sender;
-(BOOL)isItemAtIndexAvailable:(int)index;

@end
