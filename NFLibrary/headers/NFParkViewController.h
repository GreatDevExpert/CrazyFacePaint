//
//  OutsideViewController.h
//  BabyDayCare
//
//  Created by William Locke on 7/21/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFGameViewController.h"

@interface NFParkViewController : NFGameViewController

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *droppingFruitButtons;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableFlowers;
@property (nonatomic, strong) IBOutlet UIImageView *slideImageView;
@property (nonatomic, strong) IBOutletCollection(NFAnimatedImageView) NSArray *animatedTappableImageViews;
@property (nonatomic, strong) NSMutableArray *tappableButtons;
@property (nonatomic, strong) IBOutlet NFImageView *trampolineImageView;


-(IBAction)droppingFruitButtonPressed:(id)sender;

-(void)layout;
-(void)layoutCharacter;
-(void)layoutTappableViews;
-(void)layoutDraggableViews;

#pragma mark IBActions
-(IBAction)droppingFruitButtonPressed:(id)sender;
-(IBAction)tappableButtonPressed:(id)sender;

#pragma mark Delegate
-(void)draggableViewDidBeginDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidContinueDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidEndDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidCancelDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
@end
