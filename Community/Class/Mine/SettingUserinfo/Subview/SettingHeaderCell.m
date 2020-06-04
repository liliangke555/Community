//
//  SettingHeaderCell.m
//  Community
//
//  Created by MAC on 2020/6/1.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "SettingHeaderCell.h"

@implementation SettingHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 68, 68)];
    if (@available(iOS 13.0, *)) {
        [imageView setImage:[UIImage systemImageNamed:@"person.circle"]];
    } else {
        // Fallback on earlier versions
    }
    [self addSubview:imageView];
    
    self.detailTextLabel.font = [UIFont systemFontOfSize:14];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(16, 99, SCREEN_WIDTH, 0.5f)];
    [lineView setBackgroundColor:RGBACOLOR(235, 235, 235, 1)];
    [self addSubview:lineView];
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
