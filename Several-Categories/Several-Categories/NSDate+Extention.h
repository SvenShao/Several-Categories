//
//  NSDate+Extention.h
//  GreenApp
//
//  Created by sven on 14-10-15.
//  Copyright (c) 2014年 allgateways. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extention)

+ (NSString *)timeIntervalSince1970;
+ (NSDate*)dateWithString:(NSString*)dateString formatString:(NSString *)dateFormatterString;
- (NSString *)stringForDateWithFormatterString:(NSString *)dateFormatterString;
- (NSString*)formattedExactRelativeDate;
- (NSString*)formatted;

@end
