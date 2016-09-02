//
//  NFCookingViewController.h
//  
//
//  Created by Jeff Patternstein on 8/25/14.
//
//

#import "NFDragActionsViewController.h"
#import "NFViewControllerState.h"
#import "NFViewControllerStateComponent.h"


@interface NFCookingViewController : NFDragActionsViewController


#pragma mark States
@property (nonatomic, strong) NFViewControllerStateComponent *stateComponent;

//@property (nonatomic, strong) NSMutableArray *states;
//@property (nonatomic, strong) NFViewControllerState *currentState;


-(void)presentNextState;

@end
