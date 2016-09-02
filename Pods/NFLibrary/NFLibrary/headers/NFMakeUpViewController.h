//
//  NFMakeUpViewController.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFGameViewController.h"
#import "NFBenchViewObject.h"

@protocol NFMakeupSession <NSObject>

-(NSString *)characterImagesBaseFolderKeyPath;
-(NSString *)clothingImagesBaseFolderKeyPath;
-(NSNumber *)characterIndex;

@end

@interface NFMakeUpViewController : NFGameViewController

@property (nonatomic, strong) IBOutlet NFScrollableBenchView *scrollableBenchView;
@property (nonatomic, strong) NFScratchToRevealView *currentScratchableView;
@property CGPoint currentTouchPointOffset;
@property (nonatomic, strong) IBOutlet NFScrollViewSelector *sideScrollViewSelector;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableMakeupRemover;
@property (nonatomic, strong) NSMutableArray *currentScratchableViews;
@property (nonatomic, strong) IBOutlet UIView *guideViewForFaceArea;
@property CGRect percentageFrameForFaceArea;
@property (nonatomic, copy) NSString *currentTheme;

// Interactive Ads
@property (nonatomic, strong) UIImageView *firstBenchInteractiveAdImageView;
@property (nonatomic, strong) UIImageView *lastBenchInteractiveAdImageView;

-(void)layout;

-(NSMutableArray *)characterImageViewObjects;
-(NSArray *)characterViewIdentifiers;
-(void)layoutCharacter;
-(NSString *)benchItemKeyPathForIdentifier:(NSString *)identifier;
-(float)rotateOnDragAngleForIdentifier:(NSString *)benchItemIdentifier;
-(void)layoutScrollableBenchView;
-(void)updateScrollableBenchView;

-(CGPoint)topLeftOffsetForBenchViewObject:(NFBenchViewObject *)benchViewObject;
-(CGPoint)bottomRightOffsetForBenchViewObject:(NFBenchViewObject *)benchViewObject;

#pragma mark -- Interactive Ads --
-(void)layoutInteractiveAds;

#pragma mark -- Purchases -- 
-(NSString *)productIdForBenchView:(NFBenchView *)benchView;

#pragma mark Scrollable bench view
-(CGPoint)accessoryImageViewOffsetForBenchItemIdentifier:(NSString *)benchItemIdentifier;


-(IBAction)leftArrowButtonPressed:(id)sender;
-(IBAction)rightArrowButtonPressed:(id)sender;
#pragma mark Show / Hide
-(void)showSideScrollViewSelector;
-(void)hideSideScrollViewSelector;

-(CGPoint)offsetForBenchItemView:(NFBenchItemView *)benchItemView;

-(NSString *)thumbsKeyPathForIdentifier:(NSString *)identifier;
#pragma mark Delegates
#pragma mark <NFScrollableBenchView>
-(void)benchView:(NFBenchView *)benchView didSelectBenchItemView:(NFBenchItemView *)benchItemView;
-(void)benchItemViewDidBeginDragging:(NFBenchItemView *)benchItemView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)benchItemViewDidContinueDragging:(NFBenchItemView *)benchItemView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)benchItemViewDidEndDragging:(NFBenchItemView *)benchItemView touches:(NSSet *)touches withEvent:(UIEvent *)event;


#pragma mark Purchases
-(void)didCompletePurchase;

@end
