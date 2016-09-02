//
//  NSDate-extras.h
//  Slots Party
//
//  Created by William Locke on 2/28/12.
//  Copyright 2012 William Locke. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSDate (extras)

+(NSDate *)dateFromString:(NSString *)string;
+(NSString *)currentTimezoneString;
+(NSDate *)localizedDateFromSystemDate:(NSDate *)date;
-(BOOL)isToday:(NSDate *)date;
-(BOOL)isTomorrow;
+(NSString *)delocalizedDateStringForDate:(NSDate *)date;
-(NSString *)naturalUpcomingDateStringWithDate;
-(BOOL)isPastDate;
+(NSString *)timeStringForDate:(NSDate *)date;
+(NSString *)stopWatchFormat:(int)centiSecondTimestamp;
+(NSString *)stopWatchFormatFromSeconds:(int)secondsTimestamp;

@end
