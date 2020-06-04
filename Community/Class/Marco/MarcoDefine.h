//
//  MarcoDefine.h
//  Test
//
//  Created by Yue Zhang on 2020/3/23.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#ifndef MarcoDefine_h
#define MarcoDefine_h

#define MaxX(view)                  CGRectGetMaxX(view.frame)
#define MaxY(view)                  CGRectGetMaxY(view.frame)
#define X(view)                     view.frame.origin.x
#define Y(view)                     view.frame.origin.y
#define MaxX(view)                  CGRectGetMaxX(view.frame)
#define MaxY(view)                  CGRectGetMaxY(view.frame)

#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define SCREEN_SIZE                 [[UIScreen mainScreen] bounds].size
#define STATUSBAR_HEIGHT            [[UIApplication sharedApplication] statusBarFrame].size.height
#define STATUSBAR_WIDTH             [[UIApplication sharedApplication] statusBarFrame].size.width
#define Current_Window              [[UIApplication sharedApplication] delegate].window

#define HorizationSpacing           (10)
#define TOP_SPACE                   (HighIPhoneX ? (44) : (20))
#define kNavigationBarHeight        44.0f
#define KBottomBarHeight            (HighIPhoneX ? (49 + 34) : (49))
#define TOP_AND_NAVIBAR_SPACE       (HighIPhoneX ? (44 + 44):(44 + 20))
#define TOP_AND_BOTTOM_SPACE        (HighIPhoneX ? (44 + 49 + 34 + 44) : (44 + 49 + 20))
#define TOP_AND_BOTTOM              (HighIPhoneX ? (49 + 44 + 34) : (49 + 20))
#define AutoSizeScaleX              (SCREEN_WIDTH) / 320                                                    //以iphone5为标准 缩放比例
#define AutoSizeScaleY              (SCREEN_HEIGHT - TOP_AND_BOTTOM_SPACE) / (568 - TOP_AND_BOTTOM_SPACE)   //以iphone5为标准 缩放比例
#define MainThemeColor               UIColorFromRGB(0x94c11b)
#define FontSizeScale               ((SCREEN_HEIGHT > 667) ? SCREEN_HEIGHT/667 : 1)                         //以6为基础，适配字体大小

#define IOS9                        [[UIDevice currentDevice].systemVersion floatValue] >= 9.0
#define IOS7                        [[UIDevice currentDevice].systemVersion floatValue] <= 8.0
#define IPHONE4                     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE5                     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define RGBACOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define IPHONE4                     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE5                     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6                     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6P                    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
////2018.9.19添加X系列适配；X和XS分辨率一样
#define IPHONEX                     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONEXSMax                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONEXR                    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPAD                        (([[UIDevice currentDevice].model rangeOfString:@"iPad"].location != NSNotFound))

#define HighIPhone4                 (IPHONE5 || IPHONE6 || IPHONE6P)
#define HighIPhone5                 (IPHONE6 || IPHONE6P)
//2018.9.19添加X系列适配
#define HighIPhoneX                 (IPHONEX || IPHONEXSMax || IPHONEXR)


#define MainGreenColor               RGBACOLOR(92,189,118,1)

#endif /* MarcoDefine_h */
