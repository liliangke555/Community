//
//  下划线 UnderlineText.m
//  Community
//
//  Created by 大菠萝 on 2020/4/21.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "UnderlineText.h"

@implementation UnderlineText

- (void)drawRect:(CGRect)rect
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
//    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 1));
//    CGContextStrokePath(context);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [RGBACOLOR(201, 201, 201, 1) set];//设置下划线颜色 这里是红色 可以自定义
    CGFloat y = CGRectGetHeight(self.frame);
    CGContextMoveToPoint(context, 0, y);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), y);
    //设置线的宽度
    CGContextSetLineWidth(context, 1);
    //渲染 显示到self上
    CGContextStrokePath(context);
}

@end
