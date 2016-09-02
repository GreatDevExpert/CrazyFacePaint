//
//  NFViewControllerStateComponent.h
//  Pods
//
//  Created by William Locke on 8/26/14.
//
//

#import <UIKit/UIKit.h>
#import "NFViewController.h"
#import "NFViewControllerState.h"

@class NFViewControllerStateComponent;

@protocol NFViewControllerStateComponentDelegate <NSObject>

-(void)viewControllerStateComponent:(NFViewControllerStateComponent *)stateComponent didPresentNextState:(NFViewControllerState *)state;
-(void)viewControllerStateComponent:(NFViewControllerStateComponent *)stateComponent willPresentNextState:(NFViewControllerState *)state;

@end

@interface NFViewControllerStateComponent : NSObject

@property (nonatomic, unsafe_unretained) id<NFViewControllerStateComponentDelegate> delegate;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NFViewController *viewController;

@property (nonatomic, strong) NSMutableArray *states;
@property (nonatomic, strong) NFViewControllerState *currentState;


-(void)presentNextState;
- (id)initWithViewController:(NFViewController *)viewController;


@end
