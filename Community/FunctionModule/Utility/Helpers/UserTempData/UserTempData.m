//
//  UserTempData.m
//  ExpectField
//
//  Created by Lansent_Css on 2018/3/19.
//  Copyright © 2018年 lookdoor. All rights reserved.
//

#import "UserTempData.h"
//#import "SqliteOpts.h"

@interface UserTempData ()
{
    ResidentLoginVo *_loginVo;
}
@end

@implementation UserTempData

/**
 *  检查是否是测试环境
 *  True 测试与生产可切换
 *  False 生产独占 不可切换
 */
static bool isDebug = true;

/**
 *  创建单例对象
 *
 *  return 单例对象
 */
+ (UserTempData *) sharedInstance
{
    static UserTempData *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

/**
 *  初始化函数
 */
- (UserTempData *)init
{
    if ((self = [super init])) {
        if (_loginVo == nil) {
            _loginVo = [ResidentLoginVo new];
        }
    }
    return self;
}

/**
 * 检查是否是测试环境
 * return True 测试与生产可切换 False 生产独占 不可切换
 */
- (BOOL)checkDebugEnvironment
{
    return isDebug;
}

/**
 * 保存小区数据到临时变量中
 * param BlockInfo List
 */
- (void)saveBlockList:(NSMutableArray *)array
{
//    _loginVo.blockList = array;
}

/**
 * 从临时变量中获取小区列表数据
 * return BlockInfo List
 */
- (NSMutableArray *)getBlockList
{
//    if (_loginVo.blockList.count == 0) {
//        _loginVo.blockList = [[SqliteOpts sharedInstance]getBlockInformationFromDB];
//    }
//    return _loginVo.blockList;
    return 0;
}

/**
 * 保存当前登录用户信息
 * param ResidentLoginVo
 */
- (BOOL)saveResidentLoginVo:(ResidentLoginVo *)loginVo
{
//    _loginVo            = loginVo;
//    _loginVo.blockList  = loginVo.blockList;
    
    return YES;
}

/**
 * 从临时变量中获取当前登录用户信息
 * return ResidentLoginVo
 */
- (ResidentLoginVo *)getResidentLoginVo
{
//    if (_loginVo.loginNumber.length == 0) {
//        _loginVo = [[SqliteOpts sharedInstance]getCurrentPersonalInfomationFromDB];
//    }
    return _loginVo;
}

@end
