//
//  SettingsUserCell.m
//  Community
//
//  Created by MAC on 2020/6/1.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "SettingsUserCell.h"

@interface SettingsUserCell ()

@end

@implementation SettingsUserCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    [self setupView];
}
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 78, 64)];
    [self addSubview:label];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setTextColor:[UIColor blackColor]];
    self.titleLabel = label;
    
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, 100, 64)];
    [self addSubview:subLabel];
    [subLabel setFont:[UIFont systemFontOfSize:14]];
    [subLabel setTextColor:[UIColor blackColor]];
    self.subTitleLabel = subLabel;
    
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
