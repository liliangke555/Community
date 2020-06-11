//
//  MineHeaderView.m
//  Community
//
//  Created by 大菠萝 on 2020/4/22.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "MineHeaderView.h"
#import "UIView+CornerCliper.h"

@interface SecondView : UIView

@end

@interface MineHeaderView ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(iOS 13.0, *)) {
            self.backgroundColor = [UIColor systemGray5Color];
        } else {
            // Fallback on earlier versions
        }
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 84, 100, 24)];
    [label setFont:[UIFont boldSystemFontOfSize:24]];
//    [label setTextColor:[UIColor sys]];
    [label setText:@"大菠萝"];
    [self addSubview:label];
    self.nameLabel = label;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMidY(label.frame) - 5, 32, 10)];
    [self addSubview:imageView];
    
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(label.frame) + 12, CGRectGetWidth(self.frame) - 128, 24)];
    [subLabel setFont:[UIFont systemFontOfSize:12]];
    [subLabel setText:@"错误的决定比没有决定更好"];
    [subLabel setTextColor:RGBACOLOR(98, 102, 100, 1)];
    [self addSubview:subLabel];
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 116, 64, 100, 100)];
    [headerImageView clipCorners:UIRectCornerAllCorners radius:50];
    [self addSubview:headerImageView];
    [headerImageView setTintColor:MainThemeColor];
    if (@available(iOS 13.0, *)) {
        [headerImageView setImage:[UIImage systemImageNamed:@"person.circle"]];
    } else {
        // Fallback on earlier versions
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = nil;
    if (@available(iOS 13.0, *)) {
        image = [UIImage systemImageNamed:@"pencil.circle.fill"];
    } else {
        image = [UIImage imageNamed:@""];
    }
    [button setBackgroundImage:image forState:UIControlStateNormal];
//    [button.imageView setTintColor:MainThemeColor];
//    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(CGRectGetMaxX(headerImageView.frame) - 32, CGRectGetMaxY(headerImageView.frame) - 32, 32, 32);
    [button clipCorners:UIRectCornerAllCorners radius:12.5];
    [button addTarget:self action:@selector(didTapView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    {
        SecondView *view = [[SecondView alloc] initWithFrame:CGRectMake(16, CGRectGetHeight(self.frame) - 125, CGRectGetWidth(self.frame) - 32, 125)];
        view.backgroundColor = RGBACOLOR(52, 68, 84, 1);
        [self addSubview:view];
        [view clipCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:10.0f];
    
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 20, 15)];
        [imageView setContentMode:UIViewContentModeCenter];
        [view addSubview:imageView];
        
        UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 8, CGRectGetMinY(imageView.frame), CGRectGetWidth(view.frame) - 55, 17)];
        [addLabel setFont:[UIFont systemFontOfSize:14]];
        [addLabel setTextColor:[UIColor whiteColor]];
        [addLabel setText:@"昌都地区芒康县创业小区1栋1单元679号"];
        [view addSubview:addLabel];
        
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(view.frame) - 26, CGRectGetMinY(imageView.frame), 10, 15)];
//        imageView1.backgroundColor = [UIColor grayColor];
        [view addSubview:imageView1];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY( imageView.frame) + 16, CGRectGetWidth(view.frame) - 32, 0.5)];
        line.backgroundColor = RGBACOLOR(98, 116, 133, 1);
        [view addSubview:line];
        
        
        UILabel *allLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(line.frame) + 16, 50, 15)];
        [allLabel setFont:[UIFont systemFontOfSize:14]];
        [allLabel setTextColor:[UIColor whiteColor]];
        [allLabel setText:@"全部"];
        [allLabel setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:allLabel];
        
        UILabel *allLabelNum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(allLabel.frame), CGRectGetMaxY(allLabel.frame), CGRectGetWidth(allLabel.frame), 40)];
        [allLabelNum setFont:[UIFont boldSystemFontOfSize:24]];
        [allLabelNum setTextColor:[UIColor whiteColor]];
        [allLabelNum setText:@"6"];
        [allLabelNum setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:allLabelNum];
        
        UILabel *available = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(allLabel.frame) + 32, CGRectGetMaxY(line.frame) + 16, CGRectGetWidth(allLabel.frame), 15)];
        [available setFont:[UIFont systemFontOfSize:14]];
        [available setTextColor:[UIColor whiteColor]];
        [available setText:@"可用"];
        [available setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:available];
        
        UILabel *availableNum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(available.frame), CGRectGetMaxY(available.frame), CGRectGetWidth(allLabel.frame), 40)];
        [availableNum setFont:[UIFont boldSystemFontOfSize:24]];
        [availableNum setTextAlignment:NSTextAlignmentCenter];
        [availableNum setTextColor:[UIColor greenColor]];
        [availableNum setText:@"7"];
        
        [view addSubview:availableNum];
        
        UILabel *overdue = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(available.frame) + 32, CGRectGetMaxY(line.frame) + 16, CGRectGetWidth(allLabel.frame), 15)];
        [overdue setFont:[UIFont systemFontOfSize:14]];
        [overdue setTextColor:[UIColor whiteColor]];
        [overdue setText:@"过期"];
        [overdue setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:overdue];
        
        UILabel *overdueNum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(overdue.frame), CGRectGetMaxY(overdue.frame), CGRectGetWidth(allLabel.frame), 40)];
        [overdueNum setFont:[UIFont boldSystemFontOfSize:24]];
        [overdueNum setTextColor:[UIColor yellowColor]];
        [overdueNum setTextAlignment:NSTextAlignmentCenter];
        [overdueNum setText:@"4"];
        [view addSubview:overdueNum];
        
        UIButton *myKey = [UIButton buttonWithType:UIButtonTypeCustom];
        [myKey setTitle:@"我的钥匙" forState:UIControlStateNormal];
        [myKey.titleLabel setFont:[UIFont systemFontOfSize:14]];
        myKey.frame = CGRectMake(CGRectGetWidth(view.frame) - 116, CGRectGetMinY(allLabel.frame), 100, 15);
        [myKey setImageEdgeInsets:UIEdgeInsetsMake(0, 70, 0, -70)];
        [myKey.imageView setContentMode:UIViewContentModeCenter];
        [view addSubview:myKey];
        [myKey addTarget:self action:@selector(myKeyAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (@available(iOS 13.0, *)) {
            [imageView setTintColor:[UIColor systemGray2Color]];
            [imageView setImage:[UIImage systemImageNamed:@"person.icloud.fill"]];
            
            [imageView1 setTintColor:[UIColor systemGray2Color]];
            [imageView1 setImage:[UIImage systemImageNamed:@"chevron.right"]];
            
            [myKey.imageView setTintColor:[UIColor systemGray2Color]];
            [myKey setImage:[UIImage systemImageNamed:@"chevron.right"] forState:UIControlStateNormal];
        } else {
            // Fallback on earlier versions
        }
    }
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)]];
}

- (void)didTapView:(UITapGestureRecognizer *)sender
{
    if (self.didTapView) {
        self.didTapView();
    }
}
- (void)setDidTapView:(void (^)(void))didTapView
{
    _didTapView = didTapView;
}
- (void)myKeyAction:(UIButton *)sender
{
    
}

- (void)drawRect:(CGRect)rect
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClip(context);
//    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
//    CGFloat colors[] = {
//        226.0 / 255.0, 228.0 / 255.0, 230.0 / 255.0, 1.00,
//        226.0 / 255.0, 239.0 / 255.0, 233.0 / 255.0, 1.00,
//        226.0 / 255.0,  243.0 / 255.0, 235.0 / 255.0, 1.00,
//    };
//    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors) / (sizeof(colors[0]) * 4));
//    CGColorSpaceRelease(rgb);
//    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0,rect.size.height), CGPointMake(rect.size.width, 0.0), kCGGradientDrawsBeforeStartLocation);
}


#pragma mark - Getter
@end


@implementation SecondView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClip(context);
//    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
//    CGFloat colors[] = {
//        49.0 / 255.0, 65.0 / 255.0, 81.0 / 255.0, 1.00,
//        62.0 / 255.0, 83.0 / 255.0, 103.0 / 255.0, 1.00,
//        86.0 / 255.0,  105.0 / 255.0, 124.0 / 255.0, 1.00,
//    };
//    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors) / (sizeof(colors[0]) * 4));
//    CGColorSpaceRelease(rgb);
//    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0,rect.size.height), CGPointMake(rect.size.width, 0.0), kCGGradientDrawsBeforeStartLocation);
}


@end
