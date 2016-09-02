//
//  NFViewControllerDragActionsComponent.h
//  Pods
//
//  Created by William Locke on 8/26/14.
//
//

#import "NFGameViewController.h"
#import "NFViewController+draggableViewHandlers.h"
@class NFViewControllerDragActionsComponent;
@protocol NFViewControllerDragActionsComponentDelegate <NSObject>


@optional
-(CGRect)dragActionsComponentDidCreateTweezersFrame:(CGRect)tweezersFrame forDraggableView:(NFDraggableView *)draggableView atImageView:(NFImageView *)imageView;

@optional
-(NSArray *)dragActionsComponentLayerActionsForDraggableViews;

@optional
-(LayerAction)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent layerActionForDraggableView:(NFDraggableView *)draggableView;

@optional
-(void)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent willAddConditionsToCharacterView:(NFCharacterView *)characterView;

@optional
-(void)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent didAddConditionsToCharacterView:(NFCharacterView *)characterView;

@optional
-(void)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent didPlaceDraggableView:(NFDraggableView *)draggableView;

@optional
-(void)dragActionsComponentDidLayoutDraggableViews;

@optional
-(void)dragActionsComponentWillLayoutDraggableViews;

@optional
-(NFEmitterLayer *)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent emitterLayerForDraggableView:(NFDraggableView *)draggableView;

@optional
-(void)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent positionEmitterLayer:(NFEmitterLayer *)emitterLayer forDraggableView:(NFDraggableView *)draggableView;

@optional
-(void)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent didClickDraggableView:(NFDraggableView *)draggableView;

@optional
-(void)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent didFloatBackDraggableView:(NFDraggableView *)draggableView;

@optional
-(float)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent placeDraggableViewWhenCloserThan:(NFDraggableView *)draggableView;
@optional
-(float)dragActionsComponent:(NFViewControllerDragActionsComponent *)dragActionsComponent closestDistanceForDraggableView:(NFDraggableView *)draggableView;


@end


@interface NFViewControllerDragActionsComponent : NSObject


@property (nonatomic, unsafe_unretained) id<NFViewControllerDragActionsComponentDelegate> delegate;
@property (nonatomic, strong) NFGameViewController *viewController;
// View Controller Properties. 
@property (nonatomic, strong) UIView *view;
@property (nonatomic, copy) NSString *baseFolderKeyPath;
@property (nonatomic, strong) NSDictionary *imagesDictionary;
@property (nonatomic, strong) NFCharacterView *characterView;


@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableViews;
@property (nonatomic, strong) NSArray *layerActionsForDraggableViews;
@property (nonatomic, strong) NSDictionary *accompanyingLayerActionsForDraggableViews;
@property (nonatomic, strong) NSDictionary *extraLayerActionsForDraggableViews;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *placedDraggableViews;
@property int characterViewMouthShowingTeeth;
@property (nonatomic, strong) UIImageView *toolTipImageView;
@property (nonatomic, strong) UIImageView *instructionsImageView;

@property (nonatomic, strong) NFImageView *currentLayer;
@property LayerAction currentLayerAction;
@property (nonatomic, strong) NSArray *currentLayers;
@property (nonatomic, strong) NSArray *currentLayerActions;
@property (nonatomic, strong) NFEmitterLayer *currentEmitterLayer;
@property (nonatomic, strong) NFViewControllerPositionEmitterBlock positionEmitterBlock;
@property float alphaInterval;
@property CGPoint currentTouchPointOffset;


// TODO: Maybe remove this since drag actions component will be implemented
// in IBAction
- (id)initWithViewController:(NFGameViewController *)viewController;

-(void)layoutWithViewController:(NFGameViewController *)viewController;
-(void)layout;

-(void)addConditionsToCharacterView:(NFCharacterView *)characterView;
-(void)addConditionsToCharacterView:(NFCharacterView *)characterView withToolsKeyPath:(NSString *)toolsKeyPath;

-(void)addConditionImageViewObjectsToImageViewObjects:(NSMutableArray *)imageViewObjects;


-(NSArray *)draggableViewIdentifiers;
-(NSArray *)draggableViewIdentifiersForToolsKeyPath:(NSString *)toolsKeyPath;
-(void)layoutInitialCharacterViewLayerStates;
-(NSDictionary *)accompanyingLayerActionsForDraggableViews;

-(NSArray *)layerActionsForDraggableViews;
-(NSArray *)layersForDraggableTool:(NFDraggableView *)draggableView;

-(void)layoutDraggableViews;


#pragma mark Data
-(NFDraggableView *)draggableViewForIdentifier:(NSString *)identifier;
-(LayerAction)layerActionForDraggableView:(NFDraggableView *)draggableView;
-(NFImageView *)layerForDraggableView:(NFDraggableView *)draggableView;
-(NSArray *)layerActionsForDraggableTool:(NFDraggableView *)draggableView;

-(void)draggableViewPlaced:(NFDraggableView *)draggableView;

-(NSString *)activeImageNameForDraggableView:(NFDraggableView *)draggableView;
-(NSString *)restingImageNameForDraggableView:(NFDraggableView *)draggableView;
-(UIView *)placedDraggableViewForDraggableView:(NFDraggableView *)draggableTool;

#pragma mark Animations

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

#pragma mark --Scooper
-(void)scooperDidEmpty;
-(void)scooper:(NFDraggableView *)draggableView didScoopContainerAtIndex:(int)index;

#pragma mark --Touch Point
-(CGPoint)touchPointForTouches:(NSSet *)touches draggableView:(NFDraggableView *)draggableView;

#pragma mark Delegates
#pragma mark <NFDraggableViewDelegate>
-(void)draggableViewDidBeginDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidContinueDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidEndDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidCancelDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;


@end
