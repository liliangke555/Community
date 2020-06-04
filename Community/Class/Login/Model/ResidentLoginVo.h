//
//  ResidentLogin.h
//  SingleAPP
//
//  Created by howjoy on 15/7/22.
//  Copyright (c) 2015年 lookdoor. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BlockInfoVo.h"

typedef enum{
    loginTypeUser       = 0,            //普通用户登录
    loginTypeMerchant   = 1             //商家企业登录
}loginType;

@interface ResidentLoginVo : NSObject

/**
 * 会员ID
 */
@property NSString *id;

/**
 * 登录名
 */
@property NSString *loginNumber;

/**
 * 用户名
 */
@property NSString *residentName;

/**
 * 类型
 */
@property NSInteger typeId;     //1 居民 2 游客

/*
 *注册身份证
 */
@property NSString *identification;

/**
 * 密码
 **/
@property NSString *password;

/**
 * 公司联系电话
 **/
@property NSString  *contactUsPhoneNum;

/**
 * 登陆头像url
 **/
@property NSString  *headerImagUrl;

/**
 * 身份是否验证
 **/
@property NSInteger checkFlag;      // 0未认证 1 已认证

/**
 * 昵称
 **/
@property NSString  *nickname;

/**
 * 心情
 **/
@property NSString  *mood;

/**
 * 首页url地址
 **/
@property NSString  *indexUrl;      

/**
 * 小区列表
 **/
//@property NSMutableArray<BlockInfoVo> *blockList;//小区列表
/**
 * 小区列表
 **/
@property NSString *loginToken;//token

/**
 * 百川账号
 **/
@property NSString  *imUserId;

/**
 * 密码
 **/
@property NSString  *imUserPwd;

/**
 * 商城账号
 **/
@property NSString  *eshopUserName;

/**
 * 商城密码
 **/
@property NSString  *eshopPwd;

/**
 * 商城accountID
 **/
@property NSString  *eshopAccountId;

/**
 * 隐私协议版本
 */
@property NSString  *privacyVersion;

/**
 * 居民ID
 */
@property NSString  *residentId;

@end
