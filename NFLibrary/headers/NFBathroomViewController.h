//
//  BathroomViewController.h
//  BabyDayCare
//
//  Created by William Locke on 7/21/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFGameViewController.h"
#import "NFViewController+draggableViewHandlers.h"

// TODO: increment minor version number for NFLibrary. 
@interface NFBathroomViewController : NFGameViewController

@property (nonatomic, strong) NFCharacterView *bathtubItemView;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *tubBubblesButtons;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *tubFlowersButtons;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *tubWaterButtons;
@property (nonatomic, strong) IBOutlet UIButton *rugButton;
@property (nonatomic, strong) IBOutlet UIButton *tubButton;

@property (nonatomic, strong) IBOutlet NFDraggableView *draggableBlowDryer;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableTowel;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableLoofah;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableSponge;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableSoap;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableShampoo;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableShower;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableToothbrush;
@property (nonatomic, strong) IBOutlet UIImageView *toothbrushHolderImageView;
@property (nonatomic, strong) IBOutlet UIImageView *soapHolderImageView;
@property (nonatomic, strong) IBOutlet NFAnimatedImageView *animatedBlowerDryerWind;
@property (nonatomic, strong) IBOutlet UIButton *shampooBottleButton;

@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableToys;

@property (nonatomic, strong) NSArray *currentLayers;
@property (nonatomic, strong) NSArray *currentLayerActions;
@property (nonatomic, strong) NFEmitterLayer *currentEmitterLayer;
@property (nonatomic, strong) NFViewControllerPositionEmitterBlock positionEmitterBlock;


-(void)layout;
-(void)layoutBathtub;
-(void)layoutCharacter;
-(void)layoutDraggableViews;


-(IBAction)tubItemButtonPressed:(id)sender;
-(IBAction)tubButtonPressed:(id)sender;
-(IBAction)rugButtonPressed:(id)sender;

-(IBAction)shampooBottleButtonPressed:(id)sender;
    
    
#pragma mark Delegates
#pragma mark <NFDraggableViewDelegate>
-(void)draggableViewDidBeginDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidContinueDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidEndDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidCancelDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;

@end
