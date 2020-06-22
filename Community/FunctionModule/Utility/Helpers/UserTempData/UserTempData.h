//
//  UserTempData.h
//  ExpectField
//
//  Created by Lansent_Css on 2018/3/19.
//  Copyright © 2018年 lookdoor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResidentLoginVo.h"

@interface UserTempData : NSObject

/**
 *  创建单例对象
 *  return 单例对象
 */
+ (UserTempData *) sharedInstance;

/**
 * 检查是否是测试环境
 * @return Bool
 */
- (BOOL)checkDebugEnvironment;

/**
 * 保存小区数据到临时变量中
 * param BlockInfo list
 */
- (void)saveBlockList:(NSMutableArray *)array;

/**
 * 从临时变量中获取小区列表数据
 * @return BlockInfo List
 */
- (NSMutableArray *)getBlockList;

/**
 * 保存当前登录用户信息
 * param loginVo
 */
- (BOOL)saveResidentLoginVo:(ResidentLoginVo *)loginVo;

/**
 * 从临时变量中获取当前登录用户信息
 * return ResidentLoginVo
 */
- (ResidentLoginVo *)getResidentLoginVo;

@end
