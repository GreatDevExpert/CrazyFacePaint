//
//  NFData.m
//  NinjafishStudiosApp
//
//  Created by William Locke on 9/17/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//


#import "DVDate.h"

// TODO: replace with NFDateTimeIntervals. 
enum TimeIntervals {
	kTimeIntervalOneMinute = 60,
	kTimeIntervalOneHour = 3600,
	kTimeIntervalOneDay = 86400,
	kTimeIntervalOneWeek = 604800
};


@implementation DVDate


+(NSDate *)dateFromString:(NSString *)string{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSDate *date;
    
    // This matches HTTP response header date format for
    // 'Date:' header field
    [df setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss"];
    [df setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    NSString *tmpString = [string substringToIndex:[string length]-4];
    date = [df dateFromString:tmpString];
    if (date) {
        return date;
    }
    
    
	NSDateFormatter *date_formater=[[NSDateFormatter alloc]init];
	[date_formater setLocale:[NSLocale systemLocale]];
	[date_formater setDateFormat:@"Z"];
	string = [string stringByReplacingOccurrencesOfString:@"Z"
											   withString:[@"" stringByAppendingFormat:@" %@", @"+0000"]];
	string = [string stringByReplacingOccurrencesOfString:@"T" withString:@" "];
	
    // Re-initialize df
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	date = [df dateFromString:string];
    
    
    //Tue, 03 Apr 2012 21:17:38 GMT
    
    
	return [self localizedDateFromSystemDate:date];
}

+(NSString *)currentTimezoneString{
	NSDateFormatter *date_formater=[[NSDateFormatter alloc]init];
	[date_formater setLocale:[NSLocale currentLocale]];
	[date_formater setDateFormat:@"Z"];
	return [date_formater stringFromDate:[NSDate date]];
}

+(NSDate *)localizedDateFromSystemDate:(NSDate *)date{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setLocale:[NSLocale systemLocale]];
	[df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *dateStringWithoutTimezone = [df stringFromDate:date];
	[df setLocale:[NSLocale currentLocale]];
	return [df dateFromString:dateStringWithoutTimezone];
}


+(BOOL)isDateToday:(NSDate *)date{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	NSString *dateText = [dateFormatter stringFromDate:date];
	NSString *todayDateText = [dateFormatter stringFromDate:[NSDate date]];
	if ([dateText isEqualToString:todayDateText]) {
		return YES;
	}
	return NO;
}


+(BOOL)isDateTomorrow:(NSDate *)date{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	NSDate *tomorrowsDate = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970] + kTimeIntervalOneDay];
	NSString *dateText = [dateFormatter stringFromDate:date];
	NSString *tomorrowDateText = [dateFormatter stringFromDate:tomorrowsDate];
	
	if ([dateText isEqualToString:tomorrowDateText]) {
		return YES;
	}
	return NO;
}


+(NSString *)delocalizedDateStringForDate:(NSDate *)date{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	NSLocale *systemLocale = [NSLocale systemLocale];
	[dateFormatter setLocale:systemLocale];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	[dateFormatter setLocale:[NSLocale currentLocale]];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	NSString *stringForDate = [dateFormatter stringFromDate:date];
	return stringForDate;
}


+(NSString *)naturalUpcomingDateStringForDate:(NSDate *)date{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd"];
	[dateFormatter setDateFormat:@"HH:mm"];
	int timestamp = [date timeIntervalSince1970] - [[NSDate date] timeIntervalSince1970];
	int seconds = timestamp % 60;
	int minutes = (int)(timestamp / 60.0 + 0.5);
	int hours = (int)(timestamp / (60 * 60.0) + 0.5);
	int days = (int)(timestamp / (60 * 60 * 24.0));
	if (days > 7) {
		int weeks = (days + 3) / 7;
		return [@"" stringByAppendingFormat:@"in %d wk%@", weeks, weeks != 1 ? @"s" : @""];
	}
	if (days > 0) {
		return [@"" stringByAppendingFormat:@"in %d day%@", days, days != 1 ? @"s" : @""];
	}
	
	if (hours > 0 && minutes > 59) {
		return [@"" stringByAppendingFormat:@"in ~%d hr%@", hours, hours != 1 ? @"s" : @""];
	}
	
	if (minutes > 0 && timestamp > 59) {
		return [@"" stringByAppendingFormat:@"in %d min%@", minutes, minutes != 1 ? @"s" : @""];
	}
	
	if (seconds > 0) {
		return [@"" stringByAppendingFormat:@"in %d sec%@", seconds, seconds != 1 ? @"s" : @""];
	}
	return @"in progress";
}


+(BOOL)isDatePast:(NSDate *)date{
    
	return ([date timeIntervalSince1970] - [[NSDate date] timeIntervalSince1970]) < 0;
}


+(NSString *)timeStringForDate:(NSDate *)date{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"h:mma"];
	NSString *timeText = [dateFormatter stringFromDate:date];
	timeText = [timeText lowercaseString];
	
	return timeText;
}


+(NSString *)stopWatchFormat:(int)centiSecondTimestamp{
	int centiSeconds_ = centiSecondTimestamp % 10;
	int seconds = centiSecondTimestamp/10;
	int minutes = 0;
	int hours = 0;
	
	if (seconds > 60) {
		minutes = seconds/60;
	}
	if (minutes > 60) {
		hours = minutes/60;
	}
	minutes = minutes % 60;
	seconds = seconds % 60;
	
	NSString *centiSecondsString = [@"" stringByAppendingFormat:@"%d", centiSeconds_];
	NSString *secondsString = [@"" stringByAppendingFormat:@"%d", seconds];
	NSString *minutesString = [@"" stringByAppendingFormat:@"%d", minutes];
	NSString *hoursString = [@"" stringByAppendingFormat:@"%d", hours];
	if([secondsString length] == 1){
		secondsString = [@"" stringByAppendingFormat:@"0%@", secondsString];
	}
	if([minutesString length] == 1){
		minutesString = [@"" stringByAppendingFormat:@"0%@", minutesString];
	}
	if (hours) {
		return [@"" stringByAppendingFormat:@"%@:%@:%@.%@", hoursString, minutesString, secondsString, centiSecondsString];
	}
	return [@"" stringByAppendingFormat:@"%@:%@.%@", minutesString, secondsString, centiSecondsString];
}

+(NSString *)stopWatchFormatFromSeconds:(int)secondsTimestamp{
	int seconds = secondsTimestamp;
	int minutes = 0;
	int hours = 0;
	
	if (seconds > 60) {
		minutes = seconds/60;
	}
	if (minutes > 60) {
		hours = minutes/60;
	}
	minutes = minutes % 60;
	seconds = seconds % 60;
	
	NSString *secondsString = [@"" stringByAppendingFormat:@"%d", seconds];
	NSString *minutesString = [@"" stringByAppendingFormat:@"%d", minutes];
	NSString *hoursString = [@"" stringByAppendingFormat:@"%d", hours];
	
	if([secondsString length] == 1){
		secondsString = [@"" stringByAppendingFormat:@"0%@", secondsString];
	}
	if([minutesString length] == 1){
		minutesString = [@"" stringByAppendingFormat:@"0%@", minutesString];
	}
	if (hours) {
		return [@"" stringByAppendingFormat:@"%@:%@:%@", hoursString, minutesString, secondsString];
	}
	return [@"" stringByAppendingFormat:@"%@:%@", minutesString, secondsString];
}


+(int)timeIntervalFromISO8601Duration:(NSString *)duration{
    const char *stringToParse = [duration UTF8String];
    int days = 0, hours = 0, minutes = 0, seconds = 0, weeks = 0;
    
    const char *ptr = stringToParse;
    while(*ptr)
    {
        if(*ptr == 'P' || *ptr == 'T')
        {
            ptr++;
            continue;
        }
        
        int value, charsRead;
        char type;
        if(sscanf(ptr, "%d%c%n", &value, &type, &charsRead) != 2)
            ;  // handle parse error
        if(type == 'D')
            days = value;
        else if(type == 'H')
            hours = value;
        else if(type == 'M')
            minutes = value;
        else if(type == 'W')
            weeks = value;
        else if(type == 'S')
            seconds = value;
        else
            ;  // handle invalid type
        ptr += charsRead;
    }
    
    NSTimeInterval interval = ((days * 24 + hours) * 60 + minutes) * 60 + seconds + weeks * kTimeIntervalOneWeek;
    return interval;
}

+(int)daysFromTimeInterval:(int)timeInterval{
    return timeInterval / (kTimeIntervalOneDay * 1.0);
}



@end
