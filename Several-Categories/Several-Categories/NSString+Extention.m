//
//  NSString+Helper.m
//  Sprout
//
//  Created by hoyelo on 12-7-25.
//  Copyright (c) 2012年 AllGateways Software, Inc. All rights reserved.
//

#import "NSString+Extention.h"
#import <CommonCrypto/CommonDigest.h>
#import "JPinYinUtil.h"

@implementation NSString (Helper)

- (NSString*)stringForMD5 {
	// Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    
 	// Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
	// Create 16 bytes MD5 hash value, store in buffer
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
	// Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) 
		[output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
{
    NSMutableAttributedString *attributedText = [self attributedStringFromStingWithFont:font];
    CGSize textSize = [attributedText boundingRectWithSize:size
                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   context:nil].size;
    return textSize;
}

-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font}];
    return attributedStr;
}


+ (NSString *)UUID {
	CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
	NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
	CFRelease(uuid);
    return uuidString;
}

+ (NSString *)UUIDForDevice {
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"NSString+Extention_UUID"];
    if (!uuid) {
        uuid = [NSString UUID];
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"NSString+Extention_UUID"];
    }
    return uuid;
}

- (NSDictionary *)dictionaryFromQueryString {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSArray *components = [self componentsSeparatedByString:@"&"];
    for (NSString *component in components) {
        NSArray *keyAndValues = [component componentsSeparatedByString:@"="];
        if ([keyAndValues count] == 2) {
            NSString *key = [[keyAndValues objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *value = [[keyAndValues objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [parameters setObject:value forKey:key];
        }
    }
    return parameters;
}

- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding {
	return (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[self mutableCopy], NULL, CFSTR("￼=,!$&'()*;@?\n\"<>#\t :/"), encoding));
}
- (NSString *)URLDecodedStringWithCFStringEncoding:(CFStringEncoding)encoding {
    return (NSString *) CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)[self mutableCopy], CFSTR(""), encoding));
}

- (NSString *)urlEncodedWithUTF8 {
    return [self URLEncodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}
- (NSString *)urlDecodedWithUTF8 {
    return [self URLDecodedStringWithCFStringEncoding:kCFStringEncodingUTF8];
}


- (id)json {
    if (!self.length) {
        return nil;
    }
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return nil;
    }
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"转json时error : %@",error);
    }
    return json;
}


//校验邮箱
- (BOOL)isValidateEmail {
    if (![self isKindOfClass:[NSString class]] || !self.length) {
        return NO;
    }
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:self
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, self.length)];
    
    if(numberofMatch > 0)
    {
        return YES;
    }
    return NO;
}

//校验用户手机号码
- (BOOL)isValidPhoneNumber{
    if (![self isKindOfClass:[NSString class]] || !self.length) {
        return NO;
    }
    //@"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)"
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^(?:\\((\\+?\\d+)?\\)|\\+?\\d+) ?\\d*(-?\\d{2,3} ?){0,4}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:self
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, self.length)];
    if(numberofMatch > 0)  {
        return YES;
    }
    return NO;
}



@end

@implementation NSString (FirstLetter)

- (NSString *)firstLetter {
    if (![self length]) {
        return @"#";
    }
    unichar charString = [self characterAtIndex:0];
    NSArray *array = pinYinWithoutToneOnlyLetter(charString);//[PinyinHelper toHanyuPinyinStringArrayWithChar:charString];
    if ([array count]) {
        return [[[array objectAtIndex:0] substringToIndex:1] uppercaseString];
    }
    return @"#";
}

@end


