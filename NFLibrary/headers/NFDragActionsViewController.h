//
//  NFDragActionsViewController.h
//  App
//
//  Created by William Locke on 7/26/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFGameViewController.h"
#import "NFViewController+draggableViewHandlers.h"
#import "NFChecklistView.h"
@class NFDragActionsViewController;

@protocol NFDragActionsViewControllerLayoutComponent <NFGameViewControllerLayoutComponent>

@optional
-(void)dragActionsViewController:(NFDragActionsViewController *)dragActionsViewController didLockDraggableView:(NFDraggableView *)draggableView withLockImageView:(UIImageView *)lockImageView;

@end

@interface NFDragActionsViewController : NFGameViewController

@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableViews;
@property (nonatomic, strong) NSArray *layerActionsForDraggableViews;
@property (nonatomic, strong) NSDictionary *accompanyingLayerActionsForDraggableViews;
@property (nonatomic, strong) NSDictionary *extraLayerActionsForDraggableViews;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *placedDraggableViews;
@property int characterViewMouthShowingTeeth;
@property (nonatomic, strong) UIImageView *toolTipImageView;

@property (nonatomic, strong) NFImageView *currentLayer;
@property LayerAction currentLayerAction;
@property (nonatomic, strong) NSArray *currentLayers;
@property (nonatomic, strong) NSArray *currentLayerActions;
@property (nonatomic, strong) NFEmitterLayer *currentEmitterLayer;
@property (nonatomic, strong) NFViewControllerPositionEmitterBlock positionEmitterBlock;
@property float alphaInterval;
@property CGPoint currentTouchPointOffset;
@property (nonatomic, strong) NSMutableArray *draggableViewLocks;

@property (nonatomic, strong) id<NFDragActionsViewControllerLayoutComponent> layoutComponent;
@property (nonatomic, strong) NFChecklistView *checklistView;

-(void)layout;

-(BOOL)shouldAddMultipleImageViewsForLayerAction:(LayerAction)layerAction toolIdentifier:(NSString *)toolIdentifier layers:(NSArray *)layers;
-(BOOL)layerShouldBeAnimatedForIdentifer:(NSString *)identifier;
-(void)addConditionImageViewObjectsToImageViewObjects:(NSMutableArray *)imageViewObjects;
-(NSMutableArray *)characterImageViewObjects;

-(NSArray *)draggableViewIdentifiers;
-(void)layoutInitialCharacterViewLayerStates;
-(NSDictionary *)accompanyingLayerActionsForDraggableViews;

-(NSArray *)layerActionsForDraggableViews;

//DOCUMENT: outline how to specify which image views in character view to make animated.
-(NSMutableArray *)characterImageViewObjects;
-(void)layoutCharacter;
// Only need to specify which orderings need updating.
-(void)updateCharacterImageViewOrder:(NSArray *)characterImageViewOrderings;
-(void)layoutDraggableViews;

#pragma mark Tool tip
-(CGRect)frameForTooltip;
-(void)showTooltipWithImageName:(NSString *)imageName;
-(void)hideTooltip;

#pragma mark Data
-(NFDraggableView *)draggableViewForIdentifier:(NSString *)identifier;
-(LayerAction)layerActionForDraggableView:(NFDraggableView *)draggableView;
-(NFImageView *)layerForDraggableView:(NFDraggableView *)draggableView;
-(NSArray *)layersForDraggableTool:(NFDraggableView *)draggableView;

-(void)draggableViewPlaced:(NFDraggableView *)draggableView;

-(NSString *)activeImageNameForDraggableView:(NFDraggableView *)draggableView;
-(NSArray *)activeImageNamesForDraggableView:(NFDraggableView *)draggableView;
-(NSString *)restingImageNameForDraggableView:(NFDraggableView *)draggableView;
-(UIView *)placedDraggableViewForDraggableView:(NFDraggableView *)draggableTool;

#pragma mark Animations
-(BOOL)shouldAnimateUponDragBegin:(NFDraggableView *)draggableView;

#pragma mark --Tweezers
-(CGRect)tweezersFrameForDraggableView:(NFDraggableView *)draggableView atImageView:(NFImageView *)imageView;
-(void)pullOutTweezerItem:(NFImageView *)imageView withDraggableTweezers:(NFDraggableView *)draggableView didPullOut:(void (^ )())didPullOutCallback;
-(void)dropTweezerItem:(NFImageView *)imageView withDraggableTweezers:(NFDraggableView *)draggableView didDropItem:(void (^ )())didDropItemCallback;

-(CGRect)stitchUpFrameForDraggableView:(NFDraggableView *)draggableView atImageView:(NFImageView *)imageView;

-(NFEmitterLayer *)emitterLayerForDraggableView:(NFDraggableView *)draggableView;
-(void)positionEmitterLayer:(NFEmitterLayer *)emitterLayer forDraggableView:(NFDraggableView *)draggableView;

#pragma mark --place and return
-(float)placeAndReturnPauseDurationForDraggableView:(NFDraggableView *)draggableView;
-(void)placeAndReturnDraggableViewWillFloatBack:(NFDraggableView *)draggableView;
-(void)willPlaceDraggableView:(NFDraggableView *)draggableView;
#pragma mark --LayerActionPlaceAnimateLayerAndReturn
-(void)animatedLayer:(NFAnimatedImageView *)animatedImageView forDraggableViewDidStopAnimating:(NFDraggableView *)draggableView;

#pragma mark --Scooper
-(void)scooperDidEmpty;
-(void)scooper:(NFDraggableView *)draggableView didScoopContainerAtIndex:(int)index;

#pragma mark --Touch Point
-(CGPoint)touchPointForTouches:(NSSet *)touches draggableView:(NFDraggableView *)draggableView;

-(BOOL)shouldAnimateDraggableViewOnDrag:(NFDraggableView *)draggableView;

-(void)didCompleteActionForDraggableView:(NFDraggableView *)draggableView;

-(float)closestDistanceForDraggableView:(NFDraggableView *)draggableView;

#pragma mark Delegates
#pragma mark <NFDraggableViewDelegate>
-(void)draggableViewDidBeginDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidContinueDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidEndDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidCancelDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;



#pragma mark Draggable
-(BOOL)isDraggableViewAnItemToBeLocked:(NFDraggableView *)draggableView;


@end
