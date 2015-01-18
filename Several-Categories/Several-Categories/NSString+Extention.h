//
//  NSString+Extention.h
//  Sprout
//
//  Created by hoyelo on 12-7-25.
//  Copyright (c) 2012年 AllGateways Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Helper)

//return string with MD5 Encryption
- (NSString *)stringForMD5;

//return text size
- (CGSize)boundingRectWithSize:(CGSize)size
                  withTextFont:(UIFont *)font;

//return a random string
+ (NSString *)UUID;
//return a random string.but will always be same
+ (NSString *)UUIDForDevice;

//query string to dictionary
- (NSDictionary *)dictionaryFromQueryString;

//Encode and Decode
- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding;
- (NSString *)URLDecodedStringWithCFStringEncoding:(CFStringEncoding)encoding;
//Encode and Decode with UTF8
- (NSString *)urlEncodedWithUTF8;
- (NSString *)urlDecodedWithUTF8;

//return json if self is a valid jsonString
- (id)json;

//校验邮箱
- (BOOL)isValidateEmail;
//校验用户手机号码
- (BOOL)isValidPhoneNumber;


@end

@interface NSString (FirstLetter)

- (NSString *)firstLetter;

@end

