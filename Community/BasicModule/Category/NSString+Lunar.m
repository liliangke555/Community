//
//  NSString+Lunar.m
//  Community
//
//  Created by MAC on 2020/6/11.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "NSString+Lunar.h"

@implementation NSString (Lunar)

//农历转换函数
+ (NSString *)LunarForSolarYear:(NSInteger)wCurYear Month:(NSInteger)wCurMonth Day:(NSInteger)wCurDay
{
    //农历日期名
    NSArray *cDayName =  [NSArray arrayWithObjects:@"*",@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                          @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                          @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    //农历月份名
    NSArray *cMonName =  [NSArray arrayWithObjects:@"*",@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"腊",nil];
    //公历每月前面的天数
    const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    //农历数据
    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
        ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
        ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
        ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
        ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
        ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
        ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
        ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
        ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
        ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
    
    static int nTheDate,nIsEnd,m,k,n,i,nBit;
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    
    if((!(wCurYear % 4)) && (wCurMonth > 2))
        nTheDate = nTheDate + 1;
    
    //计算农历天干、地支、月、日
    nIsEnd = 0;
    m = 0;
    
    while(nIsEnd != 1) {
        if(wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while(n>=0) {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            for(i=1;i< n+1;i++)
                nBit = nBit/2;
                nBit = nBit % 2;
            if (nTheDate <= (29 + nBit)) {
                nIsEnd = 1;
                break;
            }
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }
        if(nIsEnd)
            break;
        m = m + 1;
    }
    
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    
    if (k == 12) {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            wCurMonth = 1 - wCurMonth;
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }
    //生成农历月
    NSString *szNongliMonth;
    if (wCurMonth < 1){
        szNongliMonth = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
    }else{
        szNongliMonth = (NSString *)[cMonName objectAtIndex:wCurMonth];
    }
    //生成农历日
    NSString *szNongliDay = [cDayName objectAtIndex:wCurDay];
    //合并
    NSString *lunarDate = [NSString stringWithFormat:@"农历%@月%@",szNongliMonth,szNongliDay];
    return lunarDate;
}

+ (NSArray *)getShengxiao
{
    return @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
}

+ (NSString*)getshierjian:(NSInteger)month string:(NSString*)rizhi
{
    if (month < 1 || month > 12) {
        return nil;
    }
    rizhi = [rizhi substringFromIndex:1];
    NSInteger riziindex = [self getarrayindex:[self getShengxiao] string:rizhi];
    return [self shierxingjianpanduan:[self getData][riziindex][month - 1]];
}

+ (NSString *)shierxingjianpanduan:(NSString*)shierjianString{
    NSArray * jian1 = @[@"赴任",@"祈福",@"求嗣",@"破土",@"安葬",@"修造",@"上梁",@"求财"];
    NSArray * jian2 = @[@"动土",@"开仓",@"掘井",@"乘船",@"新船下水",@"新车下地",@"维修水电器具"];
    
    NSArray * chu1 = @[@"祭祀",@"祈福",@"婚姻",@"出行",@"入伙",@"搬迁",@"出货",@"动土",@"求医",@"交易"];
    NSArray * chu2 = @[@"结婚",@"赴任",@"远行",@"签约"];
    
    NSArray * man1 = @[@"嫁娶",@"祈福",@"移徙",@"开市",@"交易",@"求财",@"立契",@"祭祀",@"出行",@"牧养"];
    NSArray * man2 = @[@"造葬",@"赴任",@"求医"];
    
    NSArray * ping1 = @[@"嫁娶",@"修造",@"破土",@"安葬",@"牧养",@"开市",@"安床",@"动土",@"求嗣"];
    NSArray * ping2 = @[@"祈福",@"求嗣",@"赴任",@"嫁娶",@"开市",@"安葬"];
    
    NSArray * ding1 = @[@"祭祀",@"祈福",@"嫁娶",@"造屋",@"装修",@"修路",@"开市",@"入学",@"上任",@"入伙"];
    NSArray * ding2 = @[@"诉讼",@"出行",@"交涉"];
    
    NSArray * zhi1 = @[@"造屋",@"装修",@"嫁娶",@"收购",@"立契",@"祭祀"];
    NSArray * zhi2 = @[@"开市",@"求财",@"出行",@"搬迁"];
    
    NSArray * po1 = @[@"破土",@"拆卸",@"求医"];
    NSArray * po2 = @[@"嫁娶",@"签约",@"交涉",@"出行",@"搬迁"];
    
    NSArray * wei1 = @[@"祭祀",@"祈福",@"安床",@"拆卸",@"破土"];
    NSArray * wei2 = @[@"登山",@"乘船",@"出行",@"嫁娶",@"造葬",@"迁徙"];
    
    NSArray * cheng1 = @[@"结婚",@"开市",@"修造",@"动土",@"安床",@"破土",@"安葬",@"搬迁",@"交易",@"求财",@"出行",@"立契",@"竖柱",@"裁种",@"牧养"];
    NSArray * cheng2 = @[@"诉讼"];
    
    NSArray * shou1 = @[@"祈福",@"求嗣",@"赴任",@"嫁娶",@"安床",@"修造",@"动土",@"求学",@"开市",@"交易",@"买卖",@"立契"];
    NSArray * shou2 = @[@"放债",@"新船下水",@"新车下地",@"破土",@"安葬"];
    
    NSArray * kai1 = @[@"祭祀",@"祈福",@"入学",@"上任",@"修造",@"动土",@"开市",@"安床",@"交易",@"出行",@"竖柱"];
    NSArray * kai2 = @[@"放债",@"诉讼",@"安葬"];
    
    NSArray * bi1 = @[@"祭祀",@"祈福",@"筑堤",@"埋池",@"埋穴",@"造葬",@"填补",@"修屋"];
    NSArray * bi2 = @[@"开市",@"出行",@"求医",@"手术",@"嫁娶"];
    NSString * cand = @"";
    NSString * canot = @"";
    if ([shierjianString isEqualToString:@"建"]) {
        for (int i = 0; i < jian1.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",jian1[i]];
            cand = [cand stringByAppendingString:b];
        }
        for (int i = 0; i < jian2.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",jian2[i]];
            canot = [canot stringByAppendingString:b];
        }
    }
    if ([shierjianString isEqualToString:@"除"]) {
        for (int i = 0; i < chu1.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",chu1[i]];
            cand = [cand stringByAppendingString:b];
        }
        for (int i = 0; i < chu2.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",chu2[i]];
            canot = [canot stringByAppendingString:b];
        }
    }
    if ([shierjianString isEqualToString:@"满"]) {
        for (int i = 0; i < man1.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",man1[i]];
            cand = [cand stringByAppendingString:b];
        }
        for (int i = 0; i < man2.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",man2[i]];
            canot = [canot stringByAppendingString:b];
        }
    }
    if ([shierjianString isEqualToString:@"平"]) {
        for (int i = 0; i < ping1.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",ping1[i]];
            cand = [cand stringByAppendingString:b];
        }
        for (int i = 0; i < ping2.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",ping2[i]];
            canot = [canot stringByAppendingString:b];
        }
    }
    if ([shierjianString isEqualToString:@"定"]) {
        for (int i = 0; i < ding1.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",ding1[i]];
            cand = [cand stringByAppendingString:b];
        }
        for (int i = 0; i < ding2.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",ding2[i]];
            canot = [canot stringByAppendingString:b];
        }
    }
    if ([shierjianString isEqualToString:@"执"]) {
        for (int i = 0; i < zhi1.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",zhi1[i]];
            cand = [cand stringByAppendingString:b];
        }
        for (int i = 0; i < zhi2.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",zhi2[i]];
            canot = [canot stringByAppendingString:b];
        }
    }
    if ([shierjianString isEqualToString:@"破"]) {
        for (int i = 0; i < po1.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",po1[i]];
            cand = [cand stringByAppendingString:b];
        }
        for (int i = 0; i < po2.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",po2[i]];
            canot = [canot stringByAppendingString:b];
        }
    }
    if ([shierjianString isEqualToString:@"危"]) {
        for (int i = 0; i < wei1.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",wei1[i]];
            cand = [cand stringByAppendingString:b];
        }
        for (int i = 0; i < wei2.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",wei2[i]];
            canot = [canot stringByAppendingString:b];
        }
    }
    if ([shierjianString isEqualToString:@"成"]) {
        for (int i = 0; i < cheng1.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",cheng1[i]];
            cand = [cand stringByAppendingString:b];
        }
        for (int i = 0; i < cheng2.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",cheng2[i]];
            canot = [canot stringByAppendingString:b];
        }
    }
    if ([shierjianString isEqualToString:@"收"]) {
        for (int i = 0; i < shou1.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",shou1[i]];
            cand = [cand stringByAppendingString:b];
        }
        for (int i = 0; i < shou2.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",shou2[i]];
            canot = [canot stringByAppendingString:b];
        }
    }
    if ([shierjianString isEqualToString:@"开"]) {
        for (int i = 0; i < kai1.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",kai1[i]];
            cand = [cand stringByAppendingString:b];
        }
        for (int i = 0; i < kai2.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",kai2[i]];
            canot = [canot stringByAppendingString:b];
        }
    }
    if ([shierjianString isEqualToString:@"闭"]) {
        for (int i = 0; i < bi1.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",bi1[i]];
            cand = [cand stringByAppendingString:b];
        }
        for (int i = 0; i < bi2.count; i++) {
            NSString * b = [NSString stringWithFormat:@" %@",bi2[i]];
            canot = [canot stringByAppendingString:b];
        }
    }
    return [NSString stringWithFormat:@"宜:%@  忌:%@",cand,canot];
}

+ (NSInteger)getarrayindex:(NSArray*)array string:(NSString*)target{
    for (int i = 0; i < array.count; i++) {
        if ([array[i] isEqualToString:target]) {
            return i;
        }
    }
    return -1;
}

/**
 * 六十甲子
 */
+ (NSArray *)getjiaZi{
        return @[@"甲子",@"乙丑",@"丙寅",@"丁卯",@"戊辰",@"己巳",@"庚午",@"辛未",@"壬申",@"癸酉",
                  @"甲戌",@"乙亥",@"丙子",@"丁丑",@"戊寅",@"己卯",@"庚辰",@"辛巳",@"壬午",@"癸未",
                  @"甲申",@"乙酉",@"丙戌",@"丁亥",@"戊子",@"己丑",@"庚寅",@"辛卯",@"壬辰",@"癸巳",
                  @"甲午",@"乙未",@"丙申",@"丁酉",@"戊戌",@"己亥",@"庚子",@"辛丑",@"壬寅",@"癸卯",
                  @"甲辰",@"乙巳",@"丙午",@"丁未",@"戊申",@"己酉",@"庚戌",@"辛亥",@"壬子",@"癸丑",
                  @"甲寅",@"乙卯",@"丙辰",@"丁巳",@"戊午",@"己未",@"庚申",@"辛酉",@"壬戌",@"癸亥"
                   ];
}

+ (NSString *)getRizhiWithdate:(NSDate *)date1
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd"];//设置时间格式//很重要
    NSDate *day2=[date dateFromString:@"1900-01-31"];
    //求出和1900年1月31日相差的天数
    NSInteger offset = [self numberOfDaysWithFromDate:day2 toDate:date1];
    offset=(offset+40)%60;
    //求的日的干支

    return [self getjiaZi][offset];

}

/**
 * @method
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents    * comp = [calendar components:NSCalendarUnitDay
                                             fromDate:fromDate
                                               toDate:toDate
                                              options:NSCalendarWrapComponents];
    return comp.day;
}

+ (NSArray *)getData{
    return @[@[@"开",@"收",@"成",@"危",@"破",@"执",@"定",@"平",@"满",@"除",@"建",@"闭"],
                  @[@"闭",@"开",@"收",@"成",@"危",@"破",@"执",@"定",@"平",@"满",@"除",@"建"],
                  @[@"建",@"闭",@"开",@"收",@"成",@"危",@"破",@"执",@"定",@"平",@"满",@"除"],
                  @[@"除",@"建",@"闭",@"开",@"收",@"成",@"危",@"破",@"执",@"定",@"平",@"满"],
                  @[@"满",@"除",@"建",@"闭",@"开",@"收",@"成",@"危",@"破",@"执",@"定",@"平"],
                  @[@"平",@"满",@"除",@"建",@"闭",@"开",@"收",@"成",@"危",@"破",@"执",@"定"],
                  @[@"定",@"平",@"满",@"除",@"建",@"闭",@"开",@"收",@"成",@"危",@"破",@"执"],
                  @[@"执",@"定",@"平",@"满",@"除",@"建",@"闭",@"开",@"收",@"成",@"危",@"破"],
                  @[@"破",@"执",@"定",@"平",@"满",@"除",@"建",@"闭",@"开",@"收",@"成",@"危"],
                  @[@"危",@"破",@"执",@"定",@"平",@"满",@"除",@"建",@"闭",@"开",@"收",@"成"],
                  @[@"成",@"危",@"破",@"执",@"定",@"平",@"满",@"除",@"建",@"闭",@"开",@"收"],
                  @[@"收",@"成",@"危",@"破",@"执",@"定",@"平",@"满",@"除",@"建",@"闭",@"开"],];

}

@end
