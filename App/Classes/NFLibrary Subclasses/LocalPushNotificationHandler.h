//
//  LocalPushNotification.h
//  HighSchoolMakeover
//
//  Created by William Locke on 9/23/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "NFLocalPushNotification.h"
#import "Store.h"
#import "MasterViewController.h"
@class MasterViewController;

@interface LocalPushNotificationHandler : NSObject

@property (nonatomic, strong) Store *store;
@property (nonatomic, strong) MasterViewController *masterViewController;


+ (LocalPushNotificationHandler *)sharedInstance;

-(void)scheduleNotifications;
-(void)didReceiveLocalNotification:(UILocalNotification *)notification;
-(void)unlockProductsForLocalNotification:(UILocalNotification *)notification;

-(NSMutableArray *)remainingProductGiveawayNotifications;
+(NSMutableArray *)UILocalNotificationsFromNFLocalPushNotifications:(NSArray *)localPushNotifications;


@end
