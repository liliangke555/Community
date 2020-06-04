//
//  MessageCenterCommunityNoticeCell.m
//  Community
//
//  Created by MAC on 2020/6/2.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "MessageCenterCommunityNoticeCell.h"
#import "UIView+CornerCliper.h"

@interface MessageCenterCommunityNoticeCell ()

@property (strong, nonatomic) UIView * backView;
@property (strong, nonatomic) UILabel * bigtitleLabel;
@property (strong, nonatomic) UILabel * subtitleLabel;
@property (strong, nonatomic) UILabel * timeLabel;
@property (strong, nonatomic) UIImageView * bigimageView;

@end

@implementation MessageCenterCommunityNoticeCell

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

- (void)setupView
{
    UIView *backView = [[UIView alloc] init];
    if (@available(iOS 13.0, *)) {
        backView.backgroundColor = [UIColor systemGray5Color];
    } else {
        // Fallback on earlier versions
    }
    [self addSubview:backView];
    self.backView = backView;
    [self.backView.layer setCornerRadius:6.0f];
    
    UILabel *title = [[UILabel alloc] init];
    [title setFont:[UIFont boldSystemFontOfSize:14]];
    [backView addSubview:title];
    self.bigtitleLabel = title;
    [title setText:@"停水通知"];
    
    UILabel *subLabel = [[UILabel alloc] init];
    [subLabel setFont:[UIFont systemFontOfSize:14]];
    [backView addSubview:subLabel];
    self.subtitleLabel = subLabel;
    [subLabel setText:@"关于3栋4栋下午停水通知"];
    
    UILabel *time = [[UILabel alloc] init];
    [time setFont:[UIFont systemFontOfSize:12]];
    if (@available(iOS 13.0, *)) {
        [time setTextColor:[UIColor systemGray2Color]];
    } else {
        // Fallback on earlier versions
    }
    [backView addSubview:time];
    self.timeLabel = time;
    [time setText:@"3小时前"];
    [time setTextAlignment:NSTextAlignmentRight];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    if (@available(iOS 13.0, *)) {
        [imageView setImage:[UIImage systemImageNamed:@"wifi.slash"]];
    } else {
        // Fallback on earlier versions
    }
    [imageView setContentMode:UIViewContentModeCenter];
    imageView.backgroundColor = MainGreenColor;
    [backView addSubview:imageView];
    self.bigimageView = imageView;
    [imageView.layer setCornerRadius:6.0f];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backView.frame = CGRectMake(16, 8, CGRectGetWidth(self.frame) -32, CGRectGetHeight(self.frame)-16);
    self.bigtitleLabel.frame = CGRectMake(16, 16, CGRectGetWidth(self.backView.frame) - 100, 24);
    self.subtitleLabel.frame = CGRectMake(CGRectGetMinX(self.bigtitleLabel.frame), CGRectGetMaxY(self.bigtitleLabel.frame), CGRectGetWidth(self.bigtitleLabel.frame), 24);
    self.timeLabel.frame = CGRectMake(CGRectGetWidth(self.backView.bounds) - 100, CGRectGetMinY(self.bigtitleLabel.frame), 84, 14);
    self.bigimageView.frame =CGRectMake(16, CGRectGetMaxY(self.subtitleLabel.frame) + 8, CGRectGetWidth(self.backView.frame) - 32, CGRectGetHeight(self.backView.frame) - 88);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
