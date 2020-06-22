//
//  MessageCenterCollectionCell.m
//  Community
//
//  Created by MAC on 2020/6/2.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "MessageCenterCollectionCell.h"
#import "UIView+CornerCliper.h"
#import "NSString+StringSize.h"

@interface MessageCenterCollectionCell ()

@property (strong, nonatomic) UILabel * bageTitle;
@property (strong, nonatomic) LDBubbleView * bubbleView;

@end

static CGFloat const BubbleHeight = 10.0f;

@implementation MessageCenterCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds) - 25, CGRectGetMidY(self.bounds) - 35, 50, 50)];
    [self addSubview:headerImage];
    [headerImage setContentMode:UIViewContentModeCenter];
    [headerImage setTintColor:MainGreenColor];
    [headerImage clipCorners:UIRectCornerAllCorners radius:16];
    if (@available(iOS 13.0, *)) {
        [headerImage setBackgroundColor:[UIColor systemGray6Color]];
    } else {
        // Fallback on earlier versions
    }
    
    self.headerImage = headerImage;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds) - 25, CGRectGetMaxY(headerImage.frame), 50, 20)];
    [self addSubview:label];
    [label setFont:[UIFont systemFontOfSize:12]];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    self.titleLabel = label;
    
    LDBubbleView *bubble = [[LDBubbleView alloc] init];
    bubble.backgroundColor = [UIColor clearColor];
    [self addSubview:bubble];
    UILabel *bage = [[UILabel alloc] init];
    [bage setFont:[UIFont boldSystemFontOfSize:8]];
    [bage setTextColor:[UIColor whiteColor]];
    [bage setTextAlignment:NSTextAlignmentCenter];
    [bubble addSubview:bage];
    self.bageTitle = bage;
    self.bubbleView = bubble;
    
    self.bubbleView.hidden = YES;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.headerImage.frame = CGRectMake(CGRectGetMidX(self.bounds) - 25, CGRectGetMidY(self.bounds) - 35, 50, 50);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.headerImage.frame), CGRectGetWidth(self.frame), 20);
    
    CGFloat stringWidth = [self.bageString getWidthWithHeight:BubbleHeight font:8];
    stringWidth += 4;
    if (stringWidth > 30) {
        stringWidth = 30;
    }
    self.bubbleView.frame = CGRectMake(CGRectGetMidX(self.bounds) + 8, 0, stringWidth, BubbleHeight);
    self.bageTitle.frame = CGRectMake(0, 0, CGRectGetWidth(self.bubbleView.frame), CGRectGetHeight(self.bubbleView.frame));
}
- (void)setBageString:(NSString *)bageString
{
    _bageString = bageString;
    if (bageString && ![bageString isEqualToString:@""]) {
        self.bageTitle.text = bageString;
        self.bubbleView.hidden = NO;
    } else {
        self.bubbleView.hidden = YES;
    }
}
@end

@implementation LDBubbleView

- (void)drawRect:(CGRect)rect
{
    CGFloat viewW = rect.size.width;
    CGFloat viewH = rect.size.height;
    
    CGFloat strokeWidth = 1;
    CGFloat borderRadius = viewH / 2.0f;
//    CGFloat offset = strokeWidth + 1;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineJoin(context, kCGLineJoinRound); //
    CGContextSetLineWidth(context, strokeWidth); // 设置画笔宽度
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor); // 设置画笔颜色
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor); // 设置填充颜色
    
    // 画三角形
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, borderRadius);
    CGContextAddLineToPoint(context, 0, viewH);

    // 画其余部分
    CGContextAddArcToPoint(context, viewW, viewH, viewW,viewH - borderRadius, borderRadius);
    CGContextAddArcToPoint(context, viewW, 0, viewW-borderRadius, 0, borderRadius);
    CGContextAddArcToPoint(context, 0, 0, 0, borderRadius, borderRadius);

    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
