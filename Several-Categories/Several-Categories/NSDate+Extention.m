//
//  NSDate+Extention.m
//  GreenApp
//
//  Created by sven on 14-10-15.
//  Copyright (c) 2014年 allgateways. All rights reserved.
//

#import "NSDate+Extention.h"

// NSDate
#define kJustNow            kString(@"TIME_JUST_NOW")
#define kSecondsAgo         kString(@"TIME_SECONDS_AGO")
#define kMinuteAgo          kString(@"TIME_MINUTE_AGO")
#define kMinutesAgo         kString(@"TIME_MINUTES_AGO")
#define kHourAgo            kString(@"TIME_HOUR_AGO")
#define kHoursAgo           kString(@"TIME_HOURS_AGO")
#define kYesterday          kString(@"TIME_YESTERDAY")
#define kDaysAgo            kString(@"TIME_DAYS_AGO")

@implementation NSDate (Extention)


+ (NSString *)timeIntervalSince1970 {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%qu", (unsigned long long) timeInterval];
}

+ (NSDate*)dateWithString:(NSString*)dateString formatString:(NSString *)dateFormatterString {
	if(!dateString) return nil;
    
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [formatter setLocale:locale];
    }
    
    [formatter setDateFormat:dateFormatterString];
    NSDate *theDate = [formatter dateFromString:dateString];
    
	return theDate;
}

- (NSString *)stringForDateWithFormatterString:(NSString *)dateFormatterString {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatterString];
    
    [formatter setLocale:[NSLocale currentLocale]];
    
	return [formatter stringFromDate:self];
}

- (NSString*)formattedExactRelativeDate {
	NSTimeInterval time = [self timeIntervalSince1970];
	NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
	NSTimeInterval diff = now - time;
	
	if(diff < 10) {
		return kJustNow;
	} else if(diff < 60) {
		return [NSString stringWithFormat:kSecondsAgo,(int)diff];
	}
	
	diff = round(diff/60);
	if(diff < 60) {
		if(diff == 1) {
			return [NSString stringWithFormat:kMinuteAgo,(int)diff];
		} else {
			return [NSString stringWithFormat:kMinutesAgo,(int)diff];
		}
	}
	
	diff = round(diff/60);
	if(diff < 24) {
		if(diff == 1) {
			return [NSString stringWithFormat:kHourAgo,(int)diff];
		} else {
			return [NSString stringWithFormat:kHoursAgo,(int)diff];
		}
	}
	
	if(diff < 7) {
		if(diff == 1) {
			return kYesterday;
		} else {
			return [NSString stringWithFormat:kDaysAgo,(int)diff];
		}
	}
	
	return [self stringForDateWithFormatterString:@"MMM d,yyyy"];
}

- (NSString*)formatted {
	NSTimeInterval time = [self timeIntervalSince1970];
	NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
	NSTimeInterval diff = now - time;
	
	if(diff < 10) {
		return kJustNow;
	} else if(diff < 60) {
		return [NSString stringWithFormat:kSecondsAgo,(int)diff];
	}
	
	diff = round(diff/60);
	if(diff < 60) {
		if(diff == 1) {
			return [NSString stringWithFormat:kMinuteAgo,(int)diff];
		} else {
			return [NSString stringWithFormat:kMinutesAgo,(int)diff];
		}
	}
	
	diff = round(diff/60);
	if(diff < 24) {
        [self stringForDateWithFormatterString:@"HH:mm"];
		if(diff == 1) {
			return [NSString stringWithFormat:kHourAgo,(int)diff];
		} else {
			return [NSString stringWithFormat:kHoursAgo,(int)diff];
		}
	}
	
//	if(diff < 7) {
//        return [self stringForDateWithFormatterString:@"HH:mm"];
////		if(diff == 1) {
////			return kYesterday;
////		} else {
////			return [NSString stringWithFormat:kDaysAgo,(int)diff];
////		}
//	}
	
	return [self stringForDateWithFormatterString:@"MM/dd"];
}

@end
