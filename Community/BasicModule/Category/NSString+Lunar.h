//
//  NSString+Lunar.h
//  Community
//
//  Created by MAC on 2020/6/11.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Lunar)

+ (NSString *)LunarForSolarYear:(NSInteger)wCurYear Month:(NSInteger)wCurMonth Day:(NSInteger)wCurDay;
+ (NSString *)getRizhiWithdate:(NSDate *)date1;
+ (NSString*)getshierjian:(NSInteger)month string:(NSString*)rizhi;

@end

NS_ASSUME_NONNULL_END
