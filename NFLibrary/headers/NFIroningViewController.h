//
//  LaundreyRoomIroningBoardViewController.h
//
//  Created by William Locke on 9/17/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFGameViewController.h"

//! Subclasses ViewController - for faster setup of common UI elements
//  such as loading indicators, background image view, controls layer.
@interface NFIroningViewController : NFGameViewController

@property (nonatomic, strong) IBOutlet NFDraggableView *draggableIron;
@property (nonatomic, strong) IBOutlet NFImageView *clothingItemImageView;
@property (nonatomic, strong) IBOutlet NFImageView *wrinkleLayerImageView;
@property (nonatomic, strong) IBOutlet NFImageView *ironingBoardImageView;

@property (nonatomic, strong) NFScratchToRevealView *scratchableWrinkleLayer;
@property (nonatomic, strong) NFEmitterLayer *steamEmitterLayer;

#pragma mark Layout Functions
-(void)layout;
-(NFScratchToRevealView *)createScratchableWrinkleLayerFromImageView:(NFImageView *)imageView;

#pragma mark Show / Hide
-(void)presentNextClothingItem;

#pragma mark Emitters
+(NFEmitterLayer *)powderTouchEmitter;
#pragma mark Delegates
-(void)draggableViewDidBeginDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidContinueDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidEndDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidCancelDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;


@end
