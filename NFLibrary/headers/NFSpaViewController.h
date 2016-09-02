//
//  NFSpaViewController.h
//  Pods
//
//  Created by William Locke on 8/26/14.
//
//

#import "NFGameViewController.h"
#import "NFViewControllerDragActionsComponent.h"

/** 
    Steps to implement:
        - Create NFScrollableBenchView in .xib and link its outlet to self.scrollableBenchView
        - Make the scrollableBenchView the position and size you want it in the xib.
        - Call [self layout] from child class.
 */
@interface NFSpaViewController : NFGameViewController

@property (nonatomic, strong) IBOutlet NFViewControllerDragActionsComponent *dragActionsComponent;
@property (nonatomic, strong) IBOutlet NFScrollableBenchView *scrollableBenchView;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableWaterShower;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *sideBarDraggableViews;
@property (nonatomic, strong) NFAnimatedImageView *animatedHairDryerWindImageView;

// Adding optional theme value. If current theme isn't set then assumed that folder structure does
// not include themes
@property (nonatomic, strong) NSString *currentTheme;
@property (nonatomic, strong) UIImageView *benchInteractiveAdImageView;

// Interactive Ads
@property (nonatomic, strong) UIImageView *firstBenchInteractiveAdImageView;
@property (nonatomic, strong) UIImageView *lastBenchInteractiveAdImageView;


-(void)layout;

#pragma mark -- Interactive Ads --
-(void)layoutInteractiveAds;

-(NFDraggableView *)sideBarDraggableViewWithIdentifier:(NSString *)identifier;
-(void)layoutDragActionsComponent;
-(NSArray *)scrollableBenchViewIdentifiers;
-(void)layoutScrollableBenchView;
-(void)updateScrollableBenchView;
-(void)addConditionsToCharacterView;

#pragma mark -- SIDE BAR ITEMS --
-(NSArray *)lockedSideBarItemIdentifiers;
-(NSArray *)sideBarItemIdentifiers;
-(NSString *)productIdForSideBarDraggableView:(NFDraggableView *)draggableView;
-(void)layoutSideBarDraggableViews;

#pragma mark Delegates
#pragma mark <NFBenchItemViewDelegate>
-(void)benchItemViewDidBeginDragging:(NFBenchItemView *)benchItemView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)benchItemViewDidContinueDragging:(NFBenchItemView *)benchItemView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)benchItemViewDidEndDragging:(NFBenchItemView *)benchItemView touches:(NSSet *)touches withEvent:(UIEvent *)event;

#pragma mark <NFDraggableViewDelegate>
-(void)draggableViewDidBeginDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidContinueDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidEndDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;


#pragma mark <NFViewControllerDragActionsComponent>
-(NSArray *)dragActionsComponentLayerActionsForDraggableViews;
-(LayerAction)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent layerActionForDraggableView:(NFDraggableView *)draggableView;

// Not implemented - remove
-(NSDictionary *)accompanyingLayerActionsForDraggableViews;
-(void)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent didAddConditionsToCharacterView:(NFCharacterView *)characterView;
-(void)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent didPlaceDraggableView:(NFDraggableView *)draggableView;
-(void)dragActionsComponentDidLayoutDraggableViews;
-(void)dragActionsComponentWillLayoutDraggableViews;
-(NFEmitterLayer *)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent emitterLayerForDraggableView:(NFDraggableView *)draggableView;
-(void)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent positionEmitterLayer:(NFEmitterLayer *)emitterLayer forDraggableView:(NFDraggableView *)draggableView;


@end
