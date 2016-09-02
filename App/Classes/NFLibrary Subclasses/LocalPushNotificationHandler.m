//
//  LocalPushNotification.m
//  HighSchoolMakeover
//
//  Created by William Locke on 9/23/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "LocalPushNotificationHandler.h"
#import "NFDate.h"
#import "Session.h"

@implementation LocalPushNotificationHandler


+ (LocalPushNotificationHandler *)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

+(NSDate *)dateFromString:(NSString *)string{
    NSDate *date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	date = [df dateFromString:string];
    
    return date; 
}


-(NFLocalPushNotification *)notificationWithDuration:(NSString *)duration notInList:(NSMutableArray *)notifications{
    
    return nil;
}


-(void)scheduleNotifications{
    
    for(NFLocalPushNotification *localPushNotification in [NFLocalPushNotification localPushNotifications]){
        localPushNotification.flag = NO;
        //        localPushNotification.durationTillFireDate = @"P1S";
    }
    
    
    NSMutableArray *notifications = [[NSMutableArray alloc] init];
    float threshold = 0.5;
    if([self.masterViewController.store myPurchases] == 0){
        threshold = 0.3;
    }else{
        threshold = 0.9;
    }
    
    
    NFLocalPushNotification *notification = [NFLocalPushNotification notificationWithIdentifier:@"dailyNotification1"];
    if (notification){
        [notifications addObject:notification];
    }
    notification = [NFLocalPushNotification notificationWithIdentifier:@"dailyNotification2"];
    if (notification){
        [notifications addObject:notification];
    }
    notification = [NFLocalPushNotification notificationWithIdentifier:@"dailyNotification3"];
    if (notification){
        [notifications addObject:notification];
    }
    notification = [NFLocalPushNotification notificationWithIdentifier:@"dailyNotification4"];
    if (notification){
        [notifications addObject:notification];
    }
    notification = [NFLocalPushNotification notificationWithIdentifier:@"dailyNotification5"];
    if (notification){
        [notifications addObject:notification];
    }
    
    NSString *unlockCharactersProductId = [@"" stringByAppendingFormat:@"%@.unlock_all_characters", [[NSBundle mainBundle] bundleIdentifier]];
    if(![self.masterViewController.store productHasAlreadyBeenBought:unlockCharactersProductId]){
        NFLocalPushNotification *notification = [NFLocalPushNotification notificationWithIdentifier:@"bonusCharacter"];
        if (notification && arc4random() / ((pow(2, 32)-1)) < threshold) {
            [notifications addObject:notification];
        }
    }
    
    for(NFLocalPushNotification *localPushNotification in [NFLocalPushNotification localPushNotifications]){
        NFProduct *product = [self.masterViewController.store productWithProductId:localPushNotification.identifier];
        if(product && ![self.masterViewController.store productHasAlreadyBeenBought:product.identifier]){
            NFLocalPushNotification *notification = localPushNotification;
            if (notification && arc4random() / ((pow(2, 32)-1)) < threshold) {
                [notifications addObject:notification];
            }
        }
    }
    
    
    int i=-1;
    for(NFLocalPushNotification *notification in notifications){
        notification.flag = YES;
        i++;
        switch (i) {
            case 0:
                notification.durationTillFireDate = @"P1D";
                break;
            case 1:
                notification.durationTillFireDate = @"P3D";
                break;
            case 2:
                notification.durationTillFireDate = @"P1W";
                break;
            case 3:
                notification.durationTillFireDate = @"P20D";
                break;
            case 4:
                notification.durationTillFireDate = @"P160D";
                break;
            case 5:
                notification.durationTillFireDate = @"P365D";
                break;
            default:
                notification.durationTillFireDate = [@"" stringByAppendingFormat:@"P%dD", 2 + (arc4random() % 30)];
                break;
        }

    }
    
    
#ifdef DEBUG
//    int seconds = 1;
//    for(NFLocalPushNotification *localPushNotification in notifications){
//        seconds += 2;
//        localPushNotification.flag = YES;
//        localPushNotification.durationTillFireDate = [@"" stringByAppendingFormat:@"P%dS", seconds];
//    }
#endif
    
    [NFLocalPushNotification scheduleFlaggedNotifications];
    
}


-(void)didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"received local notification");
    
    NSLog(@"local notification: %@", [notification userInfo]);
    NSDictionary *userInfo;

    if((userInfo = [notification userInfo])){
        
        NSArray *userSessionKeys;
        if((userSessionKeys = [userInfo objectForKey:@"FlagUserSessionKeys"])){
            for(NSString *key in userSessionKeys){
                NSString *setKey = [@"" stringByAppendingFormat:@"set%@%@:", [key substringToIndex:1].uppercaseString, [key substringFromIndex:1] ];
                SEL selector = NSSelectorFromString(setKey);
                if ([[Session sharedInstance] respondsToSelector:selector]) {
                    [[Session sharedInstance] performSelector:selector withObject:@(YES)];
                }
                
            }
        }

        NSLog(@"bonusCharacter: %@", [Session sharedInstance].bonusCharacter);
        [self unlockProductsForLocalNotification:notification];
        
        
        NSString *viewControllerClassName;
        if((viewControllerClassName = [userInfo objectForKey:@"PresentViewController"])){
            [self.masterViewController.navigationController popToRootViewControllerAnimated:NO];
            
            self.masterViewController.nextViewControllerClass = NSClassFromString(viewControllerClassName);
            [self.masterViewController presentNextViewController];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
                NSString *selectorName;
                if((selectorName = [userInfo objectForKey:@"Selector"])){
                    NSString *selectorObject = [userInfo objectForKey:@"SelectorObject"];
                    
                    NSLog(@"calling selector: %@", selectorName);
                    if([self.masterViewController.nextViewController respondsToSelector:NSSelectorFromString(selectorName)]){
                        SEL selector = NSSelectorFromString(selectorName);
                        [self.masterViewController.nextViewController performSelector:selector withObject:selectorObject];
                    }
                }
            });
        }
    }
}

-(void)unlockProductsForLocalNotification:(UILocalNotification *)notification{
    NSDictionary *userInfo;
    
    if((userInfo = [notification userInfo])){
        NSArray *productsUnlocked;
        if((productsUnlocked = [userInfo objectForKey:@"ProductsUnlocked"])){
            for(NSString *productId in productsUnlocked){
                [self.masterViewController.store unlockProduct:[self.masterViewController.store productWithProductId:productId]];
            }
        }
    }
}


-(NSMutableArray *)remainingProductGiveawayNotifications{
    NSMutableArray *notifications = [NSMutableArray new];
    
    for(NFLocalPushNotification *localPushNotification in [NFLocalPushNotification localPushNotifications]){
        if(![self.masterViewController.store productHasAlreadyBeenBought:localPushNotification.identifier]){
            [notifications addObject:localPushNotification];
        }
    }
    
    return notifications;
}

+(NSMutableArray *)UILocalNotificationsFromNFLocalPushNotifications:(NSArray *)localPushNotifications{
    NSMutableArray *notifications = [NSMutableArray new];
    for(NFLocalPushNotification *localPushNotification in localPushNotifications){
        UILocalNotification *notification = [NFLocalPushNotification UILocalNotificationFromNFLocalPushNotification:localPushNotification];
        if (notification) {
            [notifications addObject:notification];
        }
    }
    return notifications;
}

@end
