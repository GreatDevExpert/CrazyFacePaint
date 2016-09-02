//
//  MakeupViewController.h
//  KidsFacePaint
//
//  Created by William Locke on 10/28/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "ViewController.h"
#import "NFMakeUpViewController.h"
#import "ViewControllerComponent.h"
@class ScrollableBenchView;
@class NFCharacterView;

@interface MakeUpViewController : NFMakeUpViewController


@property (nonatomic, strong) IBOutlet NFControlButtonStripView *verticalControlButtonStripView;
@property (nonatomic, strong) IBOutlet NFControlButtonStripView *horizontalControlButtonStripView;
@property (nonatomic, strong) ViewControllerComponent *layoutComponent;
@property (nonatomic, strong) IBOutlet UIButton *unlockThemeButton;


-(BOOL)isMakeupItem:(NSString *)itemIdentifier;


@end
