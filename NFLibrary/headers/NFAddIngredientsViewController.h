//
//  AddIngredientsViewController.h
//  BakeryFoodMaker
//
//  Created by William Locke on 1/22/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFGameViewController.h"

@protocol NFAddIngredientsControllerSession <NFGameSession>

-(NSMutableDictionary *)indexesOfChooseItems;

@end

@interface NFAddIngredientsViewController : NFGameViewController


@property (nonatomic, strong) id<NFAddIngredientsControllerSession> sharedSession;  // Static object that holds a bunch of shared data that persists across all game view controllers

@property (nonatomic, strong) IBOutlet UIView *guideViewForTippingPoint;
@property (nonatomic, strong) IBOutlet UIImageView *bowlImageView;
@property (nonatomic, strong) IBOutlet UIImageView *bowlBackImageView;
@property (nonatomic, strong) IBOutlet UIImageView *counterTopImageView;
@property (nonatomic, strong) IBOutlet UIImageView *butterPlateImageView;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableButterSticks;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableSugar;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableCakeMix;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableMeasuringCup;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableEgg;
@property CGPoint tippingPoint;

#pragma mark Layout
-(void)layout;


@end
