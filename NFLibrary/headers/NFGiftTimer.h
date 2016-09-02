//
//  NFGiftTimer.h
//  HalloweenFacePaint
//
//  Created by William Locke on 10/9/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFTimerView.h"
#import "NFViewController.h"

@interface NFGiftTimer : NSObject

@property (nonatomic, strong) NFViewController *viewController;
@property (nonatomic, strong) IBOutlet NFTimerView *timerView;
@property (nonatomic, strong) NSArray *notifications;
@property (nonatomic, strong) UILocalNotification *localNotification;
@property (nonatomic, strong) NSDate *fireDate;


- (instancetype)initWithViewController:(NFViewController *)viewController;
-(void)displayWithCountdownLenthInSeconds:(int)countdownLengthInSeconds notifications:(NSArray *)notifications timerBackgroundImageName:(NSString *)timerBackgroundImageName completionHandler:(void (^ )())completionHandler timerPressedCallback:(void (^ )())timerPressedCallback;

// Stops timer view from calling tick callback function.
// Intended for when timer or screen with timer on it is not visible
-(void)silence;

// Resumes the seconds tick callback.
// Thus timer view count down label returns. 
-(void)resume;


-(BOOL)hasTimeLeft;

@end
