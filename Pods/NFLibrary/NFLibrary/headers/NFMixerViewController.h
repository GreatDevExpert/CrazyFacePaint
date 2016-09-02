//
//  MixerViewController.h
//  Cupcake
//
//  Created by William Locke on 11/26/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//

#import "NFGameViewController.h"

@interface NFMixerViewController : NFGameViewController

typedef enum {
    MixerViewControllerStateDefault,
    MixerViewControllerStateMixerTurnedOff,
    MixerViewControllerStateTurnMixerOn,
    MixerViewControllerStateTurnMixerOff,
    MixerViewControllerStateMixing,
    MixerViewControllerStateDragMixerUp,
    MixerViewControllerStateCount
}MixerViewControllerState;

@property CGRect bowlImageViewStartingAnimationFrame;
@property CGRect bowlBackImageViewStartingAnimationFrame;


@property (nonatomic, strong) IBOutlet NFRotatableHandleView *rotatableMixerTop;
@property (nonatomic, strong) IBOutlet UIImageView *bowlImageView;
@property (nonatomic, strong) IBOutlet UIImageView *bowlBackImageView;
@property (nonatomic, strong) IBOutlet UIImageView *mixerTopImageView;
@property (nonatomic, strong) IBOutlet UIImageView *mixerBottomImageView;
@property (nonatomic, strong) IBOutlet UIImageView *textImageView;
@property (nonatomic, strong) IBOutlet UIImageView *mixerButtonImageView;
@property (nonatomic, strong) IBOutlet UIButton *mixerButton;
@property BOOL mixerIsOn;
@property BOOL shouldVibrate;
@property CGRect originalBowlImageViewFrame;
@property CGRect originalBowlBackImageViewFrame;
@property (nonatomic, strong) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, strong) NFAnimation *arrowAnimation;
@property (nonatomic, strong) IBOutlet NFAnimatedImageView *mixerHeadAnimatedImageView;


-(void)layout;

-(IBAction)mixerButtonPressed:(id)sender;

@end
