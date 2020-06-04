//
//  Tools.h
//  Hj_HowJoy_ Official
//
//  Created by howjoy on 15/9/15.
//  Copyright (c) 2015年 lookdoor. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
//#import <CoreMedia/CoreMedia.h>
//#import <AddressBook/AddressBook.h>
//#import <AddressBookUI/AddressBookUI.h>
//#import "IdentifyAlertView.h"
//#import "ImageCompressFunc.h"

typedef enum{
    filterThemeTypeBlack    = 0,
    filterThemeTypeGreen    = 1,
    filterThemeTypeWhite    = 2
    
}filterThemeType;

typedef NS_ENUM(NSInteger, TimeDifference) {
    YearDifference,   //计算年差
    MonthlDifference, //计算月差
    DaysDifference,   //计算日差
    HourDifference,   //计算小时差
    MinuteDifference, //计算分差
    SecondsDifference //计算秒差
};

@interface Tools : NSObject
//<UIAlertViewDelegate>

/**
 *  得到身份证的生日****这个方法中不做身份证校验，请确保传入的是正确身份证
 */
+(NSString *)getIDCardBirthday:(NSString*)card;

/**
 * 判断是否是电话号码  包括固话
 **/
+ (BOOL)isPhoneNumber:(NSString *)mobileNum;

/**
 * 开启/关闭 绕圈动画
 */
+ (void)showWaitingIndicator:(BOOL)show fromView:(UIView *)view andText:(NSString *)text;

/**
 * 去除NavigationBar 下方的分割线
 */
+ (void)deleteNavigationBarSeperator:(UINavigationController *)navi;

/**
 *  获取时间戳
 **/
+ (NSString *)getTimeByTransform:(NSInteger )type;

/**
 *  uilabel格式
 **/
+ (void)labelSetting:(UILabel *)label;

/**
 **  创建粒子效果类方法
 **/
+ (void)addPopGrainTo:(UIView *)view;

/**
 *  判断手机号与密码是否合法关键方法
 **/
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  过滤特殊字符方法
 **/
+(BOOL)isIncludeSpecialCharact:(NSString *)str;


/**
 *  设置navigationBar颜色及字体颜色
 **/
+ (void)changeNavigationBarColor:(UINavigationBar *)navigation;

/**
 *  转换时区
 **/
+ (NSDate *)transformTimeZone:(NSDate *)oldDate;

//转化json对象
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 **输入的日期字符串形如：@"1992-05-21 13:08:08.000"
 **/

+ (NSDate *)dateFromString:(NSString *)dateString;

/**
 *  调整图片大小
 *
 *  @param image 原图片
 *  @param size  要调整的尺寸
 *
 *  @return 返回调整后的UIImage对象
 */
+ (UIImage *)scaleFromImage:(UIImage *)image toSize: (CGSize) size;

//生成随机颜色
+ (UIColor *) randomColor;

/**
 ** 判断时间是不是今天
 **/
+(NSString *)compareDate:(NSDate *)date;

//根据当前时间判断 几天前
+(NSString *)transformDate:(NSDate *)date;

//得到label的高度
+ (CGSize)getLabelHeight:(NSString *)string;

/**
 * 筛选出nsstring中得空格  返回nsstring
 **/
+ (NSString *)replaceStringWithFormat:(NSString *)oldString;

/**
 * 通过特殊字符切割字符串  返回数组array
 **/
+ (NSArray *)incisionString:(NSString *)string byElement:(NSString *)element;

/**
 * 判断身份证是否有效
 **/
+(BOOL)checkIdentityCardNo:(NSString*)cardNo;

/**
 * 判断字符串中是否是朗盛的入住二维码
 * param longString:原字符串  withString:查找的字符串
 * @return Yes: 包含  No: 不包含
 **/
+ (BOOL)checkQrcodeIsLansentBylongString:(NSString *)longString withString:(NSString *)withString;

/**
 * 替换身份证号 从第二位到第十七位 都为*********
 **/
+(NSString*)idCardToAsterisk:(NSString *)idCardNum;

/**
 * 替换电话号码 中间4位数变为*****
 **/
+(NSString*)phoneNumberToAsterisk:(NSString *)phoneNumber;

/**
 * 得到崩溃日志
 **/
+(void)saveCrashLogBy:(NSArray *)stackInfo reason:(NSString *)reason type:(NSString *)type;

/**
 * 查看当前网络是否有效
 * return YES: 有效  NO: 无效
 **/
+(BOOL)isConnectionAvailable;

/**
 * 获取当前周的周一和周日的时间
 */
+ (NSDate *)getWeekTime;

/**
 * 拿到视频的第一帧图片
 */
//+ (UIImage *) thumbnailImageForVideo:(NSString *)videoPath atTime:(NSTimeInterval)time;

/**
 * 判断当前用户是否创建了本地视频缓存路径
 * 如果没有创建 则创建
 */
+ (void)createVideoBufferPathByCurrentUser;

/**
 * 得到当前网络状态
 * 3G Wifi None
 */
+ (void)checkNetworkState;

/**
 * 裁剪图片为正方形
 */
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;
/**
 * 获取通讯录权限
 */
+ (void)loadPerson;
/**
 * 判断有没有该联系人
 */
//+ (void)findPersonWithAddressBook:(ABAddressBookRef)addressBooks andAccessGranted:(BOOL)accessGranted;
/**
 * 添加联系人
 */
+ (void)creatNewRecord;
/**
 * 根据身份证号获取年龄
 */
+ (NSString *)getIdentityCardAge:(NSString *)numberStr;
/**
 * 根据身份证号获取性别
 */
+ (NSString *)getIdentityCardSex:(NSString *)numberStr;
/**
 * 判断字符中是否有空格，空字符
 */
+ (BOOL) isBlankString:(NSString *)string;
/**
 * 校验身份证
 */
+ (BOOL)validateIDCardNumber:(NSString *)value;
/**
 * date转字符串
 */
+ (NSString *)getStringFromDate:(NSDate *)date;

/**
 * 获取唯一标识符
 */
+ (NSString *)getDeviceId;

/**
 * 将base64字符串 转化为 UIimage
 * param Base64
 * @return image
 */
+ (UIImage *)transBase64ToImage:(NSString *)base64String;

/**
 * 生成随机UUID
 * @return UUID String
 */
+ (NSString *)uuidString;

/**
 * 2019年8月15日；原来的计算时间差的方法有误；修改为如下方法
 * 计算时间差
 @param date 传入的date
 @param timeDifference 枚举
 @return NSInteger
 */
+ (NSInteger)nowDateDifferWithDate:(NSDate *)date TimeDifference:(TimeDifference)timeDifference;

/**
 * 获取极光推送registrationID
 */
+ (void)getJPushRegistrationID;

/**
 * 图片url字符串拼接cookie
 @param urlStr 服务器返回的url字符串
 @return 拼接之后的字符串
 */
+ (NSString *)appandSessionToUrl:(NSString *)urlStr;

/**
 * 判断密码是否为强密码
 * 密码6-32位，至少包含一个大写字母、一个小写字母、一个数字、特殊字符可选
 @param password 密码字符串
 @return BOOL
 */
+ (BOOL)isStrongPassword:(NSString *)password;

/**
 * 将密码使用AES/ECB/PKCS5Padding加密
 param NSString 密码字符串
 @param key 密钥Key
 @return 加密后的字符串
 */
+ (NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key;

/**
 * 将字符串进行解密
 param data data
 @param key 密钥key
 @return 解密后的字符串
 */
+ (NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;

/**
 * 2019-12-27 由于之前屏蔽emoji表情，导致九宫格简体拼音键盘无法输入
 * 判断是不是九宫格
 * @param string  输入的字符
 * @return YES(是九宫格拼音键盘)
 */
+ (BOOL)isNineKeyBoard:(NSString *)string;

/// 获取动态配置颜色
/// @param darkColor 暗黑模式颜色
/// @param lightColor 正常模式颜色
+ (UIColor*)getColorWithDark:(UIColor *)darkColor andLightColor:(UIColor *)lightColor;

//用颜色创建一张图片
+ (UIImage *)createImageWithColor:(UIColor *)color;

@end
