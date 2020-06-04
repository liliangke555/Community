//
//  StringUtils.h
//  SingleApp
//
//  Created by howjoy on 15/6/23.
//  Copyright (c) 2015年 lookdoor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface StringUtils : NSObject

/**
 *  转换字符串（GBK转码
 *
 *  @param data 数据源
 *  @result NSString
 */
+ (NSString *)convertString:(NSData *)data;

/**
 *  转换Data对象（GBK转码）
 *
 *  @param data 数据源
 *  @result NSString
 */
+ (NSData *)convertData:(NSString *)string;

/**
 *  转换字符串
 *
 *  @param data 数据源
 *  @param encoding 指定的编码
 *  @result NSString
 */
+ (NSString *)convertString:(NSData *)data encoding:(NSStringEncoding)encoding;

/**
 *  截除字符串指定头部
 *
 *  @param string 字符串
 *  @param start 指定的头部字符串
 *  @result NSString
 */
+ (NSString *)removeStartFromString:(NSString *)string start:(NSString *)start;

/**
 *  截除字符串指定尾部
 *
 *  @param string 字符串
 *  @param start 指定的尾部字符串
 *  @result NSString
 */
+ (NSString *)removeEndFromString:(NSString *)string end:(NSString *)end;

/**
 *  转换字符串为NSDate对象
 *
 *  @param string (yyyy-MM-dd HH:mm:ss)字符串
 *  @result NSString
 */
+ (NSDate *)convertStringToDate:(NSString *)dateString type:(int)type;
/**
 *  转换NSDate为NSString
 *
 *  @param date NSDate对象
 *  @param int formatter转换方式：1）yyyy-MM-dd HH:mm:ss; 2）yyyy年MM月dd日 HH时mm分ss秒; 3）MM-dd HH:mm:ss; 4）MM月dd日; 5）yyyy-MM-dd_HH:mm:ss
 *  @result NSString
 */
+ (NSString *)convertDateToString:(NSDate *)date formatter:(int)type;

/**
 *  MD5编码
 *
 *  @param string 要编码的字符串
 *  @result NSString
 */
+ (NSString *)encodingMD5:(NSString *)string;

/**
 *  过滤字符串中的html标签
 *
 *  @param html 待过滤字符串
 *
 *  @return 过滤后的字符串
 */
+ (NSString *)removeHTML2:(NSString *)html;

/**
 *  正则匹配手机号
 *
 *  @param telNumber 电话号码
 *  @result 成功：YES；失败：NO
 */
+ (BOOL)checkTelNumber:(NSString *) telNumber;

@end
