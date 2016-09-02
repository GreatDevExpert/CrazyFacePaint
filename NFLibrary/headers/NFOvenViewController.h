//
//  CookieOvenViewController.h
//
//  Created by William Locke on 9/17/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFGameViewController.h"

typedef enum {
    OvenViewControllerStateDefault,
    OvenViewControllerStateSlideOvenDoorClosed,
    OvenViewControllerStateSlideOvenDoorOpen,
    OvenViewControllerStateTurnOvenOn,
    OvenViewControllerStateCooking,
    OvenViewControllerStateOvenTurnedOff,
    OvenViewControllerStateFinal,
    OvenViewControllerStateCount
}OvenViewControllerState;


@protocol NFOvenViewControllerSession <NFGameSession>

-(NSMutableDictionary *)indexesOfChooseItems;

@end



//! Subclasses ViewController - for faster setup of common UI elements
//  such as loading indicators, background image view, controls layer.
@interface NFOvenViewController : NFGameViewController

@property (nonatomic, strong) id<NFOvenViewControllerSession> sharedSession;  // Static object that holds a bunch of shared data that persists across all game view controllers
@property (nonatomic, strong) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, strong) IBOutlet UIImageView *ovenDoorImageView;
@property (nonatomic, strong) IBOutlet UIButton *ovenButton;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableOvenTray;
@property (nonatomic, strong) IBOutlet UIView *guideViewForOvenTrayInOven;

@property (nonatomic, strong) NSString *imageNameForOvenDoorOpen;
@property (nonatomic, strong) NSString *imageNameForOvenDoorClosedOn;
@property (nonatomic, strong) NSString *imageNameForOvenDoorClosedOff;
@property BOOL cooking;
@property BOOL ovenIsOn;

-(IBAction)ovenButtonPressed:(id)sender;

-(void)layout;

-(void)bakeOvenItems:(void (^ )(BOOL finished))completionHandler;

@end
