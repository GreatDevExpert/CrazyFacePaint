//
//  NFData.h
//  NinjafishStudiosApp
//
//  Created by William Locke on 9/17/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//

#import <Foundation/Foundation.h>

enum DVDateTimeIntervals {
	kDVDateTimeIntervalOneMinute = 60,
	kDVDateTimeIntervalOneHour = 3600,
	kDVDateTimeIntervalOneDay = 86400,
	kDVDateTimeIntervalOneWeek = 604800
};


// TODO: move to NFFoundation
@interface DVDate : NSObject

+(NSDate *)dateFromString:(NSString *)string;
+(NSString *)currentTimezoneString;
+(NSDate *)localizedDateFromSystemDate:(NSDate *)date;
+(BOOL)isDateToday:(NSDate *)date;
+(BOOL)isDateTomorrow:(NSDate *)date;
+(NSString *)delocalizedDateStringForDate:(NSDate *)date;
+(NSString *)naturalUpcomingDateStringForDate:(NSDate *)date;
+(BOOL)isDatePast:(NSDate *)date;
+(NSString *)timeStringForDate:(NSDate *)date;
+(NSString *)stopWatchFormat:(int)centiSecondTimestamp;
+(NSString *)stopWatchFormatFromSeconds:(int)secondsTimestamp;
+(int)timeIntervalFromISO8601Duration:(NSString *)duration;

+(int)daysFromTimeInterval:(int)timeInterval;

@end
