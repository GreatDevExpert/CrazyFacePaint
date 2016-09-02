//
//  NFDoctorViewController.h
//  App
//
//  Created by William Locke on 7/26/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFGameViewController.h"
#import "NFViewController+draggableViewHandlers.h"


@interface NFDoctorViewController : NFGameViewController

@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableTools;
@property (nonatomic, strong) NSArray *layerActionsForDraggableTools;
@property (nonatomic, strong) NSDictionary *accompanyingLayerActionsForDraggableTools;
@property (nonatomic, strong) NSDictionary *extraLayerActionsForDraggableTools;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *placedToolViews;
@property int characterViewMouthShowingTeeth;
@property (nonatomic, strong) UIImageView *toolTipImageView;
@property (nonatomic, strong) NSMutableArray *draggableToolLocks;

@property (nonatomic, strong) NFImageView *currentLayer;
@property LayerAction currentLayerAction;
@property (nonatomic, strong) NSArray *currentLayers;
@property (nonatomic, strong) NSArray *currentLayerActions;
@property (nonatomic, strong) NFEmitterLayer *currentEmitterLayer;
@property (nonatomic, strong) NFViewControllerPositionEmitterBlock positionEmitterBlock;
@property float alphaInterval;
@property CGPoint currentTouchPointOffset;


+(void)setToolTipFrame:(CGRect)toolTipFrame;


-(void)layout;
-(void)addConditionImageViewObjectsToImageViewObjects:(NSMutableArray *)imageViewObjects;
-(NSMutableArray *)characterImageViewObjects;

-(NSArray *)toolIdentifiers;
-(void)layoutInitialCharacterViewLayerStates;
-(NSDictionary *)accompanyingLayerActionsForDraggableTools;

-(NSArray *)layerActionsForDraggableTools;
-(void)layoutCharacter;
// Only need to specify which orderings need updating.
-(void)updateCharacterImageViewOrder:(NSArray *)characterImageViewOrderings;
-(void)layoutDraggableViews;


#pragma mark Data
-(NFDraggableView *)draggableViewForIdentifier:(NSString *)identifier;
-(LayerAction)layerActionForDraggableTool:(NFDraggableView *)draggableView;
-(NFImageView *)layerForDraggableTool:(NFDraggableView *)draggableView;


-(void)draggableViewPlaced:(NFDraggableView *)draggableView;

-(NSString *)activeImageNameForDraggableTool:(NFDraggableView *)draggableView;
-(NSString *)restingImageNameForDraggableTool:(NFDraggableView *)draggableView;

-(void)makeDraggableViewsDraggable:(BOOL)draggable except:(NFDraggableView *)draggableView;

#pragma mark Purchases
-(void)layoutLocksForDraggableViews;
-(void)lockDraggableTool:(NFDraggableView *)draggableTool;

#pragma mark Show / Hide
-(void)showTooltipForDraggableTool:(NFDraggableView *)draggableTool;

#pragma mark Animations
-(void)showXrayMachineWithImageName:(NSString *)imageName xrayImageName:(NSString *)xrayImageName xrayMachineDidAppear:(void (^ )())xrayMachineDidAppear xrayMachineDidDisappear:(void (^ )())xrayMachineDidDisappear;

#pragma mark --Tweezers
-(CGRect)tweezersFrameForDraggableView:(NFDraggableView *)draggableView atImageView:(NFImageView *)imageView;
-(void)pullOutTweezerItem:(NFImageView *)imageView withDraggableTweezers:(NFDraggableView *)draggableView didPullOut:(void (^ )())didPullOutCallback;
-(void)dropTweezerItem:(NFImageView *)imageView withDraggableTweezers:(NFDraggableView *)draggableView didDropItem:(void (^ )())didDropItemCallback;

-(NFEmitterLayer *)emitterLayerForDraggableView:(NFDraggableView *)draggableView;
-(void)positionEmitterLayer:(NFEmitterLayer *)emitterLayer forDraggableView:(NFDraggableView *)draggableView;

#pragma mark --place and return
-(float)placeAndReturnPauseDurationForDraggableView:(NFDraggableView *)draggableView;
-(void)placeAndReturnDraggableViewWillFloatBack:(NFDraggableView *)draggableView;
-(void)willPlaceDraggableView:(NFDraggableView *)draggableView;

#pragma mark --Touch Point
-(CGPoint)touchPointForTouches:(NSSet *)touches draggableTool:(NFDraggableView *)draggableView;
    
#pragma mark Delegates
#pragma mark <NFDraggableViewDelegate>
-(void)draggableViewDidBeginDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidContinueDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidEndDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidCancelDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;

@end
