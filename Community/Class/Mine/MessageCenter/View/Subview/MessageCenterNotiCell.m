//
//  MessageCenterNotiCell.m
//  Community
//
//  Created by MAC on 2020/6/2.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "MessageCenterNotiCell.h"
#import "UIView+CornerCliper.h"

@interface MessageCenterNotiCell ()

@property (strong, nonatomic) UIImageView * backImage;
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UILabel * subLabel;
@property (strong, nonatomic) UIButton * closeButton;
@property (strong, nonatomic) UIButton * goButton;

@end

@implementation MessageCenterNotiCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backImage.frame = CGRectMake(16, 8, CGRectGetWidth(self.bounds) - 32, CGRectGetHeight(self.bounds) - 16);
    self.titleLabel.frame = CGRectMake(16, CGRectGetMidY(self.backImage.bounds) - 17, CGRectGetWidth(self.backImage.bounds) - 16-100, 20);
    self.subLabel.frame = CGRectMake(16, CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.titleLabel.bounds), 14);
    self.closeButton.frame = CGRectMake(CGRectGetMaxX(self.backImage.bounds) - 20, 0, 20, 20);
    self.goButton.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), CGRectGetMidY(self.backImage.bounds) - 12, 70, 24);
    [self.goButton clipCorners:UIRectCornerAllCorners radius:12];
    [self.backImage clipCorners:UIRectCornerAllCorners radius:5];
}

- (void)setupView
{
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 8, CGRectGetWidth(self.bounds) - 16, CGRectGetHeight(self.bounds) - 24)];
    [self addSubview:backImage];
    if (@available(iOS 13.0, *)) {
        backImage.backgroundColor = [UIColor systemGrayColor];
    } else {
        // Fallback on earlier versions
    }
    self.backImage = backImage;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, CGRectGetWidth(backImage.bounds) - 16-100, 20)];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [backImage addSubview:titleLabel];
    titleLabel.text = @"打开消息通知";
    self.titleLabel = titleLabel;
    
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(titleLabel.bounds), 14)];
    [subLabel setFont:[UIFont systemFontOfSize:12]];
    [subLabel setTextColor:[UIColor whiteColor]];
    [backImage addSubview:subLabel];
    subLabel.text = @"不错过小区、家人、邻居的消息";
    self.subLabel = subLabel;
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (@available(iOS 13.0, *)) {
        UIImage *image = [UIImage systemImageNamed:@"xmark.circle.fill"];
        [closeButton setImage:image forState:UIControlStateNormal];
    } else {
        // Fallback on earlier versions
    }
    [backImage addSubview:closeButton];
    [closeButton setTintColor:MainGreenColor];
    self.closeButton = closeButton;
    [closeButton addTarget:self action:@selector(didClickClose:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"去开启" forState:UIControlStateNormal];
    [button setBackgroundColor:MainGreenColor];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [backImage addSubview:button];
    self.goButton = button;
    [button addTarget:self action:@selector(didClickGo:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)didClickGo:(UIButton *)sender
{
    
}
- (void)didClickClose:(UIButton *)sender
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
