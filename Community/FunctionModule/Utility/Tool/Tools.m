//
//  Tools.m
//  Hj_HowJoy_ Official
//
//  Created by howjoy on 15/9/15.
//  Copyright (c) 2015年 lookdoor. All rights reserved.
//

#import "Tools.h"
//#import "MBProgressHUD.h"
//#import "StringUtils.h"
//#import "CrashLog.h"
//#import "SqliteOpts.h"
#import "Reachability.h"
#import "SAMKeychain.h"
//#import "XLPaymentLoadingHUD.h"
//// 引入JPush功能所需头文件
//#import "JPUSHService.h"
#import <CommonCrypto/CommonCryptor.h>//AES加密

static NSString *kKeychainService = @"com.lansent.Hj-HowJoy--Official";
static NSString *kKeychainDeviceId    = @"KeychainDeviceId";

@implementation Tools

/**
 *  得到身份证的生日****这个方法中不做身份证校验，请确保传入的是正确身份证
 */
+ (NSString *)getIDCardBirthday:(NSString*)card
{
    card = [card stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([card length]!=18){
        return nil;
    }
    NSString*birthady=[NSString stringWithFormat:@"%@-%@-%@",[card substringWithRange:NSMakeRange(6,4)],[card substringWithRange:NSMakeRange(10,2)],[card substringWithRange:NSMakeRange(12,2)]];
    return birthady;
}

#pragma mark------判断是否是电话号码
+ (BOOL)isPhoneNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)){
        return YES;
    }else{
        return NO;
    }
}

/**
 * 开启/关闭 绕圈动画
 */
+ (void)showWaitingIndicator:(BOOL)show fromView:(UIView *)view andText:(NSString *)text
{
//    if (show) {
//        [XLPaymentLoadingHUD showIn:view modeType:LoadiongHUDModeOrangeType];
//    } else {
//        [XLPaymentLoadingHUD hideIn:view];
//    }
}

/**
 * 去除NavigationBar 下方的分割线
 */
+ (void)deleteNavigationBarSeperator:(UINavigationController *)navi
{
    [navi.navigationBar setBackgroundImage:[UIImage imageNamed:@"back.png"]
                             forBarMetrics:UIBarMetricsDefault];
    navi.navigationBar.barStyle = UIBarStyleBlackTranslucent;

    //去除分割线
    if ([navi.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=navi.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}

/**
 *  获取时间戳
 **/
+ (NSString *)getTimeByTransform:(NSInteger )type
{
    //获取日期
    NSArray * arrWeek=[NSArray arrayWithObjects: @"周六",@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",nil];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay |NSCalendarUnitWeekday |NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger minute = [comps minute];
    NSInteger second = [comps second];
    
    if (type == 0) {
        //年 月
        return [NSString stringWithFormat:@"%ld年%ld月",(long)year,(long)month];
    }else if (type == 1){
        //月 日
        return [NSString stringWithFormat:@"%ld/%ld",(long)month,(long)day];
    }else if (type == 2){
        //周
        return [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week]];
    }else if (type == 3){
        //时 分
        return [NSString stringWithFormat:@"%02ld:%02ld",(long)hour,(long)minute];
    }else if (type == 4){
        //秒
        return [NSString stringWithFormat:@"%ld",(long)second];
    }else {
        //单独的月份
        return [NSString stringWithFormat:@"%ld月",(long)month];
    }
}

/**
 *  uilabel格式
 **/
+ (void)labelSetting:(UILabel *)label
{
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
}

/**
 **  创建粒子效果类方法
 **/
+ (void)addPopGrainTo:(UIView *)view
{
    CAEmitterLayer *fireEmitter = [[CAEmitterLayer alloc]init];//发射器对象
    fireEmitter.emitterPosition=CGPointMake(view.frame.size.width/2,view.frame.size.height/8);
    fireEmitter.emitterSize=CGSizeMake(view.frame.size.width-100, 20);  //发射器的尺寸大小
    fireEmitter.renderMode = kCAEmitterLayerUnordered;  //发射器的渲染模式  无序
    fireEmitter.emitterShape = kCAEmitterLayerSphere;  //发射器的形状 球鞋
    fireEmitter.preservesDepth = YES;                   //是否开启三维空间效果
    //发射单元
    //火焰
    CAEmitterCell * fire = [CAEmitterCell emitterCell];
    fire.birthRate= 2;          //粒子的创建速率
    fire.lifetime= 10.0;        //粒子的生存时间
    fire.lifetimeRange=1.5;     //粒子的生存时间容差
    fire.color = [[UIColor orangeColor]CGColor];
    //    fire.color = [[UIColor colorWithRed:220/255.0 green:223/255.0 blue:227/255.0 alpha:1.0]CGColor];
    fire.contents=(id)[[UIImage imageNamed:@"fire1.png"]CGImage];
    [fire setName:@"fire"];
    fire.scale = 0.5 ;       //粒子的缩放大小
    
    fire.velocity= 80;           //粒子运动速度
    fire.velocityRange=100;      //粒子速度容差
    fire.emissionLongitude=M_PI+M_PI_2;     //粒子在xy平面的发射角度
    fire.emissionLatitude = M_PI;           //粒子在z平面的发射角度
    fire.emissionRange=M_PI_2;              //粒子发射角度的容差
    
    fire.spin=0.2;
    
    fireEmitter.emitterCells = [NSArray arrayWithObjects:fire,nil];
    [view.layer addSublayer:fireEmitter];
    
}

/**
 *  判断手机号与密码是否合法关键方法
 **/
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)){
        return YES;
    }else{
        return NO;
    }
}


/**
 *  过滤特殊字符方法
 **/
+ (BOOL)isIncludeSpecialCharact: (NSString *)str
{
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~ ￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€.-_+=,，。:;""'?!"]];
    if (urgentRange.location == NSNotFound){
        return YES;
    }
    return NO;
}

/**
 *  设置navigationBar颜色及字体颜色
 **/
+ (void)changeNavigationBarColor:(UINavigationBar *)navigation
{
    // 设置导航默认标题的颜色及字体大小
    navigation.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                       NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    
    [navigation setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];       // 设置NavigationBar的文字颜色为白色
    navigation.tintColor = [UIColor whiteColor];
    
    // NavigationBar的颜色为浅蓝色
    [navigation setBarTintColor:RGBACOLOR(89, 157, 252, 1.0)];
}


/**
 *  转换时区
 **/
+ (NSDate *)transformTimeZone:(NSDate *)oldDate
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];//修改时区
    NSInteger interval1 = [zone secondsFromGMTForDate: oldDate];//修改时区
    NSDate *localDate1 = [oldDate  dateByAddingTimeInterval: interval1];//修改时区
    
    return localDate1;
}

//转化json对象
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        return nil;
    }
    return dic;
}


/**
 **输入的日期字符串形如：@"1992-05-21 13:08:08.000"
 **/
+ (NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
}

/**
 *  调整图片大小
 *
 *  @param image 原图片
 *  @param size  要调整的尺寸
 *
 *  @return 返回调整后的UIImage对象
 */
+ (UIImage *)scaleFromImage:(UIImage *)image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width,size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//生成随机颜色
+ (UIColor *)randomColor
{
    CGFloat hue         = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation  = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness  = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

//判断时间是不是今天
+ (NSString *)compareDate:(NSDate *)date
{
    NSDate *today = [[NSDate alloc] init];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        //今天
        return [StringUtils convertDateToString:date formatter:9];
    }else{
        return [StringUtils convertDateToString:date formatter:3];
    }
}

//根据当前时间判断 几天前
+ (NSString *)transformDate:(NSDate *)date
{
    //得到与当前时间差
    NSTimeInterval  timeInterval = [date timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    //timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld个月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

//得到label的高度
+ (CGSize)getLabelHeight:(NSString *)string
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0]};
    
    CGSize size = CGSizeMake(SCREEN_WIDTH - HorizationSpacing *2 - 45.0,2000);
    CGSize labelsize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return labelsize;
}

/**
 * 筛选出nsstring中得空格  返回nsstring
 **/
+ (NSString *)replaceStringWithFormat:(NSString *)oldString
{
    NSCharacterSet *whitespace = [NSCharacterSet  whitespaceAndNewlineCharacterSet];
    NSString *newString = oldString;
    newString = [newString  stringByTrimmingCharactersInSet:whitespace];
    
    return newString;
}

/**
 * 通过特殊字符切割字符串  返回数组array
 **/
+ (NSArray *)incisionString:(NSString *)string byElement:(NSString *)element
{
    // IOS字符串按特定字符拆分成数组
    NSArray  *array= [string componentsSeparatedByString:element];
    return array;
}

#pragma mark - 身份证识别
+ (BOOL)checkIdentityCardNo:(NSString*)cardNo
{
    BOOL flag;
    if (cardNo.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:cardNo];
}

/**
 * 判断字符串中是否是朗盛的入住二维码
 * param longString:原字符串  withString:查找的字符串
 * @return Yes: 包含  No: 不包含
 **/
+ (BOOL)checkQrcodeIsLansentBylongString:(NSString *)longString withString:(NSString *)withString
{
    BOOL flag = NO;
    
    if ([longString rangeOfString:withString].location != NSNotFound) {
        flag = YES;
    }
    
    return flag;
}

/**
 * 替换身份证号 从第二位到第十七位 都为*********
 **/
+ (NSString*)idCardToAsterisk:(NSString *)idCardNum
{
    if (idCardNum.length == 15) {
        return [idCardNum stringByReplacingCharactersInRange:NSMakeRange(1, 13) withString:@"*************"];
    }
    return [idCardNum stringByReplacingCharactersInRange:NSMakeRange(1, 16) withString:@"****************"];
}

/**
 * 替换电话号码 中间4位数变为*****
 **/
+ (NSString*)phoneNumberToAsterisk:(NSString *)phoneNumber
{
    return [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

/**
 * 得到崩溃日志
 **/
+(void)saveCrashLogBy:(NSArray *)stackInfo reason:(NSString *)reason type:(NSString *)type
{
//    //保存到本地数据库
//    CrashLog *log       = [CrashLog new];
//    log.crashType       = type;
//    log.crashReason     = reason;
//    log.stackInfo       = [NSString stringWithFormat:@"%@",stackInfo];
//    log.createTime      = [NSDate new];
//
//    //保存到数据库
//    [[SqliteOpts sharedInstance]saveCrashLogToDB:log];
}

/**
 * 查看当前网络是否有效
 * return YES: 有效  NO: 无效
 **/
+ (BOOL) isConnectionAvailable
{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
        default:
            break;
    }
    
    return isExistenceNetwork;
}

/**
 * 获取当前周的周一和周日的时间
 */
+ (NSDate *)getWeekTime
{
    //新建当前时间
    NSDate *nowDate         = [NSDate date];
    NSCalendar *calendar    = [NSCalendar currentCalendar];
    NSDateComponents *comp  = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay       = [comp weekday];
    // 获取几天是几号
    NSInteger day           = [comp day];
    
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    //    weekDay = 1;
    if (weekDay     == 1){
        firstDiff   = -6;
        lastDiff    = 0;
        
    }else{
        firstDiff   = [calendar firstWeekday] - weekDay + 1;
        lastDiff    = 8 - weekDay;
    }
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    
    //得到周一时间
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit   fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    
    //返回周一时间
    return firstDayOfWeek;
}

/**
 * 拿到视频的第一帧图片
 */
//+ (UIImage *) thumbnailImageForVideo:(NSString *)videoPath atTime:(NSTimeInterval)time {
//    NSURL *url = [NSURL fileURLWithPath:videoPath];
//    
//    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil] ;
//    NSParameterAssert(asset);
//    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset] ;
//    assetImageGenerator.appliesPreferredTrackTransform = YES;
//    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
//    
//    CGImageRef thumbnailImageRef = NULL;
//    CFTimeInterval thumbnailImageTime = time;
//    NSError *thumbnailImageGenerationError = nil;
//    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
//    
//    if (!thumbnailImageRef)
//        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
//    
//    UIImage *thumbnailImage = thumbnailImageRef ?  [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
//    
//    return thumbnailImage;
//}

/**
 * 判断当前用户是否创建了本地视频缓存路径
 * 如果没有创建 则创建
 */
+ (void)createVideoBufferPathByCurrentUser{
    //得到当前用户登录id
    NSString *identifier = [[NSUserDefaults standardUserDefaults] objectForKey:UserLoginID];
    
    //判断是否有本地视频缓存 获得此程序的沙盒路径
    NSString *documentsDirectory    = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //用户自定义路径
    NSString *fileDirectory         = [NSString stringWithFormat:@"%@/myVideo/%@",documentsDirectory,identifier];
    //缓存视频路径
    NSString *downloadFileDire      = [NSString stringWithFormat:@"%@/bufferVideo",documentsDirectory];
    //视频临时文件夹
    NSString *tempFileDirectory     = [NSString stringWithFormat:@"%@/tempPath",documentsDirectory];
    
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:fileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        [[NSFileManager defaultManager] createDirectoryAtPath:fileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 判断缓存路径文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:downloadFileDire]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:downloadFileDire withIntermediateDirectories:YES attributes:nil error:nil];
        [[NSFileManager defaultManager] createDirectoryAtPath:downloadFileDire withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 判断视频临时文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:tempFileDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:tempFileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        [[NSFileManager defaultManager] createDirectoryAtPath:tempFileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

/**
 * 得到当前网络状态
 * 3G Wifi None
 */
+ (void)checkNetworkState
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) {
        // 有wifi
        [myDefault setObject:@"wifi" forKey:CurrentNetworkType];
        
    } else if ([conn currentReachabilityStatus] != NotReachable) {
        // 没有使用wifi, 使用手机自带网络进行上网 3g
        [myDefault setObject:@"3g" forKey:CurrentNetworkType];
        
    } else {
        // 没有网络
        [myDefault setObject:@"none" forKey:CurrentNetworkType];
    }
}

/**
 * 裁剪图片为正方形
 *
 */
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize {
    CGAffineTransform scaleTransform;
    CGPoint origin;
    
    if (image.size.width > image.size.height) {
        //image原始高度为200，缩放image的高度为400pixels，所以缩放比率为2
        CGFloat scaleRatio = newSize / image.size.height;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        //设置绘制原始图片的画笔坐标为CGPoint(-100, 0)pixels
        origin = CGPointMake(-(image.size.width - image.size.height) / 2.0f, 0);
    } else {
        CGFloat scaleRatio = newSize / image.size.width;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        
        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0f);
    }
    
    CGSize size = CGSizeMake(newSize, newSize);
    //创建画板为(400x400)pixels
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将image原始图片(400x200)pixels缩放为(800x400)pixels
    CGContextConcatCTM(context, scaleTransform);
    //origin也会从原始(-100, 0)缩放到(-200, 0)
    [image drawAtPoint:origin];
    
    //获取缩放后剪切的image图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark -- 获取通讯录，创建守望领域电话
+ (void)loadPerson {
//    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
//
//    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
//        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
//
//            CFErrorRef *error1 = NULL;
//            ABAddressBookRef addressBooks = ABAddressBookCreateWithOptions(NULL, error1);
//            [self findPersonWithAddressBook:addressBooks andAccessGranted:granted];
//        });
//    }
//    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
//
//        CFErrorRef *error = NULL;
//        ABAddressBookRef addressBooks = ABAddressBookCreateWithOptions(NULL, error);
//        [self findPersonWithAddressBook:addressBooks andAccessGranted:YES];
//
//    }
//    else {
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        NSInteger firstLogin = [[userDefaults objectForKey:@"FirstLoginFor1.0"] integerValue];
//
//        if (firstLogin < 1) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                // 用户不给权限
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您没有开启通讯录的权限，请到设置>隐私>通讯录打开本应用的权限设置" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                [alert show];
//                return;
//            });
//
//        } else {
//
//        }
//
//    }
    
}

////判断是否有该联系人
//+ (void)findPersonWithAddressBook:(ABAddressBookRef)addressBooks andAccessGranted:(BOOL)accessGranted
//{
//    CFArrayRef records;
//    if (accessGranted) {
//        records = ABAddressBookCopyArrayOfAllPeople(addressBooks);
//
//        BOOL isOrNotContains = NO;
//
//        // 遍历全部联系人，检查是否存在指定号码
//        for (int i = 0; i < CFArrayGetCount(records); i++) {
//            //获取联系人对象的引用
//            ABRecordRef people = CFArrayGetValueAtIndex(records, i);
//            //获取当前联系人名字
//            NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
//
//            //通讯录是否有守望领域门禁
//            if ([firstName isEqualToString:@"守望领域门禁"]) {
//                //获取当前联系人的电话 数组
//                NSMutableArray *phoneArray = [[NSMutableArray alloc]init];
//                ABMultiValueRef phones = ABRecordCopyValue(people, kABPersonPhoneProperty);
//                for (NSInteger j = 0; j < ABMultiValueGetCount(phones); j++) {
//                    NSString *phone = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j));
//                    [phoneArray addObject:phone];
//                }
//
//                NSArray *addPhoneArray = @[@"085128791350",@"085128791351",@"085128791352",@"085128791353",@"085128791354",@"085128791355",@"085128791356",@"085128791357",@"085128791358",@"085128791359",@"085128791360",@"085128791361",@"085128791362",@"085128791363",@"085128791364",@"085128791365",@"085128791366",@"085128791367",@"085128791368",@"085128791369",@"085128791370",@"085128791371",@"085128791372",@"085128791373",@"085128791374",@"085128791375",@"085128791376",@"085128791377",@"085128791378",@"085128791379",@"085128761817",@"085128761819",@"085128761820",@"085128761821",@"085128761822",@"085128761823",@"085128761824",@"085128761825",@"085128761826",@"085128761827",@"085128761828",@"085128761829",@"085128761830",@"085128761831",@"085128761832",@"085128761833",@"085128761834",@"085128761835",@"085128761836",@"085128761837",@"085128761838",@"085128761839",@"085128761840",@"085128761841",@"085128761842",@"085128761843",@"085128761844",@"085128761845",@"085128761846",@"085128761847"
//                    ,@"085128762701",@"085128762702",@"085128762703",@"085128762704",@"085128762705",@"085128762706"
//                    ,@"085128762707",@"085128762708",@"085128762709",@"085128762710",@"085128762711",@"085128762712"
//                    ,@"085128762713",@"085128762714",@"085128762715",@"085128762716",@"085128762717",@"085128762718"
//                    ,@"085128762719",@"085128762720",@"085128767666",@"085128765901",@"085128765902",@"085128765903"
//                    ,@"085128765904",@"085128765905",@"085128765906",@"085128765907",@"085128765908",@"085128765909"
//                    ,@"085128765910",@"085128765911",@"085128765912",@"085128765913",@"085128765914",@"085128765915"
//                    ,@"085128765916",@"085128765917",@"085128765918",@"085128765919",@"085128765920",@"085128765921"
//                    ,@"085128765922",@"085128765923",@"085128765924",@"085128765925",@"085128765926",@"085128765927"
//                    ,@"085128765928",@"085128765929",@"085128765930",@"085128765931",@"085128765932",@"085128765933"
//                    ,@"085128765934",@"085128765935",@"085128765936",@"085128765937",@"085128765938",@"085128765939"
//                    ,@"085128765940",@"085128765941",@"085128765942",@"085128765943",@"085128765944",@"085128765945"
//                    ,@"085128765946",@"085128765947",@"085128765948",@"085128765949",@"085128765950",@"01086210389"
//                    ,@"4000545666"];
//
//                if (addPhoneArray.count == phoneArray.count) {
//                    isOrNotContains = YES;
//                }else {
//                    isOrNotContains = NO;
//                }
//                break;
//            }else  {
//                isOrNotContains = NO;
//            }
//        }
//
//        if (isOrNotContains == YES) {
//
//        }else {
//            for (int i = 0; i < CFArrayGetCount(records); i++) {
//                //获取联系人对象的引用
//                ABRecordRef people = CFArrayGetValueAtIndex(records, i);
//                //获取当前联系人名字
//                NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
//                if ([firstName isEqualToString:@"守望领域门禁"]) {
//                    //删除联系人
//                    ABAddressBookRemoveRecord(addressBooks,people,NULL);
//                    //保存到数据库
//                    ABAddressBookSave(addressBooks, NULL);
//                    break;
//                }
//            }
//            [self creatNewRecord];
//            return;
//        }
//        CFRelease(addressBooks);
//    }
//
//}

//创建联系人
+ (void)creatNewRecord {
//    CFErrorRef error = NULL;
//
//    //创建一个通讯录操作对象
//    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
//
//    //创建一条新的联系人纪录
//    ABRecordRef newRecord = ABPersonCreate();
//
//    //为新联系人记录添加属性值
//    ABRecordSetValue(newRecord, kABPersonFirstNameProperty, (__bridge CFTypeRef)@"守望领域门禁", &error);
//    ABRecordSetValue(newRecord, kABPersonNoteProperty, (__bridge CFTypeRef)@"这是守望领域门禁专线电话，请不要删除哟", &error);
//
//    //添加图片
//    UIImage *image = [UIImage imageNamed:@"contactPhoto.jpg"];
//    NSData  *imageData = UIImageJPEGRepresentation(image, 1);;
//    ABPersonRemoveImageData(newRecord, NULL);
//    ABAddressBookAddRecord(addressBook, newRecord, nil);
//    ABAddressBookSave(addressBook, nil);
//    CFDataRef cfData = CFDataCreate(NULL, [imageData bytes], [imageData length]);
//    ABPersonSetImageData(newRecord, cfData, nil);
//    ABAddressBookAddRecord(addressBook, newRecord, nil);
//    ABAddressBookSave(addressBook, nil);
//
//    //添加电话号码
//    NSArray *phoneArray = @[@"085128791350",@"085128791351",@"085128791352",@"085128791353",@"085128791354",@"085128791355",@"085128791356",@"085128791357",@"085128791358",@"085128791359",@"085128791360",@"085128791361",@"085128791362",@"085128791363",@"085128791364",@"085128791365",@"085128791366",@"085128791367",@"085128791368",@"085128791369",@"085128791370",@"085128791371",@"085128791372",@"085128791373",@"085128791374",@"085128791375",@"085128791376",@"085128791377",@"085128791378",@"085128791379",@"085128761817",@"085128761819",@"085128761820",@"085128761821",@"085128761822",@"085128761823",@"085128761824",@"085128761825",@"085128761826",@"085128761827",@"085128761828",@"085128761829",@"085128761830",@"085128761831",@"085128761832",@"085128761833",@"085128761834",@"085128761835",@"085128761836",@"085128761837",@"085128761838",@"085128761839",@"085128761840",@"085128761841",@"085128761842",@"085128761843",@"085128761844",@"085128761845",@"085128761846",@"085128761847",@"085128762701",@"085128762702",@"085128762703",@"085128762704",@"085128762705",@"085128762706",@"085128762707",@"085128762708",@"085128762709",@"085128762710",@"085128762711",@"085128762712",@"085128762713",@"085128762714",@"085128762715",@"085128762716",@"085128762717",@"085128762718",@"085128762719",@"085128762720",@"085128767666",@"085128765901",@"085128765902",@"085128765903"
//        ,@"085128765904",@"085128765905",@"085128765906",@"085128765907",@"085128765908",@"085128765909",@"085128765910"
//        ,@"085128765911",@"085128765912",@"085128765913",@"085128765914",@"085128765915",@"085128765916",@"085128765917"
//        ,@"085128765918",@"085128765919",@"085128765920",@"085128765921",@"085128765922",@"085128765923",@"085128765924"
//        ,@"085128765925",@"085128765926",@"085128765927",@"085128765928",@"085128765929",@"085128765930",@"085128765931"
//        ,@"085128765932",@"085128765933",@"085128765934",@"085128765935",@"085128765936",@"085128765937",@"085128765938"
//        ,@"085128765939",@"085128765940",@"085128765941",@"085128765942",@"085128765943",@"085128765944",@"085128765945"
//        ,@"085128765946",@"085128765947",@"085128765948",@"085128765949",@"085128765950",@"01086210389",@"4000545666"];
//    //创建一个多值属性
//    ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
//
//    for (int i = 0; i < phoneArray.count; i++) {
//        if (i == phoneArray.count-1) {
//            ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)phoneArray[i], (CFStringRef)@"客服电话", NULL);
//        }else {
//            ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)phoneArray[i], (CFStringRef)@"专线电话", NULL);
//        }
//    }
//
//    //将多值属性添加到记录
//    ABRecordSetValue(newRecord, kABPersonPhoneProperty, multi, &error);
//    CFRelease(multi);
//
//    //添加记录到通讯录操作对象
//    ABAddressBookAddRecord(addressBook, newRecord, &error);
//    //保存通讯录操作对象
//    ABAddressBookSave(addressBook, &error);
//
//    CFRelease(newRecord);
//    CFRelease(addressBook);
}

//根据身份证号性别
+ (NSString *)getIdentityCardSex:(NSString *)numberStr
{
    int sexInt = 0;
    if (numberStr.length == 15) {
        sexInt = [[numberStr substringWithRange:NSMakeRange(13,1)] intValue];
    }else if (numberStr.length == 18) {
        sexInt = [[numberStr substringWithRange:NSMakeRange(16,1)] intValue];
    }
    
    if(sexInt %2 != 0) {
        return @"1";//男
    }else {
        return @"2";//女
    }
}

//根据身份证号获取年龄
+ (NSString *)getIdentityCardAge:(NSString *)numberStr
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss SS"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    NSString *year = [dateString substringToIndex:4];
    
    int age = 0 ;
    if (numberStr.length == 15) {
        NSString *iDYear = [NSString stringWithFormat:@"19%@",[numberStr substringWithRange:NSMakeRange(6,2)]];
        age = ([year intValue]-[iDYear intValue]);
        
    }else if (numberStr.length == 18) {
        NSString *iDYear = [numberStr substringWithRange:NSMakeRange(6,4)];
        age = ([year intValue]-[iDYear intValue]);
    }
    return [NSString stringWithFormat:@"%d",age];
}

/**
 * 判断是否是空字符串
 * param   NSString
 * @return YES: 空字符串  NO: 非空
 */
+ (BOOL) isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]== 0) {
        return YES;
    }
    return NO;
}

//校验身份证
+ (BOOL)validateIDCardNumber:(NSString *)value
{
    NSString *regex2 = @"^[1-9]\\d{14}$|^[1-9]\\d{5}[1-2]\\d{7}\\d{3}[0-9xX]$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];

    if ([identityCardPredicate evaluateWithObject:value]) {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)getStringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+ (NSString *)getDeviceId
{
    // 读取设备号
    NSString *localDeviceId = [SAMKeychain passwordForService:kKeychainService account:kKeychainDeviceId];
    if (!localDeviceId) {
        // 保存设备号
        CFUUIDRef deviceId = CFUUIDCreate(NULL);
        assert(deviceId != NULL);
        CFStringRef deviceIdStr = CFUUIDCreateString(NULL, deviceId);
        [SAMKeychain setPassword:[NSString stringWithFormat:@"%@", deviceIdStr] forService:kKeychainService account:kKeychainDeviceId];
        localDeviceId = [NSString stringWithFormat:@"%@", deviceIdStr];
    }
    return localDeviceId;
}

/**
 * 将base64字符串 转化为 UIimage
 * param Base64
 * @return image
 */
+ (UIImage *)transBase64ToImage:(NSString *)base64String
{
    NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:base64String
                                                                   options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *finalImage = [UIImage imageWithData:decodedImageData];
    return finalImage;
}

/**
 * 生成随机UUID
 * @return UUID String
 */
+ (NSString *)uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    
    CFRelease(uuid_string_ref);
    //移除中间分隔符- 并将字符串中的字母转为大写
    return [[[uuid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""] uppercaseString];
}

/**
 * 2019年8月15日；原来的计算时间差的方法有误；修改为如下方法
 * 计算时间差
 @param date 传入的date
 @param timeDifference 枚举
 @return NSInteger
 */
+ (NSInteger)nowDateDifferWithDate:(NSDate *)date TimeDifference:(TimeDifference)timeDifference
{
//    NSLog(@"推送时间date=%@",date);
    //日期格式设置,可以根据想要的数据进行修改 添加小时和分甚至秒
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];//得到时区，根据手机系统时区设置（systemTimeZone）
    
    NSDate *nowDate = [NSDate date];//获取当前日期
//    NSLog(@"当前时间date=%@",nowDate);
    /*GMT：格林威治标准时间*/
    //格林威治标准时间与系统时区之间的偏移量（秒）
    NSInteger nowInterval = [zone secondsFromGMTForDate:nowDate];
    //将偏移量加到当前日期
    NSDate *nowTime = [nowDate dateByAddingTimeInterval:nowInterval];
//    NSLog(@"当前时间设置格式date=%@",nowTime);
    
    //传入日期设置日期格式
    NSString *stringDate = [dateFormatter stringFromDate:date];
    NSDate *yourDate = [dateFormatter dateFromString:stringDate];
    //格林威治标准时间与传入日期之间的偏移量
    NSInteger yourInterval = [zone secondsFromGMTForDate:yourDate];
    //将偏移量加到传入日期
    NSDate *yourTime = [yourDate dateByAddingTimeInterval:yourInterval];
//    NSLog(@"传入推送时间设置格式date=%@",yourTime);
    
    //time为两个日期的相差秒数
    NSTimeInterval time = [nowTime timeIntervalSinceDate:yourTime];
    
    //最后通过秒数time计算时间相差 几年？几月？几天？几时？几分钟？几秒？
    CGFloat div = 1.0;
    switch (timeDifference) {
        case SecondsDifference:
            div = 1.0;
            break;
        case MinuteDifference:
            div = 60.0;
            break;
        case HourDifference:
            div = 60.0 * 60.0;
            break;
        case DaysDifference:
            div = 60.0 * 60.0 * 24;
            break;
        case MonthlDifference:
            div = 60.0 * 60.0 * 24 * 30;
            break;
        case YearDifference:
            div = 60.0 * 60.0 * 24 * 30 * 365;
            break;
    }
    time = round(time/div);//最后选择四舍五入
    return (NSInteger)time;
}

/**
 * 2019.06.21,获取极光推送registrationID
 */
+ (void)getJPushRegistrationID
{
//    //2.1.9版本新增获取registration id block接口。
//    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
//        if(resCode == 0){
//            //保存到用户配置中
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setObject:registrationID forKey:DeviceID];
//            [defaults synchronize];
//        }else{
//            NSLog(@"Tools*****registrationID获取失败，code：%d",resCode);
//        }
//    }];
}

/**
 * 图片url字符串拼接cookie
 @param urlStr 服务器返回的url字符串
 @return 拼接之后的字符串
 */
+ (NSString *)appandSessionToUrl:(NSString *)urlStr
{
    NSArray *sessionArray = [[NSUserDefaults standardUserDefaults] objectForKey:FullOfSession];
    NSString *newUrl = urlStr;
    //2019年9月24日 增加url有无“?”判断
    if (0 == urlStr.length) {
        return @"";
    }
    if ([urlStr containsString:@"?"]) {
        //url有"?"，直接在url末尾以“&”拼接所有session字段
        NSLog(@"=====url有?");
    }else {
        //url无"?"，直接在url末尾先以“?”拼接第一个session字段，再以“&”拼接剩下的session字段
        NSLog(@"=====url无?");
        newUrl = [NSString stringWithFormat:@"%@?",urlStr];
    }
    if (0 == sessionArray.count) {
        return urlStr;
    }
    newUrl = [newUrl stringByAppendingString:[sessionArray componentsJoinedByString:@"&"]];
    if ([newUrl hasSuffix:@"&"]) {
        newUrl = [newUrl substringToIndex:(newUrl.length - @"&".length)];
    }
    newUrl = [newUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"=======拼接后的图片url=%@",newUrl);
    return newUrl;
}

/**
 * 判断密码是否为强密码
 * 密码6-32位，至少包含一个大写字母、一个小写字母、一个数字、特殊字符可选
 @param password 密码字符串
 @return BOOL
 */
+ (BOOL)isStrongPassword:(NSString *)password
{
    BOOL result = NO;
    
    // 验证密码是否包含数字
    NSString *numPattern = @".*\\d+.*";
    NSPredicate *numPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numPattern];
    // 验证密码是否包含小写字母
    NSString *lowerPattern = @".*[a-z]+.*";
    NSPredicate *lowerPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", lowerPattern];
    // 验证密码是否包含大写字母
    NSString *upperPattern = @".*[A-Z]+.*";
    NSPredicate *upperPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", upperPattern];
    BOOL bContain = ([numPred evaluateWithObject:password]) && ([lowerPred evaluateWithObject:password]) && ([upperPred evaluateWithObject:password]);
    
    if (bContain) {
        result = YES;
    }else {
        result = NO;
    }
    
    return result;
}

/**
 * 将密码使用AES/ECB/PKCS5Padding加密
 param NSString 密码字符串
 @param key 密钥Key
 @return 加密后的字符串
 */
+ (NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key
{
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode, //ECB模式
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,     //没有补码
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        //return [GTMBase64 stringByEncodingData:resultData];
        return [resultData base64EncodedStringWithOptions:0];
        
    }
    free(buffer);
    return nil;
}

/**
 * 将字符串进行解密
 param data data
 @param key 密钥key
 @return 解密后的字符串
 */
+ (NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key
{
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    //NSData *data = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:encryptText options:0];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return nil;
}

/**
 * 2019-12-27 由于之前屏蔽emoji表情，导致九宫格简体拼音键盘无法输入
 * 判断是不是九宫格
 * @param string  输入的字符
 * @return YES(是九宫格拼音键盘)
 */
+ (BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

/// 获取动态配置颜色
/// @param darkColor 暗黑模式颜色
/// @param lightColor 正常模式颜色
+ (UIColor*)getColorWithDark:(UIColor *)darkColor andLightColor:(UIColor *)lightColor
{
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return darkColor;
        }else{
            return lightColor;
        }
    } else {
        return lightColor;
    }
    
}

//用颜色创建一张图片
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
