//
//  NFSettings.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

// TODO: Clean up this system, don't use generic sounding #defines.
#define kClassIdentifer @"NFSettings"

//extern NSString * const NFSettingsNotificationDidSetSoundsOn;


// TODO: Update this class to use generic serialize method.
// TODO: Move NFSettings to its on pod/module. 
@interface NFSettings : NSObject

@property BOOL soundsOn;
@property BOOL notifications;
@property BOOL soundEffects;
@property BOOL music;
@property BOOL removeAds;


-(void)setSoundsOn:(BOOL)soundsOn;
-(BOOL)soundsOn;

+(NFSettings *)sharedInstance;

+(id)__load;
+(id)deserialize:(NSMutableDictionary *)__item;
-(void)save;



@end
