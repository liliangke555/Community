//
//  JsonUitls.m
//  SingleApp
//
//  Created by howjoy on 15/6/23.
//  Copyright (c) 2015年 lookdoor. All rights reserved.
//

#import "JsonUitls.h"

@implementation JsonUitls

/**
 *  获得反封装后的对象
 *
 *  @param objClass 要转换的对象class
 *  @param data json NSData对象
 *  @result id
 */
- (id)getResultObjFromJson:(Class)objClass jsonData:(NSData *)data {
    return [self getResultObjFromJson:objClass jsonString:[StringUtils convertString:data]];
}

/**
 *  检查业务后台返回的数据是否含有code、message、data标识的包裹，如果是，则单独处理
 *
 *  @param objClass 要转换的对象class
 *  @param data json NSData对象
 *  @result id
 */
- (BOOL)checkResultHaveCode:(NSDictionary *)dict {
    if ([[dict allKeys] containsObject:RESULT_NAME_CODE] && [[dict allKeys] containsObject:RESULT_NAME_MESSAGE]) {
        return true;
    }
    return false;
}

/**
 *  获得反封装后的对象
 *
 *  @param objClass 要转换的对象class
 *  @param data json字符串
 *  @result id
 */
- (id)getResultObjFromJson:(Class)objClass jsonString:(NSString *)jsonString {
    if(jsonString == nil) {
        return nil;
    }
    // 按自定义对象反序列化json
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&err];
    if (err) {
        //        NSLog(@"解析失败:%@",err);
    }
    //    NSLog(@"json--%@",jsonString);
    //    NSLog(@"dict-- %@",dict);
    
    bool haveFlag = false;
    if (dict != nil) {
        haveFlag = [self checkResultHaveCode:dict];
    }
    // 获得class的名称以便进行判断
    NSString *className = NSStringFromClass(objClass);
    //    NSLog(@"className--%@",className);
    
    
    
    if (haveFlag) {
        [self setCode:[(NSString *)[dict objectForKey:RESULT_NAME_CODE] intValue]];
        [self setMessage:(NSString *)[dict objectForKey:RESULT_NAME_MESSAGE]];
        
        NSDictionary *dataDict = (NSDictionary *)[dict objectForKey:RESULT_NAME_DATA];
        
        //        NSLog(@"dataDict-- %@",dataDict);
        if([className isEqualToString:@"NSDate"]) {
            // NSDate
            return [[self getDateFormatter] dateFromString:(NSString *)dataDict];
        }
        if ([className isEqualToString:@"NSString"]) {
            // NSString
            return (NSString *)dataDict;
        }
        if ([className isEqualToString:@"NSNumber"]) {
            // NSNumber
            return [NSNumber numberWithDouble:[(NSString *)dataDict doubleValue]];
        }
        if([className isEqualToString:@"NSDictionary"]) {
            return dataDict;
        }else if (dataDict!=nil) {
            @try
            {
                NSMutableDictionary *properyDict = [self getObjPropertyPoolByKey:className class:objClass];
                return [self createObjByDictionary:dataDict class:objClass objPropertyDict:properyDict];
            }@catch (NSException * e) {
                //                NSLog(@"Json Paster Exception: %@", e);
            }
        }
    } else {
        if([className isEqualToString:@"NSDate"]) {
            // NSDate
            NSString *string = [StringUtils removeStartFromString:jsonString start:@"\""];
            string = [StringUtils removeEndFromString:string end:@"\""];
            return [[self getDateFormatter] dateFromString:string];
        } else if ([className isEqualToString:@"NSString"]) {
            // NSString
            NSString *string = [StringUtils removeStartFromString:jsonString start:@"\""];
            return [StringUtils removeEndFromString:string end:@"\""];
        } else if ([className isEqualToString:@"NSNumber"]) {
            // NSNumber
            NSString *string = [StringUtils removeStartFromString:jsonString start:@"\""];
            string = [StringUtils removeEndFromString:string end:@"\""];
            return [NSNumber numberWithDouble:[string doubleValue]];
        } else if([className isEqualToString:@"NSDictionary"]) {
            // NSDictionary
            return dict;
        }else if(dict != nil) {
            NSMutableDictionary *properyDict = [self getObjPropertyPoolByKey:className class:objClass];
            return [self createObjByDictionary:dict class:objClass objPropertyDict:properyDict];
        }
    }
    
    return nil;
}

/**
 *  获得反封装后的对象集合
 *
 *  @param objClass 要转换的对象class
 *  @param data json NSData对象
 *  @result NSMutableArray
 */
- (NSMutableArray *)getResultArrayFromJson:(Class)objClass jsonData:(NSData *)data {
    return [self getResultArrayFromJson:objClass jsonString:[StringUtils convertString:data]];
}
/**
 *  获得反封装后的对象集合
 *
 *  @param objClass 要转换的对象class
 *  @param data json字符串
 *  @result NSMutableArray
 */
- (NSMutableArray *)getResultArrayFromJson:(Class)objClass jsonString:(NSString *)jsonString {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    // 第一层解析json之后的数据字典
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    
    NSMutableDictionary *properyDict = [self getObjPropertyPoolByKey:NSStringFromClass(objClass) class:objClass];
    bool haveFlag = [self checkResultHaveCode:dict];
    if (haveFlag) {
        [self setCode:[(NSString *)[dict objectForKey:RESULT_NAME_CODE] intValue]];
        [self setMessage:(NSString *)[dict objectForKey:RESULT_NAME_MESSAGE]];
        NSDictionary *dataDict = (NSDictionary *)[dict objectForKey:RESULT_NAME_DATA];
        
        NSString *className = NSStringFromClass(objClass);
        if([className isEqualToString:@"NSDictionary"]) {
            return (NSMutableArray *)dataDict;
        }else {
            id obj;
            NSEnumerator *enumerator = [dataDict objectEnumerator];
            while (obj = [enumerator nextObject]) {
                // 第二层解析json之后的数据字典
                NSDictionary *subDict = (NSDictionary *)obj;
                [resultArray addObject:[self createObjByDictionary:subDict class:objClass objPropertyDict:properyDict]];
            }
            return resultArray;
        }
    }else {
        NSString *className = NSStringFromClass(objClass);
        if([className isEqualToString:@"NSDictionary"]) {
            return (NSMutableArray *)dict;
        }else {
            id obj;
            NSEnumerator *enumerator = [dict objectEnumerator];
            while (obj = [enumerator nextObject]) {
                // 第二层解析json之后的数据字典
                NSDictionary *subDict = (NSDictionary *)obj;
                [resultArray addObject:[self createObjByDictionary:subDict class:objClass objPropertyDict:properyDict]];
            }
            return resultArray;
        }
    }
}

/**
 *  获取类的成员变量字典
 *
 *  @param objClass 对象class
 *  @result NSMutableDictionary
 */
- (NSMutableDictionary *)getObjectPropertyDict:(Class)objClass {
    unsigned int numberOfIvars = 0;
    Ivar *ivars = class_copyIvarList(objClass, &numberOfIvars);
    // 成员变量字典
    NSMutableDictionary *objPropertyDict = [[NSMutableDictionary alloc] initWithCapacity:numberOfIvars];
    
    for(const Ivar* p=ivars; p<ivars+numberOfIvars; p++) {
        Ivar const ivar = *p;
        // 获取数据类型
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        // 获取变量名
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        name = [StringUtils removeStartFromString:name start:@"_"];
        
        [objPropertyDict setObject:type forKey:name];
    }
    return objPropertyDict;
}

/**
 *  将NSDictionary转换为JSON的NSString
 *
 *  @param dict json字符串解析的数据字典
 *  @result id
 */
- (NSString*)dictToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 *  根据对象的成员变量从JSON中获取值进行初始化
 *
 *  @param dict json字符串解析的数据字典
 *  @param objClass 要转换的对象class
 *  @param objPropertyDict 对象class成员变量字典
 *  @result id
 */
- (id)createObjByDictionary:(NSDictionary *)dict class:(Class)objClass objPropertyDict:(NSMutableDictionary *)objPropertyDict {
    id item = [objClass new];
    NSString *propertyName;
    for (propertyName in objPropertyDict) {
        NSString *propertyType = [objPropertyDict objectForKey:propertyName];
        // 获取JSON值
        NSString *value = (NSString *)[dict objectForKey:propertyName];
        if(value == nil) {
            continue;
        }
        if([propertyType isEqualToString:@"B"]) {
            //BOOL
            [item setValue:[NSNumber numberWithBool:[value boolValue]] forKey:propertyName];
        } else if([propertyType isEqualToString:@"i"]) {
            //int
            [item setValue:[NSNumber numberWithInt:[value intValue]] forKey:propertyName];
        } else if([propertyType isEqualToString:@"q"]) {
            //long
            [item setValue:[NSNumber numberWithLongLong:[value longLongValue]] forKey:propertyName];
        } else if([propertyType isEqualToString:@"f"]) {
            //float
            [item setValue:[NSNumber numberWithFloat:[value floatValue]] forKey:propertyName];
        } else if([propertyType isEqualToString:@"d"]) {
            //double
            [item setValue:[NSNumber numberWithDouble:[value doubleValue]] forKey:propertyName];
        } else if([propertyType isEqualToString:@"^q"]) {
            //NSInteger
            [item setValue:[NSNumber numberWithInt:[value intValue]] forKey:propertyName];
        } else if([propertyType isEqualToString:@"@\"NSNumber\""]) {
            //NSNumber
            [item setValue:[NSNumber numberWithDouble:[value doubleValue]] forKey:propertyName];
        } else if([propertyType isEqualToString:@"@\"NSDate\""]) {
            //NSDate
            [item setValue:[[self getDateFormatter] dateFromString:value] forKey:propertyName];
        } else if([propertyType isEqualToString:@"@\"NSString\""]) {
            //NSString
            [item setValue:value forKey:propertyName];
        } else if ((int)[propertyType rangeOfString:@"NS"].length > 0 && (int)[propertyType rangeOfString:@"Array"].length > 0) { //更改了这一点  location变更为length
            //NSArray或NSMutableArray
            // 先创建一个数组集合
            NSMutableArray *array = [NSMutableArray new];
            if ([propertyType containsString:@"<"]) {
                // 获取类名
                NSString *subClassName = [propertyType substringFromIndex:[propertyType rangeOfString:@"<"].location + 1];
                subClassName = [subClassName substringToIndex:[subClassName rangeOfString:@">"].location];
                
                // 获取类对象
                Class subClass = NSClassFromString(subClassName);
                if(subClass != nil) {
                    if ([subClass isSubclassOfClass:[NSString class]] || [subClass isSubclassOfClass:[NSNumber class]] || [subClass isSubclassOfClass:[NSString class]]) {
                        for (id idObj  in (NSDictionary *)value) {
                            // 反封装装载对象
                            [array addObject:idObj];
                        }
                    } else {
                        // 解析类对象的成员变量
                        NSMutableDictionary *subProperyDict = [self getObjPropertyPoolByKey:subClassName class:subClass];
                        NSDictionary *subValue= nil;
                        for (subValue in (NSDictionary *)value) {
                            // 反封装装载对象
                            id subObj = [self createObjByDictionary:subValue class:subClass objPropertyDict:subProperyDict];
                            [array addObject:subObj];
                        }
                    }
                }
                [item setValue:array forKey:propertyName];
            }else {
                for (id idObj  in (NSDictionary *)value) {
                    // 反封装装载对象
                    [array addObject:idObj];
                }
                [item setValue:array forKey:propertyName];
            }
            
        } else {
            @try
            {
                // 尝试根据名称获得类对象
                NSString *className = [StringUtils removeStartFromString:propertyType start:@"@\""];
                className = [StringUtils removeEndFromString:className end:@"\""];
                Class someClass = NSClassFromString(className);
                if (someClass != nil) {
                    NSMutableDictionary *someProperyDict = [self getObjPropertyPoolByKey:className class:someClass];
                    id someObj = [self createObjByDictionary:(NSDictionary *)value class:someClass objPropertyDict:someProperyDict];
                    [item setValue:someObj forKey:propertyName];
                }
            }@catch (NSException * e) {
                //                NSLog(@"unknown type(%@)Exception: %@", propertyName, e);
            }
        }
    }
    return item;
}

/**
 *  时间转换格式
 *
 *  @result dateformatter
 */
- (NSDateFormatter *)getDateFormatter {
    if (self.dateformatter == nil) {
        self.dateformatter = [[NSDateFormatter alloc] init];
        self.dateformatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [self.dateformatter setDateStyle:NSDateFormatterMediumStyle];
        [self.dateformatter setTimeStyle:NSDateFormatterMediumStyle];
        [self.dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];  // @"MMM dd, yyyy hh:mm:ss.SSS aa"  @"yyyy－MM－dd HH:mm:ss.SSS"
    }
    return self.dateformatter;
}

/**
 *  获取类对象结构缓存
 *
 *  @result dateformatter
 */
- (NSMutableDictionary *)getObjPropertyPool {
    if (self.objPropertyPool == nil) {
        self.objPropertyPool = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
    return self.objPropertyPool;
}

/**
 *  获取缓存的对象结构（如果未缓存过，则解析结构并添加缓存）
 *
 *  @param key 缓存关键字，用类对象名称
 *  @param objClass 缓存的对象class
 *  @result id
 */
- (NSMutableDictionary *)getObjPropertyPoolByKey:(NSString *)key class:(Class)objClass {
    NSMutableDictionary *pool = [self getObjPropertyPool];
    NSMutableDictionary *properyDict = [pool objectForKey:key];
    if (properyDict == nil) {
        properyDict = [self getObjectPropertyDict:objClass];
        [pool setObject:properyDict forKey:key];
    }
    return properyDict;
}

/**
 *  将指定的对象转换为JSon字符串
 *
 *  @param object 要转换的对象 注：int/float/NSInteger等转id的方法：id obj = @(123.4);
 *  @result NSData
 */
- (NSData *)getJsonDataFromObj:(id)object {
    NSString *jsonString = [self getJsonStringFromObj:object];
    return [StringUtils convertData:jsonString];
}
/**
 *  将指定的对象转换为JSon字符串
 *
 *  @param object 要转换的对象 注：int/float/NSInteger等转id的方法：id obj = @(123.4);
 *  @result NSString
 */
- (NSString *)getJsonStringFromObj:(id)object {
    NSString *result = [NSString new];
    
    // 获得class的名称以便进行判断
    Class objClass = [object class];
    NSString *className = NSStringFromClass(objClass);
    //    int i1 =0 ;
    //    i1 =[className rangeOfString:@"NSDate"].location;
    //    int i2 =[className rangeOfString:@"NSDate"].length;
    //    int i3 =[className rangeOfString:@"NS"].length;
    //    int i4 =[className rangeOfString:@"NSArray"].length;
    //    int i8 = NSUIntegerMax;
    //    NSUInteger i9 =[NSNumber numberWithUnsignedInteger:-1];
    //    if (i1 == [NSNumber numberWithUnsignedInteger:-1]) {
    //        int f = 0;
    //    }
    //
    //    int textName = [className rangeOfString:@"String"].location;
    
    if((int)[className rangeOfString:@"NSDate"].length> 0) {
        // NSDate
        result = [result stringByAppendingString:@"\""];
        result = [result stringByAppendingString:[[self getDateFormatter] stringFromDate:object]];
        result = [result stringByAppendingString:@"\""];
    } else if ((int)[className rangeOfString:@"NS"].length > 0 && (int)[className rangeOfString:@"String"].length > 0) {
        // NSString
        result = [result stringByAppendingString:@"\""];
        result = [result stringByAppendingString:object];
        result = [result stringByAppendingString:@"\""];
    } else if ((int)[className rangeOfString:@"NS"].length > 0 && (int)[className rangeOfString:@"Number"].length > 0) {
        // NSNumber
        result = [object stringValue];
    } else if ((int)[className rangeOfString:@"NS"].length > 0 && (int)[className rangeOfString:@"Boolean"].length > 0) {    //更改了这里
        // NSBoolean
        if ([object integerValue] == 1) {
            result = @"true";
        }else {
            result = @"false";
        }
    } else if ((int)[className rangeOfString:@"NS"].length > 0 && (int)[className rangeOfString:@"Array"].length > 0) {
        // NSMutableArray
        int count = (int)[object count];
        if (count>0) {
            NSMutableDictionary *propertyDict = [self getObjectPropertyDict:[[object objectAtIndex:0] class]];
            result = [result stringByAppendingString:@"["];
            for (id obj in object) {
                result = [result stringByAppendingString:[self createJsonByObject:obj objPropertyDict:propertyDict]];
                result = [result stringByAppendingString:@","];
            }
            result = [result substringToIndex:[result length]-1];
            result = [result stringByAppendingString:@"]"];
        }
    } else {
        // 按自定义对象序列化json
        NSMutableDictionary *propertyDict = [self getObjectPropertyDict:objClass];
        result = [self createJsonByObject:object objPropertyDict:propertyDict];
    }
    return result;
}

/**
 *  根据对象的成员变量将其转换为json字符串
 *
 *  @param object 要转换为json字符串的对象
 *  @param objPropertyDict 对象class成员变量字典
 *  @result id
 */
- (NSString *)createJsonByObject:(id)object objPropertyDict:(NSMutableDictionary *)objPropertyDict {
    NSString *jsonString = [NSString new];
    jsonString = [jsonString stringByAppendingString:@"{"];
    NSString *propertyName;
    for (propertyName in objPropertyDict) {
        NSString *propertyType = [objPropertyDict objectForKey:propertyName];
        // 获取成员变量值
        id value = [object valueForKey:propertyName];
        if(value == nil) {
            continue;
        }
        jsonString = [jsonString stringByAppendingString:@"\""];
        jsonString = [jsonString stringByAppendingString:propertyName];
        jsonString = [jsonString stringByAppendingString:@"\":"];
        if([propertyType isEqualToString:@"B"]) {
            //BOOL
            if ([value boolValue]) {
                jsonString = [jsonString stringByAppendingString:@"true"];
            }else {
                jsonString = [jsonString stringByAppendingString:@"false"];
            }
        } else if([propertyType isEqualToString:@"i"]) {
            //int
            jsonString = [jsonString stringByAppendingString:[value stringValue]];
        } else if([propertyType isEqualToString:@"q"]) {
            //long
            jsonString = [jsonString stringByAppendingString:[value stringValue]];
        } else if([propertyType isEqualToString:@"f"]) {
            //float
            jsonString = [jsonString stringByAppendingString:[value stringValue]];
        } else if([propertyType isEqualToString:@"d"]) {
            //double
            jsonString = [jsonString stringByAppendingString:[value stringValue]];
        } else if([propertyType isEqualToString:@"^q"]) {
            //NSInteger
            jsonString = [jsonString stringByAppendingString:[value stringValue]];
        } else if([propertyType isEqualToString:@"@\"NSNumber\""]) {
            //NSNumber
            jsonString = [jsonString stringByAppendingString:[value stringValue]];
        } else if([propertyType isEqualToString:@"@\"NSDate\""]) {
            //NSDate
            jsonString = [jsonString stringByAppendingString:@"\""];
            jsonString = [jsonString stringByAppendingString:[[self getDateFormatter] stringFromDate:value]];
            jsonString = [jsonString stringByAppendingString:@"\""];
        } else if([propertyType isEqualToString:@"@\"NSString\""]) {
            //NSString
            jsonString = [jsonString stringByAppendingString:@"\""];
            jsonString = [jsonString stringByAppendingString:value];
            jsonString = [jsonString stringByAppendingString:@"\""];
        } else if([propertyType isEqualToString:@"@\"NSMutableArray\""]) {
            jsonString =  [jsonString stringByAppendingString:[self converseToJsonWith:value]];
            
        } else if ([propertyType rangeOfString:@"NSMutableArray"].length > 0 && [propertyType rangeOfString:@"<"].length > 0 && [propertyType rangeOfString:@"NSString"].length == 0) {
            jsonString = [jsonString stringByAppendingString:[self getJsonStringFromObj:value]];;
        } else {
            //unknown
            jsonString = [jsonString stringByAppendingString:[value stringValue]];
        }
        jsonString = [jsonString stringByAppendingString:@","];
    }
    jsonString = [jsonString substringToIndex:[jsonString length]-1];
    jsonString = [jsonString stringByAppendingString:@"}"];
    return jsonString;
}

- (NSString *)converseToJsonWith:(NSArray *)array
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    } else if ([jsonData length] == 0 &&
             error == nil){
        return nil;
    } else if (error != nil){
        return nil;
    }
    return nil;
    
}

@end
