//
//  DecorateCookiesViewController.h
//
//  Created by William Locke on 9/17/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFGameViewController.h"
#import "NFUndoRedo.h"

@protocol TapToEatViewController <NSObject>

@property (nonatomic, strong) UIView *candlesView;

@end

@protocol NFDecorateControllerSession <NFGameSession>

-(NSMutableDictionary *)indexesOfChooseItems;

-(void)setTapToEatBackgroundImage:(UIImage *)tapToEatBackgroundImage;
-(void)setTapToEatConsumableImage:(UIImage *)tapToEatConsumableImage;
-(void)setTapToEatNonConsumableImage:(UIImage *)tapToEatNonConsumableImage;

@end


typedef enum {
    NFDecorateItemTypeNone,
    NFDecorateItemTypeCandle,
    NFDecorateItemTypeDraggable,
    NFDecorateItemTypeStampable,
    NFDecorateItemTypeScratchable
}NFDecorateItemType;


//! Subclasses ViewController - for faster setup of common UI elements
//  such as loading indicators, background image view, controls layer.
@interface NFDecorateViewController : NFGameViewController

@property (nonatomic, strong) id<NFDecorateControllerSession> sharedSession;  // Static object that holds a bunch of shared data that persists across all game view controllers
@property (nonatomic, strong) id retainedBlock;
@property (nonatomic, strong) UIView *touchResponderView;
@property CGRect griddedSelectorViewFrame;
//@property (nonatomic, strong) NFDecorateItemType _decorateItemType;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *consumableView;
@property (nonatomic, strong) UIView *nonConsumableView;
@property (nonatomic, strong) UIView *candlesView;
@property (nonatomic, strong) NFUndoRedo *undoRedo;

@property (nonatomic, strong) IBOutlet UIImageView *itemToDecorateImageView;
@property (nonatomic, strong) IBOutlet NFImageView *plateImageView;
@property (nonatomic, strong) IBOutlet NFImageView *strawImageView;
@property (nonatomic, strong) IBOutlet NFScrollViewSelector *topBarScrollViewSelector;
@property (nonatomic, strong) IBOutlet UIImageView *topBarImageView;
@property (nonatomic, strong) NSArray *topBarButtonImageNames;

@property (nonatomic, strong) NFGriddedSelectorView *griddedSelectorView;
@property (nonatomic, strong) IBOutlet NFScrollViewSelector *thumbsScrollViewSelector;
@property Class productDisplayerViewClassToUseForThumbs;

@property NFDecorateItemType decorateItemType;

#pragma mark Layout Functions
-(void)layout;
-(void)layoutExtras;
-(void)layoutTopBar;

-(NSArray *)thumbImageNamesForItemIdentifier:(NSString *)itemIdentifier;
-(NSArray *)itemImageNamesForItemIdentifier:(NSString *)itemIdentifier;
-(NFDecorateItemType)decorateItemTypeForItemIdentifier:(NSString *)itemIdentifier;

-(UIView *)addScratchableViewWithImageName:(NSString *)imageName frame:(CGRect)frame toView:(UIView *)view withItemIdentifier:(NSString *)itemIdentifier;


@end
