//
//  GiftTimer.m
//  HalloweenFacePaint
//
//  Created by William Locke on 10/9/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "GiftTimer.h"
#import "NFLocalPushNotification.h"

typedef void (^GiftTimerCompletionHandler)();

@interface GiftTimer()<NFTimerViewDelegate>{
    GiftTimerCompletionHandler _timerPressedCallback;
    GiftTimerCompletionHandler _timerDidCompleteCallback;
}

@end 

@implementation GiftTimer


- (instancetype)initWithViewController:(NFViewController *)viewController
{
    self = [super init];
    if (self) {
        _viewController = viewController;
    }
    return self;
}


-(void)displayWithCountdownLenthInSeconds:(int)countdownLengthInSeconds notifications:(NSArray *)notifications timerBackgroundImageName:(NSString *)timerBackgroundImageName completionHandler:(void (^ )())completionHandler timerPressedCallback:(void (^ )())timerPressedCallback{
    
    if([self hasTimeLeft]){
        NSLog(@"WARNING: timer has time left");
        return;
    }
    
    _timerPressedCallback = timerPressedCallback;
    
    self.notifications = notifications;
    
    if ([self.notifications count] == 0) {
        return;
    }
    
    UILocalNotification *notification = [self.notifications objectAtIndex:arc4random() % [self.notifications count]];
    
    
    if (notification == self.localNotification) {
        NSLog(@"WARNING: gift timer for this notification was just shown");
        return;
    }
    
    if (![notification isKindOfClass:[UILocalNotification class]]) {
        return;
    }

    NSDate *alertTime = [[NSDate date]
                         dateByAddingTimeInterval:countdownLengthInSeconds];
    notification.fireDate = alertTime;
    self.fireDate = alertTime;
    
    
    [self scheduleLocalNotification:notification];
    
    self.localNotification = notification;
    
    if(self.timerView){
        [self.timerView removeFromSuperview];
    }
    
    _timerDidCompleteCallback = completionHandler;
    
    self.timerView = [NFTimerView createTimerViewWithBackgroundImageName:timerBackgroundImageName countdownLengthInSeconds:countdownLengthInSeconds viewToAddTo:self.viewController.view fontName:nil completionHandler:^() {
        NSLog(@"completed");
        
        [self.timerView.label removeFromSuperview];

        if (_timerDidCompleteCallback) {
            _timerDidCompleteCallback();
        }
        
    }];
    
    self.timerView.delegate = self;
}

-(void)scheduleLocalNotification:(UILocalNotification *)localNotification{
    if ([[[UIApplication sharedApplication] scheduledLocalNotifications] count] > 0 && localNotification){
        [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
    }
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    if (![NFLocalPushNotification notificationsEnabledOnDevice]) {
        int secondsLeft = [localNotification.fireDate timeIntervalSinceDate:[NSDate date]];
        
        [self performSelector:@selector(didReceiveLocalNotification:) withObject:localNotification afterDelay:secondsLeft + 1];
    }

}

-(void)didReceiveLocalNotification:(UILocalNotification *)localNotification{
    
    [[[UIApplication sharedApplication] delegate] performSelector:@selector(application:didReceiveLocalNotification:) withObject:nil withObject:localNotification];
}

#pragma mark <NFTimerViewDelegate>
-(void)timerViewPressed:(NFTimerView *)timerView{
    
    if(_timerPressedCallback){
        _timerPressedCallback();
    }
}

-(void)silence{
    
    [self.timerView pause];
    
}

-(BOOL)hasTimeLeft{
    if (!self.fireDate) {
        return NO;
    }
    
    if ([self.fireDate timeIntervalSinceDate:[NSDate date]] > 0) {
        return YES;
    }
    return NO;
}

-(void)resume{

    if(self.localNotification){
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didReceiveLocalNotification:) object:self.localNotification];

        [self scheduleLocalNotification:self.localNotification];
        
        int secondsLeft = [self.localNotification.fireDate timeIntervalSinceDate:[NSDate date]];

        if(secondsLeft > 0){
            self.timerView.seconds = secondsLeft;
            [self.timerView start];
        }
    }
    
}




@end
