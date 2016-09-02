//
//  NFData.h
//  NinjafishStudiosApp
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

enum NFDateTimeIntervals {
	kNFDateTimeIntervalOneMinute = 60,
	kNFDateTimeIntervalOneHour = 3600,
	kNFDateTimeIntervalOneDay = 86400,
	kNFDateTimeIntervalOneWeek = 604800
};


// TODO: move to NFFoundation
@interface NFDate : NSObject

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
