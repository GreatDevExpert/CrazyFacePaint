//
//  ViewController+frozen.h
//  BabyMommyStory
//
//  Created by William Locke on 6/6/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFGameViewController.h"
#import "NFImageViewObject.h"

typedef void (^ NFViewControllerPositionEmitterBlock)(NFEmitterLayer *emitterLayer, NFDraggableView *draggableView);

typedef enum {
    LayerActionDefault,
    LayerActionFadeIn,
    LayerActionFadeOut,
    LayerActionPlace,
    LayerActionPlaceAndAnimateToolThenAnimateLayer,
    LayerActionTweezers,
    LayerActionAnimate,
    LayerActionToothbrushToothpaste,
    LayerActionAnimateToolUponDragEnd,
    LayerActionDropClosestViews,
    LayerActionPlaceAndReturn,
    LayerActionPlaceAnimateLayerAndReturn,
    LayerActionStitchUp,
    LayerActionSyringe,
    LayerActionThermometer,
    LayerActionOintment,
    LayerActionClick,
    LayerActionFadeOutClosestView,
    LayerActionScooper,
}LayerAction;


@interface NFViewController (draggableViewHandlers)


@property (nonatomic, strong) NSArray *currentLayers;
@property (nonatomic, strong) NSArray *currentLayerActions;
@property (nonatomic, strong) NFEmitterLayer *currentEmitterLayer;
@property (nonatomic, strong) NFViewControllerPositionEmitterBlock positionEmitterBlock;


-(void)placeDraggableViewAtFrame:(CGRect)frame animateAndReturn:(NFDraggableView *)draggableView ;
-(void)placeDraggableViewAndReturn:(NFDraggableView *)draggableView fadeOutView:(NFImageView *)fadeOutView pauseDuration:(float)pauseDuration;

-(void)placeDraggableView:(NFDraggableView *)draggableView atFrame:(CGRect)frame draggableViewPlaced:(void (^ )())draggableViewPlacedCallback;

-(void)placeDraggableViewAndReturn:(NFDraggableView *)draggableView atFrame:(CGRect)frame pauseDuration:(float)pauseDuration draggableViewPlaced:(void (^ )())draggableViewPlacedCallback draggableViewWillFloatBack:(void (^ )())draggableViewWillFloatBackCallback;
-(void)placeDraggableViewAndReturn:(NFDraggableView *)draggableView atFrame:(CGRect)frame pauseDuration:(float)pauseDuration draggableViewPlaced:(void (^ )())draggableViewPlacedCallback draggableViewWillFloatBack:(void (^ )())draggableViewWillFloatBackCallback draggableViewDidFloatBack:(void (^ )())draggableViewDidFloatBackCallback;

-(void)dropViewOffScreen:(UIView *)view completionHandler:(void (^ )(BOOL finished))completionHandler;

-(void)fadeLayers:(NSArray *)layers accordingToLayerActions:(NSArray *)layerActions withMaxDistance:(float)maxDistance fromTouchPoint:(CGPoint )touchPoint;
-(void)fadeLayers:(NSArray *)layers accordingToLayerActions:(NSArray *)layerActions withMaxDistance:(float)maxDistance fromTouchPoint:(CGPoint )touchPoint  withAlphaInterval:(float)alphaInterval;

-(void)fadeLayer:(NFImageView *)layer accordingToLayerAction:(LayerAction)layerAction alphaInterval:(float)alphaInterval;
-(void)fadeLayer:(NFImageView *)layer accordingToLayerAction:(LayerAction)layerAction withMaxDistance:(float)maxDistance fromTouchPoint:(CGPoint)touchPoint alphaInterval:(float)alphaInterval;
-(void)fadeLayers:(NSArray *)layers accordingToLayerActions:(NSArray *)layerActions withMaxDistance:(float)maxDistance fromTouchPoint:(CGPoint )touchPoint  withAlphaInterval:(float)alphaInterval completionHandler:(void (^ )())completionHandler;

-(void)updateEmitterLayer:(NFEmitterLayer *)emitterLayer positionForDraggableView:(NFDraggableView *)draggableView usingPositionEmitterBlock:(NFViewControllerPositionEmitterBlock)positionEmitterBlock;

-(UIView *)closestSubviewInSubviews:(NSArray *)subviews toTouchPoint:(CGPoint)touchPoint lessThanDistance:(float)lessThanDistance partOfSubviewToMeasureTo:(UIViewContentMode)partOfSubviewToMeasureTo;
-(UIView *)closestSubviewInSubviews:(NSArray *)subviews toTouchPoint:(CGPoint)touchPoint lessThanDistance:(float)lessThanDistance;

-(void)placeDraggableView:(NFDraggableView *)draggableView insideFrame:(CGRect)frame whenCloserThan:(float)maxDistance draggableViewPlaced:(void (^ )())draggableViewPlacedCallback;

-(void)dropClosestView:(NSArray *)views toTouchPoint:(CGPoint )touchPoint whenCloserThan:(float)maxDistance viewDropped:(void (^ )())viewDroppedCallback;

-(void)showView:(UIView *)view whenCloserThan:(float)maxDistance toTouchPoint:(CGPoint )touchPoint;


-(CGPoint)correctedTouchPointForDraggableView:(NFDraggableView *)draggableView touches:(NSSet *)touches touchResponderView:(UIView *)touchResponderView offset:(CGPoint)offset;
-(CGPoint)correctedTouchPointForDraggableView:(NFDraggableView *)draggableView touches:(NSSet *)touches touchResponderView:(UIView *)touchResponderView offset:(CGPoint)offset showGuide:(BOOL)showGuide;


-(void)layoutDraggableViews:(NSArray *)draggableViews;
    
-(void)makeDraggableViews:(NSArray *)draggableViews enabled:(BOOL)enabled;
-(void)makeDraggableViews:(NSArray *)draggableViews enabled:(BOOL)enabled exceptDraggableViews:(NSArray *)exceptDraggableViews;

-(LayerAction)defaultLayerActionForDraggableView:(NFDraggableView *)draggableView;

-(void)lockDraggableView:(NFDraggableView *)draggableTool withLockImageName:(NSString *)lockImageName;
-(void)unlockDraggableView:(NFDraggableView *)draggableTool;

@end
