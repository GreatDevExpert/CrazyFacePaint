//
//  NFWashTheClothesViewController.h
//
//  Created by William Locke on 9/17/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//
/** 
 *  Steps to subclass:
 *  1. ensure layout is called in child and call [super layout] if overridden;
 */

#import <UIKit/UIKit.h>
#import "NFGameViewController.h"

//! Subclasses ViewController - for faster setup of common UI elements
//  such as loading indicators, background image view, controls layer.
@interface NFWashTheClothesViewController : NFGameViewController

@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableClothes;
@property (nonatomic, strong) IBOutlet NFImageView *dirtyClothesBasketBackImageView;
@property (nonatomic, strong) IBOutlet NFImageView *dirtyClothesBasketFrontImageView;
@property (nonatomic, strong) IBOutlet NFImageView *washingMachineImageView;
@property (nonatomic, strong) IBOutlet NFImageView *ironingBoardImageView;

@property (nonatomic, strong) IBOutlet NFAnimatedImageView *animatedWashingMachineDoorImageView;

@property (nonatomic, strong) IBOutlet NFDraggableView *draggableSoapBottle;
@property (nonatomic, strong) IBOutlet NFImageView *spinningWetClothesImageView;
@property (nonatomic, strong) IBOutlet NFImageView *soapDrawerImageView;
@property (nonatomic, strong) IBOutlet NFDraggableView *guideViewForClothingItemInWashingMachine;
@property (nonatomic, strong) IBOutlet NFDraggableView *guideViewForPourSoapBottle;

@property (nonatomic, strong) IBOutlet UIButton *washingMachineButton;

-(IBAction)ironButtonPressed:(id)sender;

-(IBAction)washingMachineButtonPressed:(id)sender;


@end
