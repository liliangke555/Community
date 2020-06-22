//
//  StringUtils.m
//  SingleApp
//
//  Created by howjoy on 15/6/23.
//  Copyright (c) 2015年 lookdoor. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

/**
 *  转换字符串（GBK转码）
 *
 *  @param data 数据源
 *  @result NSString
 */
+ (NSString *)convertString:(NSData *)data {
//    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    return [[NSString alloc]initWithBytes:[data bytes] length:[data length] encoding:gbkEncoding];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
/**
 *  转换Data对象（GBK转码）
 *
 *  @param data 数据源
 *  @result NSString
 */
+ (NSData *)convertData:(NSString *)string {
//    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    return [string dataUsingEncoding:gbkEncoding];
    return [string dataUsingEncoding: NSUTF8StringEncoding];
}
/**
 *  转换字符串
 *
 *  @param data 数据源
 *  @param encoding 指定的编码
 *  @result NSString
 */
+ (NSString *)convertString:(NSData *)data encoding:(NSStringEncoding)encoding {
    return [[NSString alloc]initWithBytes:[data bytes] length:[data length] encoding:encoding];
}

/**
 *  截除字符串指定头部
 *
 *  @param string 字符串
 *  @param start 指定的头部字符串
 *  @result NSString
 */
+ (NSString *)removeStartFromString:(NSString *)string start:(NSString *)start {
    if([string hasPrefix:start]) {
        return [string substringFromIndex:[start length]];
    }
    return string;
}

/**
 *  截除字符串指定尾部
 *
 *  @param string 字符串
 *  @param start 指定的尾部字符串
 *  @result NSString
 */
+ (NSString *)removeEndFromString:(NSString *)string end:(NSString *)end {
    if([string hasSuffix:end]) {
        return [string substringToIndex:[string length]-[end length]];
    }
    return string;
}

/**
 *  转换字符串为NSDate对象
 *
 *  @param string (yyyy-MM-dd HH:mm:ss)字符串
 *  @param type 类型 0）不带毫秒 yyyy-MM-dd HH:mm:ss 1）带毫秒 yyyy-MM-dd HH:mm:ss.SSS
 *  @result NSString
 */
+ (NSDate *)convertStringToDate:(NSString *)dateString type:(int)type {

    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:GTMzone];
    switch (type) {
        case 0:
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            break;
        case 1:
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss.SSS"];
            break;
        default:
            break;
    }
    
    return [dateFormatter dateFromString:dateString];
}

/**
 *  转换NSDate为NSString
 *
 *  @param date NSDate对象
 *  @param int formatter转换方式：
 1）yyyy-MM-dd HH:mm:ss; 
 2）yyyy年MM月dd日 HH时mm分ss秒;
 3）MM-dd HH:mm:ss; 
 4）MM月dd日; 
 5）yyyy-MM-dd_HH:mm:ss
 6) yyyy-MM-dd HH:mm:ss.SSS
 *  @result NSString
 */
+ (NSString *)convertDateToString:(NSDate *)date formatter:(int)type{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (type) {
        case 1:
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            break;
        case 2:
            [dateFormatter setDateFormat: @"yyyy年MM月dd日 HH时mm分ss秒"];
            break;
        case 3:
            [dateFormatter setDateFormat: @"MM-dd HH:mm:ss"];
            break;
        case 4:
            [dateFormatter setDateFormat: @"MM月dd日"];
            break;
        case 5:
            [dateFormatter setDateFormat: @"yyyy-MM-dd_HH:mm:ss"];
            break;
        case 6:
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss.SSS"];
            break;
        case 7:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case 8:
            [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
            break;
        case 9:
            [dateFormatter setDateFormat:@"HH:mm:ss"];
            break;
        case 10:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case 11:
            [dateFormatter setDateFormat:@"MM-dd"];
            break;
        case 12:
            [dateFormatter setDateFormat:@"yyyy.MM.dd"];
            break;
        case 13:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case 14:
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            break;
        default:
            break;
    }
    return [dateFormatter stringFromDate:date];
}

/**
 *  MD5编码
 *
 *  @param string 要编码的字符串
 *  @result NSString
 */
+ (NSString *)encodingMD5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 *  过滤字符串中的html标签
 *
 *  @param html 待过滤字符串
 *
 *  @return 过滤后的字符串
 */
+ (NSString *)removeHTML2:(NSString *)html {
    NSArray *components = [html componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    NSMutableArray *componentsToKeep = [NSMutableArray array];
    
    for (int i = 0; i < [components count]; i = i + 2) {
        [componentsToKeep addObject:[components objectAtIndex:i]];
    }
    
    NSString *plainText = [componentsToKeep componentsJoinedByString:@""];
    
    return plainText;
}

/**
 *  正则匹配手机号
 *
 *  @param telNumber 电话号码
 *  @result 成功：YES；失败：NO
 */
+ (BOOL)checkTelNumber:(NSString *)telNumber
{
    NSString *pattern = @"^1\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    return [pred evaluateWithObject:telNumber];
}
@end
