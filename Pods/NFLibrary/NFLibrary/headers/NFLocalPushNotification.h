//
//  NFLocalPushNotification.h
//  
//
//  Created by ___FULLUSERNAME___ on 2/28/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>


@interface NFLocalPushNotification : NSObject <NSCoding> {
    NSString *alertAction;
    NSString *alertBody;
    NSString *durationTillFireDate;
    NSString *fireDate;
    BOOL flag;
    NSString *identifier;
    NSString *soundName;
    NSDictionary *userInfo;
}

@property (nonatomic, copy) NSString *alertAction;
@property (nonatomic, copy) NSString *alertBody;
@property (nonatomic, copy) NSString *durationTillFireDate;
@property (nonatomic, copy) NSString *fireDate;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *soundName;
@property (nonatomic, strong) NSDictionary *userInfo;

+ (NFLocalPushNotification *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;


#pragma mark Static Functions
+(NSArray *)localPushNotifications;
+(void)setLocalPushNotifications:(NSArray *)localPushNotifications;
+(NSArray *)arrayOfInstancesFromArrayOfDictionaries:(NSArray *)arrayOfDictionaries;

+(NSDate *)dateFromString:(NSString *)string;

+(UILocalNotification *)UILocalNotificationFromNFLocalPushNotification:(NFLocalPushNotification *)localPushNotification;

+(void)scheduleNotification:(NFLocalPushNotification *)localPushNotification;
+(void)scheduleFlaggedNotifications;
+(NFLocalPushNotification *)notificationWithIdentifier:(NSString *)identifier;



+(BOOL)notificationsEnabledOnDevice;
+(void)promptUserToTurnOnNotificationsInSettings;
+(void)promptUserToTurnOnNotificationsInSettingsWithMessage:(NSString *)message;
+(void)promptUserToTurnOnNotificationsInSettingsWithMessage:(NSString *)message andTitle:(NSString *)title;



@end
