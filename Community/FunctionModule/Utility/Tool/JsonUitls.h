//
//  JsonUitls.h
//  SingleApp
//
//  Created by howjoy on 15/6/23.
//  Copyright (c) 2015年 lookdoor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "StringUtils.h"


#define RESULT_NAME_CODE               @"code"           // 返回结果含有json key
#define RESULT_NAME_MESSAGE            @"message"        // 返回结果含有json key
#define RESULT_NAME_DATA               @"data"           // 返回结果含有json key

@interface JsonUitls : NSObject


/**
 * 时间转换格式
 */
@property (nonatomic)NSDateFormatter *dateformatter;

/**
 * 用于缓存类对象结构
 */
@property (nonatomic)NSMutableDictionary *objPropertyPool;

/**
 * 业务后台返回的数据code
 */
@property int code;

/**
 * 业务后台返回的数据message
 */
@property NSString *message;

/**
 *  获得反封装后的对象
 *
 *  @param objClass 要转换的对象class
 *  @param data json NSData对象
 *  @result id
 */
- (id)getResultObjFromJson:(Class)objClass jsonData:(NSData *)data;

/**
 *  获得反封装后的对象
 *
 *  @param objClass 要转换的对象class
 *  @param data json字符串
 *  @result id
 */
- (id)getResultObjFromJson:(Class)objClass jsonString:(NSString *)jsonString;

/**
 *  获得反封装后的对象集合
 *
 *  @param objClass 要转换的对象class
 *  @param data json NSData对象
 *  @result NSMutableArray
 */
- (NSMutableArray *)getResultArrayFromJson:(Class)objClass jsonData:(NSData *)data;
/**
 *  获得反封装后的对象集合
 *
 *  @param objClass 要转换的对象class
 *  @param data json字符串
 *  @result NSMutableArray
 */
- (NSMutableArray *)getResultArrayFromJson:(Class)objClass jsonString:(NSString *)jsonString;

/**
 *  将指定的对象转换为JSon字符串
 *
 *  @param object 要转换的对象 注：int/float/NSInteger等转id的方法：id obj = @(123.4);
 *  @result NSData
 */
- (NSData *)getJsonDataFromObj:(id)object;

/**
 *  将指定的对象转换为JSon字符串
 *
 *  @param object 要转换的对象
 *  @result NSString
 */
- (NSString *)getJsonStringFromObj:(id)object;

/**
 *  检查业务后台返回的数据是否含有code、message、data标识的包裹，如果是，则单独处理
 *
 *  @param objClass 要转换的对象class
 *  @param data json NSData对象
 *  @result id
 */
- (BOOL)checkResultHaveCode:(NSDictionary *)dict;


@end
