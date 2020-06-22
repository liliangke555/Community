//
//  PrivacyViewCell.m
//  Community
//
//  Created by 大菠萝 on 2020/4/22.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "PrivacyViewCell.h"

@implementation PrivacyViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.textLabel setTextColor:RGBACOLOR(54, 54, 54, 1)];
        [self.detailTextLabel setTextColor:RGBACOLOR(183, 183, 183, 1)];
        [self.detailTextLabel setNumberOfLines:0];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
//        [self setSeparatorInset:UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, 0)];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
