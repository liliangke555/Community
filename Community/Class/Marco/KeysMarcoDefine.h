//
//  KeysMarcoDefine.h
//  Community
//
//  Created by Yue Zhang on 2020/4/20.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#ifndef KeysMarcoDefine_h
#define KeysMarcoDefine_h

/**
 * 本地用户配置 字典key 类型
 */
#define ReloginClose                    @"reloginClose"         //是否需要自动重新登录 0:需要 1:不需要
#define CurrentNetworkType              @"netWorkStatus"        //当前网络状态 3g wifi none
#define BlockRow                        @"blockRow"             //当前小区  选择row
#define UserAccount                     @"UserAcount"           //当前用户账号(手机号)
#define UserPassword                    @"UserPass"             //当前用户登录密码(未加密)
#define UserLoginStatus                 @"userLoginStatus"      //当前用户登录状态 1已登录 0未登录
#define DeviceID                        @"DeviceID"             //当前用户设备id
#define UserLoginID                     @"identify"             //当前用户的登录id(唯一)
#define ResidentID                      @"residentId"           //当前用户的居民id
#define SelectRowNeighbourCircle        @"neighbourRow"         //邻里圈小类型 选择row
#define SelectRowClassmateCircle        @"classmateRow"         //同学圈小类型 选择row
#define SelectRowCircleType             @"selectCircleType"     //圈子大类型 选择row 1邻里圈 4同学圈
#define VersionUpdateAlert              @"VersionUpdateAlert"   //小版本更新 是否需要弹出Alert 0 需要弹出 1不需要弹出
#define UpdateVersion                   @"updateVersion"        //当前Appstore版本
#define LOGINTYPE                       @"loginType"            //当前登录类型
#define DevelopEnrivonmentType          @"DevelopEnrivonmentType"   //当前开发环境类型
#define Brightness                      @"brightness"           //当前屏幕亮度
#define QRShowView                      @"QRShowView"           //二维码展示界面标识
#define FullOfSession                   @"Session"              //完整的session
#define WeakPassword                    @"weakPassword"         //弱密码，首页需要弹出修改密码的提示
#define AgreemenVersion                 @"AgreemenVersion"      //用户协议等版本号
#define UserAgreement                   @"UserAgreement"        //用户协议
#define PrivacyAgreement                @"PrivacyAgreement"     //隐私协议
#define CancelledAgreement              @"CancelledAgreement"   //注销协议

#endif /* KeysMarcoDefine_h */
